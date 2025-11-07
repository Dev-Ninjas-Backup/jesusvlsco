// ignore_for_file: library_prefixes

import 'dart:async';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';
import 'package:jesusvlsco/features/communication/model/private_chat_models.dart';

/// Private Chat WebSocket Service
/// Manages WebSocket connection for private chat functionality
/// Implements all events according to websocket.md documentation
class PrivateChatWebSocketService {
  static final PrivateChatWebSocketService _instance =
      PrivateChatWebSocketService._internal();
  factory PrivateChatWebSocketService() => _instance;
  PrivateChatWebSocketService._internal();

  final Logger _logger = Logger();
  IO.Socket? _socket;

  // Observable streams for real-time updates
  final _connectionState = ConnectionState.disconnected.obs;
  final _currentUserId = Rx<String?>(null);
  final _conversations = <PrivateChatConversation>[].obs;
  final _messages = <String, List<PrivateChatMessage>>{}.obs;
  final _errors = <PrivateChatError>[].obs;

  // Stream controllers for specific events
  final _newMessageController =
      StreamController<PrivateChatMessage>.broadcast();
  final _newConversationController =
      StreamController<List<PrivateChatConversation>>.broadcast();
  final _errorController = StreamController<PrivateChatError>.broadcast();

  // Getters for reactive state
  ConnectionState get connectionState => _connectionState.value;
  Rx<ConnectionState> get connectionStateObservable => _connectionState;
  String? get currentUserId => _currentUserId.value;
  List<PrivateChatConversation> get conversations => _conversations.toList();
  List<PrivateChatError> get errors => _errors.toList();

  // Stream getters for listening to events
  Stream<PrivateChatMessage> get newMessageStream =>
      _newMessageController.stream;
  Stream<List<PrivateChatConversation>> get newConversationStream =>
      _newConversationController.stream;
  Stream<PrivateChatError> get errorStream => _errorController.stream;

  /// Initialize and connect to private chat WebSocket
  /// Uses JWT token from storage for authentication
  Future<void> connect() async {
    try {
      _connectionState.value = ConnectionState.connecting;
      _logger.i('🔌 Connecting to private chat WebSocket...');

      // Get authentication token from storage
      final String? token = await StorageService.getAuthToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      // Disconnect existing connection if any
      await disconnect();

      // Create socket connection to private namespace
      _socket = IO.io(
        '${ApiConstants.baseurl}/private',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .setAuth({'token': 'Bearer $token'})
            .build(),
      );

      // Set up event listeners
      _setupEventListeners();

      _logger.i('✅ Private chat WebSocket connection initiated');
    } catch (error) {
      _logger.e('❌ Failed to connect to private chat WebSocket: $error');
      _connectionState.value = ConnectionState.error;
      _addError(PrivateChatError(message: 'Connection failed: $error'));
    }
  }

  /// Set up all WebSocket event listeners according to documentation
  void _setupEventListeners() {
    if (_socket == null) return;

    // Connection events
    _socket!.onConnect((_) {
      _logger.i('✅ Connected to private chat server');
      _connectionState.value = ConnectionState.connected;
    });

    _socket!.onDisconnect((reason) {
      _logger.w('❌ Disconnected from private chat server: $reason');
      _connectionState.value = ConnectionState.disconnected;
    });

    _socket!.onConnectError((error) {
      _logger.e('⚠️ Private chat connection error: $error');
      _connectionState.value = ConnectionState.error;
      _addError(PrivateChatError(message: 'Connection error: $error'));
    });

    // Private chat specific events
    _socket!.on(PrivateChatEvents.success.value, _handleSuccess);
    _socket!.on(PrivateChatEvents.error.value, _handleError);
    _socket!.on(
      PrivateChatEvents.conversationList.value,
      _handleConversationList,
    );
    _socket!.on(PrivateChatEvents.newMessage.value, _handleNewMessage);
    _socket!.on(
      PrivateChatEvents.newConversation.value,
      _handleNewConversation,
    );
  }

  /// Handle successful authentication
  /// Stores the authenticated user ID
  void _handleSuccess(dynamic data) {
    try {
      final String userId = data.toString();
      _currentUserId.value = userId;
      _logger.i('✅ Authenticated successfully as user: $userId');

      // Load conversations after successful authentication
      loadConversations();
    } catch (error) {
      _logger.e('❌ Error handling success event: $error');
    }
  }

  /// Handle WebSocket errors
  void _handleError(dynamic data) {
    try {
      final error = PrivateChatError.fromJson(data as Map<String, dynamic>);
      _logger.e('❌ Private chat error: ${error.message}');
      _addError(error);
      _errorController.add(error);
    } catch (error) {
      _logger.e('❌ Error parsing error event: $error');
      final fallbackError = PrivateChatError(message: 'Unknown error occurred');
      _addError(fallbackError);
      _errorController.add(fallbackError);
    }
  }

  /// Handle conversation list response
  void _handleConversationList(dynamic data) {
    try {
      final List<dynamic> conversationList = data as List<dynamic>;
      final conversations = conversationList
          .map(
            (json) =>
                PrivateChatConversation.fromJson(json as Map<String, dynamic>),
          )
          .toList();

      _conversations.assignAll(conversations);
      _logger.i('📄 Loaded ${conversations.length} conversations');

      // Notify listeners about the loaded conversations
      _newConversationController.add(conversations);
    } catch (error) {
      _logger.e('❌ Error parsing conversation list: $error');
    }
  }

  /// Handle new message event
  /// Updates message list and triggers UI updates
  void _handleNewMessage(dynamic data) {
    try {
      final message = PrivateChatMessage.fromJson(data as Map<String, dynamic>);
      _logger.i(
        '📩 New message received from ${message.sender.profile.displayName}',
      );

      // Add message to conversation messages
      final conversationId = message.conversationId;
      if (!_messages.containsKey(conversationId)) {
        _messages[conversationId] = [];
      }

      // Remove duplicate messages by ID
      _messages[conversationId]!.removeWhere((msg) => msg.id == message.id);
      _messages[conversationId]!.add(message);

      // Sort messages by creation time
      _messages[conversationId]!.sort(
        (a, b) => a.createdAt.compareTo(b.createdAt),
      );

      // Update conversation list with new last message
      _updateConversationLastMessage(message);

      // Notify listeners
      _newMessageController.add(message);
    } catch (error) {
      _logger.e('❌ Error parsing new message: $error');
    }
  }

  /// Handle new conversation event
  /// Can receive either:
  /// 1. Array of conversations (refreshed list)
  /// 2. Single conversation object with full message history
  void _handleNewConversation(dynamic data) {
    try {
      if (data is List) {
        // Array payload - refreshed conversation list
        final conversationList = data;
        final conversations = conversationList
            .map(
              (json) => PrivateChatConversation.fromJson(
                json as Map<String, dynamic>,
              ),
            )
            .toList();

        _conversations.assignAll(conversations);
        _logger.i(
          '🆕 Updated conversation list with ${conversations.length} conversations',
        );

        // Notify listeners
        _newConversationController.add(conversations);
      } else if (data is Map<String, dynamic> &&
          data.containsKey('conversationId')) {
        // Single conversation object with full message history
        final fullConversation = PrivateChatFullConversation.fromJson(data);
        _logger.i(
          '📂 Loaded single conversation: ${fullConversation.conversationId}',
        );

        // Store messages for this conversation
        _messages[fullConversation.conversationId] = fullConversation.messages;

        // Update or add conversation summary to the list
        _updateConversationSummary(fullConversation);

        // Notify listeners about the updated conversation list
        _newConversationController.add(_conversations.toList());
      } else {
        _logger.w(
          '🆕 Received new_conversation with unknown payload format: $data',
        );
      }
    } catch (error) {
      _logger.e('❌ Error parsing new conversation: $error');
    }
  }

  /// Update conversation summary from full conversation data
  void _updateConversationSummary(
    PrivateChatFullConversation fullConversation,
  ) {
    // Find if conversation already exists in list
    final existingIndex = _conversations.indexWhere(
      (conv) => conv.chatId == fullConversation.conversationId,
    );

    // Get the last message from the full conversation
    final lastMessage = fullConversation.messages.isNotEmpty
        ? fullConversation.messages.last
        : null;

    if (existingIndex != -1 && lastMessage != null) {
      // Update existing conversation with new last message
      final existingConv = _conversations[existingIndex];
      final updatedConv = PrivateChatConversation(
        type: existingConv.type,
        chatId: existingConv.chatId,
        participant: existingConv.participant,
        lastMessage: lastMessage,
        updatedAt: lastMessage.createdAt,
        isRead: existingConv.isRead,
      );
      _conversations[existingIndex] = updatedConv;
    } else if (lastMessage != null &&
        fullConversation.participants.length >= 2) {
      // Create new conversation summary if it doesn't exist
      // Find the other participant (not current user)
      final otherParticipant = fullConversation.participants.firstWhere(
        (p) => p.id != _currentUserId.value,
        orElse: () => fullConversation.participants.first,
      );

      final newConv = PrivateChatConversation(
        type: 'private',
        chatId: fullConversation.conversationId,
        participant: PrivateChatParticipant(
          id: otherParticipant.id,
          profile: otherParticipant.profile,
        ),
        lastMessage: lastMessage,
        updatedAt: lastMessage.createdAt,
        isRead: false,
      );
      _conversations.add(newConv);
    }
  }

  /// Load conversations from server
  /// Emits load_conversations event
  void loadConversations() {
    if (_socket?.connected != true) {
      _logger.w('⚠️ Cannot load conversations - not connected to server');
      return;
    }

    _socket!.emit(PrivateChatEvents.loadConversations.value);
    _logger.i('📤 Requested conversation list');
  }

  /// Load single conversation with full message history
  /// [conversationId] - ID of the conversation to load
  void loadSingleConversation(String conversationId) {
    if (_socket?.connected != true) {
      _logger.w('⚠️ Cannot load single conversation - not connected to server');
      return;
    }

    if (conversationId.trim().isEmpty) {
      _logger.w('⚠️ Cannot load conversation - conversation ID is empty');
      return;
    }

    _socket!.emit(
      PrivateChatEvents.loadSingleConversation.value,
      conversationId.trim(),
    );
    _logger.i('📤 Requesting conversation history for: $conversationId');
  }

  /// Send a private message
  /// [recipientId] - ID of the message recipient
  /// [content] - Message content to send
  /// [file] - Optional file attachment
  Future<void> sendMessage({
    required String recipientId,
    required String content,
    PrivateChatFile? file,
  }) async {
    try {
      if (_socket?.connected != true) {
        throw Exception('Not connected to server');
      }

      if (_currentUserId.value == null) {
        throw Exception('User not authenticated');
      }

      if (recipientId == _currentUserId.value) {
        throw Exception('Cannot send message to yourself');
      }

      if (content.trim().isEmpty) {
        throw Exception('Message content cannot be empty');
      }

      // Create message request according to documentation
      final request = SendMessageRequest(
        userId: _currentUserId.value!,
        recipientId: recipientId,
        dto: MessageDto(content: content.trim()),
        file: file,
      );

      // Emit message to server
      _socket!.emit(PrivateChatEvents.sendMessage.value, request.toJson());
      _logger.i(
        '📤 Sent message to $recipientId: ${content.substring(0, content.length.clamp(0, 50))}...',
      );
    } catch (error) {
      _logger.e('❌ Error sending message: $error');
      _addError(PrivateChatError(message: 'Failed to send message: $error'));
      rethrow;
    }
  }

  /// Get messages for a specific conversation
  /// [conversationId] - ID of the conversation
  List<PrivateChatMessage> getMessagesForConversation(String conversationId) {
    return _messages[conversationId] ?? [];
  }

  /// Get conversation by participant ID
  /// [participantId] - ID of the conversation participant
  PrivateChatConversation? getConversationByParticipant(String participantId) {
    try {
      return _conversations.firstWhere(
        (conversation) => conversation.participant.id == participantId,
      );
    } catch (e) {
      return null;
    }
  }

  /// Update conversation last message
  void _updateConversationLastMessage(PrivateChatMessage message) {
    final conversationIndex = _conversations.indexWhere(
      (conv) => conv.chatId == message.conversationId,
    );

    if (conversationIndex != -1) {
      // Create updated conversation with new last message
      final updatedConversation = PrivateChatConversation(
        type: _conversations[conversationIndex].type,
        chatId: _conversations[conversationIndex].chatId,
        participant: _conversations[conversationIndex].participant,
        lastMessage: message,
        updatedAt: message.createdAt,
        isRead: message.isSentByMe(_currentUserId.value ?? ''),
      );

      _conversations[conversationIndex] = updatedConversation;
    }
  }

  /// Add error to error list
  void _addError(PrivateChatError error) {
    _errors.add(error);

    // Limit error list size
    if (_errors.length > 10) {
      _errors.removeAt(0);
    }
  }

  /// Clear all errors
  void clearErrors() {
    _errors.clear();
  }

  /// Disconnect from WebSocket
  Future<void> disconnect() async {
    try {
      if (_socket != null) {
        _socket!.disconnect();
        _socket!.dispose();
        _socket = null;
        _logger.i('🔌 Disconnected from private chat WebSocket');
      }

      _connectionState.value = ConnectionState.disconnected;
      _currentUserId.value = null;
    } catch (error) {
      _logger.e('❌ Error disconnecting from WebSocket: $error');
    }
  }

  /// Clean up resources
  void dispose() {
    disconnect();
    _newMessageController.close();
    _newConversationController.close();
    _errorController.close();
  }
}
