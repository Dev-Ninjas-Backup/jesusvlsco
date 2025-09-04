import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/features/communication/model/private_chat_models.dart'
    as chat_models;
import 'package:jesusvlsco/features/communication/services/private_chat_websocket_service.dart';

/// Private Chat Controller
/// Manages the business logic for private chat functionality
/// Handles message sending, conversation management, and UI state
class PrivateChatController extends GetxController {
  final Logger _logger = Logger();
  final PrivateChatWebSocketService _webSocketService =
      PrivateChatWebSocketService();

  // Observable state variables
  final isLoading = false.obs;
  final isConnecting = false.obs;
  final connectionState = chat_models.ConnectionState.disconnected.obs;
  final currentUserId = Rx<String?>(null);
  final currentUserRole = Rx<chat_models.UserRole?>(null);
  final conversations = <chat_models.PrivateChatConversation>[].obs;
  final selectedConversation = Rx<chat_models.PrivateChatConversation?>(null);
  final currentMessages = <chat_models.PrivateChatMessage>[].obs;
  final searchQuery = ''.obs;
  final unreadCount = 0.obs;

  // Message input controller
  final messageController = TextEditingController();

  // Stream subscriptions
  StreamSubscription<chat_models.PrivateChatMessage>? _newMessageSubscription;
  StreamSubscription<List<chat_models.PrivateChatConversation>>?
  _newConversationSubscription;
  StreamSubscription<chat_models.PrivateChatError>? _errorSubscription;

  @override
  void onInit() {
    super.onInit();
    _initializeController();
  }

  @override
  void onClose() {
    _disposeController();
    super.onClose();
  }

  /// Initialize controller and set up listeners
  Future<void> _initializeController() async {
    try {
      _logger.i('🚀 Initializing Private Chat Controller');

      // Get current user information
      await _loadCurrentUserInfo();

      // Set up reactive listeners
      _setupReactiveListeners();

      // Set up WebSocket event listeners
      _setupWebSocketListeners();

      // Connect to WebSocket
      await connectToChat();
    } catch (error) {
      _logger.e('❌ Error initializing private chat controller: $error');
      EasyLoading.showError('Failed to initialize chat');
    }
  }

  /// Load current user information from storage
  Future<void> _loadCurrentUserInfo() async {
    try {
      final String? userId = await StorageService.getId();
      final String? userRole = await _getUserRole();

      if (userId != null) {
        currentUserId.value = userId;
        _logger.i('👤 Current User ID: $userId');
      }

      if (userRole != null) {
        currentUserRole.value = chat_models.UserRoleExtension.fromString(
          userRole,
        );
        _logger.i('👤 Current User Role: $userRole');
      }
    } catch (error) {
      _logger.e('❌ Error loading user info: $error');
    }
  }

  /// Get user role from storage
  //ToDo: Implement user role retrieval from storage
  Future<String?> _getUserRole() async {
    try {
      // You can implement this based on your existing user storage
      // For now, return a default role
      return 'ADMIN'; // This should come from your user storage
    } catch (error) {
      _logger.e('❌ Error getting user role: $error');
      return null;
    }
  }

  /// Set up reactive listeners for state changes
  void _setupReactiveListeners() {
    // Listen to WebSocket service connection state changes
    ever(_webSocketService.connectionStateObservable, (
      chat_models.ConnectionState state,
    ) {
      _logger.i('🔄 Connection state changed to: $state');
      connectionState.value = state;
      // Remove EasyLoading dismiss here - let UI handle connection status
    });

    // Listen to conversation changes to update unread count
    ever(conversations, (List<chat_models.PrivateChatConversation> convs) {
      _updateUnreadCount();
    });
  }

  /// Set up WebSocket event listeners
  void _setupWebSocketListeners() {
    // Listen for new messages
    _newMessageSubscription = _webSocketService.newMessageStream.listen(
      (chat_models.PrivateChatMessage message) {
        _handleNewMessage(message);
      },
      onError: (error) {
        _logger.e('❌ Error in new message stream: $error');
      },
    );

    // Listen for conversation updates
    _newConversationSubscription = _webSocketService.newConversationStream.listen(
      (List<chat_models.PrivateChatConversation> convs) {
        _logger.i('🔄 Received ${convs.length} conversations from WebSocket');
        conversations.assignAll(convs);

        // If we have a selected conversation, reload its messages to get the latest history
        if (selectedConversation.value != null) {
          final messages = _webSocketService.getMessagesForConversation(
            selectedConversation.value!.chatId,
          );
          currentMessages.assignAll(messages);
        }

        // Update loading state
        isLoading.value = false;

        _updateUnreadCount();
      },
      onError: (error) {
        _logger.e('❌ Error in conversation stream: $error');
        isLoading.value = false;
      },
    );

    // Listen for errors
    _errorSubscription = _webSocketService.errorStream.listen(
      (chat_models.PrivateChatError error) {
        _logger.e('❌ WebSocket error: ${error.message}');
        EasyLoading.showError(error.message);
      },
      onError: (error) {
        _logger.e('❌ Error in error stream: $error');
      },
    );
  }

  /// Connect to chat WebSocket
  Future<void> connectToChat() async {
    try {
      isConnecting.value = true;
      isLoading.value = true; // Set loading state for conversations

      await _webSocketService.connect();

      // Update reactive state based on service state
      connectionState.value = _webSocketService.connectionState;

      // Don't immediately assign conversations here, let the stream listener handle it
      // This ensures the UI updates properly when conversations are loaded
      _logger.i('🔗 WebSocket connected, waiting for conversations...');
    } catch (error) {
      _logger.e('❌ Error connecting to chat: $error');
      EasyLoading.showError('Failed to connect to chat');
      isLoading.value = false;
    } finally {
      isConnecting.value = false;
    }
  }

  /// Disconnect from chat WebSocket
  Future<void> disconnectFromChat() async {
    try {
      await _webSocketService.disconnect();
      connectionState.value = chat_models.ConnectionState.disconnected;
      conversations.clear();
      currentMessages.clear();
      selectedConversation.value = null;
    } catch (error) {
      _logger.e('❌ Error disconnecting from chat: $error');
    }
  }

  /// Load conversations from server
  Future<void> loadConversations() async {
    try {
      isLoading.value = true;
      _webSocketService.loadConversations();

      // The conversations will be updated via the stream listener
      // when the WebSocket service receives the response
      _logger.i('📤 Requested conversation list from server');
    } catch (error) {
      _logger.e('❌ Error loading conversations: $error');
      EasyLoading.showError('Failed to load conversations');
      isLoading.value = false;
    }
  }

  /// Send a message to a recipient
  /// [recipientId] - ID of the message recipient
  /// [content] - Message content (optional, uses messageController if not provided)
  Future<void> sendMessage({
    required String recipientId,
    String? content,
  }) async {
    try {
      final messageContent = content ?? messageController.text.trim();

      if (messageContent.isEmpty) {
        EasyLoading.showInfo('Please enter a message');
        return;
      }

      // Check business rules before sending
      if (!_canSendMessageTo(recipientId)) {
        EasyLoading.showError('You cannot send messages to this user');
        return;
      }

      // Send message via WebSocket
      await _webSocketService.sendMessage(
        recipientId: recipientId,
        content: messageContent,
      );

      // Clear message input
      messageController.clear();

      _logger.i('✅ Message sent successfully to $recipientId');
    } catch (error) {
      _logger.e('❌ Error sending message: $error');
      EasyLoading.showError('Failed to send message');
    }
  }

  /// Select a conversation for viewing
  /// [conversation] - The conversation to select
  void selectConversation(chat_models.PrivateChatConversation conversation) {
    selectedConversation.value = conversation;

    // Load full conversation history from server
    loadConversationHistory(conversation.chatId);

    _logger.i(
      '📂 Selected conversation with ${conversation.participant.profile.displayName}',
    );
  }

  /// Load full conversation history for a specific conversation
  /// [conversationId] - ID of the conversation to load
  void loadConversationHistory(String conversationId) {
    try {
      if (conversationId.trim().isEmpty) {
        _logger.w('⚠️ Cannot load conversation - conversation ID is empty');
        return;
      }

      // Load messages from local cache first
      final cachedMessages = _webSocketService.getMessagesForConversation(
        conversationId,
      );
      currentMessages.assignAll(cachedMessages);

      // Request full conversation history from server
      _webSocketService.loadSingleConversation(conversationId);

      _logger.i('� Loading conversation history for: $conversationId');
    } catch (error) {
      _logger.e('❌ Error loading conversation history: $error');
      EasyLoading.showError('Failed to load conversation history');
    }
  }

  /// Start a new conversation with a user
  /// [recipientId] - ID of the user to start conversation with
  /// [firstMessage] - The first message to send
  Future<void> startNewConversation({
    required String recipientId,
    required String firstMessage,
  }) async {
    try {
      // Check business rules before starting conversation
      if (!_canStartConversationWith(recipientId)) {
        EasyLoading.showError('You cannot start a conversation with this user');
        return;
      }

      // Send the first message (this will create the conversation)
      await sendMessage(recipientId: recipientId, content: firstMessage);

      _logger.i('✅ Started new conversation with $recipientId');
    } catch (error) {
      _logger.e('❌ Error starting new conversation: $error');
      EasyLoading.showError('Failed to start conversation');
    }
  }

  /// Handle new message received
  void _handleNewMessage(chat_models.PrivateChatMessage message) {
    _logger.i(
      '📩 Handling new message from ${message.sender.profile.displayName}',
    );

    // Update current messages if this message belongs to selected conversation
    if (selectedConversation.value?.chatId == message.conversationId) {
      // Remove duplicate messages by ID
      currentMessages.removeWhere((msg) => msg.id == message.id);
      currentMessages.add(message);

      // Sort messages by creation time
      currentMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }

    // Update conversations list
    conversations.assignAll(_webSocketService.conversations);
    _updateUnreadCount();
  }

  /// Check if current user can send message to recipient
  bool _canSendMessageTo(String recipientId) {
    if (currentUserId.value == null || currentUserRole.value == null) {
      return false;
    }

    if (recipientId == currentUserId.value) {
      return false; // Cannot send to self
    }

    // Add your business logic here based on recipient's role
    // For now, allow all communications for admins
    return currentUserRole.value == chat_models.UserRole.admin ||
        currentUserRole.value == chat_models.UserRole.superadmin;
  }

  /// Check if current user can start conversation with recipient
  bool _canStartConversationWith(String recipientId) {
    return _canSendMessageTo(recipientId);
  }

  /// Update unread messages count
  void _updateUnreadCount() {
    final unread = conversations.where((conv) => !conv.isRead).length;
    unreadCount.value = unread;
  }

  /// Get filtered conversations based on search query, sorted by most recent
  List<chat_models.PrivateChatConversation> get filteredConversations {
    List<chat_models.PrivateChatConversation> result;

    if (searchQuery.value.isEmpty) {
      result = conversations.toList();
    } else {
      final query = searchQuery.value.toLowerCase();
      result = conversations.where((conversation) {
        final participantName = conversation.participant.profile.displayName
            .toLowerCase();
        final lastMessageContent = conversation.lastMessage.content
            .toLowerCase();
        return participantName.contains(query) ||
            lastMessageContent.contains(query);
      }).toList();
    }

    // Sort by most recent message first (real-time sorting)
    result.sort(
      (a, b) => b.lastMessage.createdAt.compareTo(a.lastMessage.createdAt),
    );

    return result;
  }

  /// Check if user is online (placeholder for future implementation)
  //ToDo: Implement user online status retrieval
  bool isUserOnline(String userId) {
    // This would need to be implemented based on your backend's presence system
    return false;
  }

  /// Get last seen time for user (placeholder for future implementation)
  //ToDo: Implement user last seen time retrieval
  String getLastSeen(String userId) {
    // This would need to be implemented based on your backend's presence system
    return 'Last seen recently';
  }

  /// Clear all chat data
  void clearChatData() {
    conversations.clear();
    currentMessages.clear();
    selectedConversation.value = null;
    messageController.clear();
    searchQuery.value = '';
    unreadCount.value = 0;
  }

  /// Dispose controller resources
  void _disposeController() {
    _newMessageSubscription?.cancel();
    _newConversationSubscription?.cancel();
    _errorSubscription?.cancel();
    messageController.dispose();
    _webSocketService.dispose();
  }

  /// Refresh chat data
  Future<void> refreshChat() async {
    await loadConversations();
  }

  /// Check connection status
  bool get isConnected =>
      connectionState.value == chat_models.ConnectionState.connected;

  /// Get connection status text
  String get connectionStatusText {
    switch (connectionState.value) {
      case chat_models.ConnectionState.connected:
        return 'Online';
      case chat_models.ConnectionState.connecting:
        return 'Connecting...';
      case chat_models.ConnectionState.disconnected:
        return 'Offline';
      case chat_models.ConnectionState.error:
        return 'Connection Error';
    }
  }
}
