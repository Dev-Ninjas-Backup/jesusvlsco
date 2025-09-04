/// Private chat message model
/// Contains all message information including sender details and metadata
class PrivateChatMessage {
  final String id;
  final String content;
  final String conversationId;
  final String senderId;
  final String? fileId;
  final bool isRead;
  final DateTime createdAt;
  final PrivateChatSender sender;
  final PrivateChatFile? file;

  const PrivateChatMessage({
    required this.id,
    required this.content,
    required this.conversationId,
    required this.senderId,
    this.fileId,
    required this.isRead,
    required this.createdAt,
    required this.sender,
    this.file,
  });

  /// Create PrivateChatMessage from JSON
  factory PrivateChatMessage.fromJson(Map<String, dynamic> json) {
    return PrivateChatMessage(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      conversationId: json['conversationId'] ?? '',
      senderId: json['senderId'] ?? '',
      fileId: json['fileId'],
      isRead: json['isRead'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      sender: PrivateChatSender.fromJson(json['sender'] ?? {}),
      file: json['file'] != null
          ? PrivateChatFile.fromJson(json['file'])
          : null,
    );
  }

  /// Convert PrivateChatMessage to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'conversationId': conversationId,
      'senderId': senderId,
      'fileId': fileId,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
      'sender': sender.toJson(),
      'file': file?.toJson(),
    };
  }

  /// Check if message is sent by current user
  bool isSentByMe(String currentUserId) => senderId == currentUserId;
}

/// Private chat sender model
/// Contains sender information including profile details
class PrivateChatSender {
  final String id;
  final PrivateChatProfile profile;

  const PrivateChatSender({required this.id, required this.profile});

  /// Create PrivateChatSender from JSON
  factory PrivateChatSender.fromJson(Map<String, dynamic> json) {
    return PrivateChatSender(
      id: json['id'] ?? '',
      profile: PrivateChatProfile.fromJson(json['profile'] ?? {}),
    );
  }

  /// Convert PrivateChatSender to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'profile': profile.toJson()};
  }
}

/// Private chat profile model
/// Contains user profile information for display
class PrivateChatProfile {
  final String? profileUrl;
  final String firstName;
  final String lastName;

  const PrivateChatProfile({
    this.profileUrl,
    required this.firstName,
    required this.lastName,
  });

  /// Create PrivateChatProfile from JSON
  factory PrivateChatProfile.fromJson(Map<String, dynamic> json) {
    return PrivateChatProfile(
      profileUrl: json['profileUrl'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }

  /// Convert PrivateChatProfile to JSON
  Map<String, dynamic> toJson() {
    return {
      'profileUrl': profileUrl,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  /// Get full name from first and last name
  String get fullName => '$firstName $lastName'.trim();

  /// Get display name (fallback to first name if last name is empty)
  String get displayName => fullName.isNotEmpty ? fullName : firstName;
}

/// Private chat file model
/// Contains file attachment information
class PrivateChatFile {
  final String id;
  final String fileName;
  final String fileUrl;
  final String fileType;
  final int fileSize;

  const PrivateChatFile({
    required this.id,
    required this.fileName,
    required this.fileUrl,
    required this.fileType,
    required this.fileSize,
  });

  /// Create PrivateChatFile from JSON
  factory PrivateChatFile.fromJson(Map<String, dynamic> json) {
    return PrivateChatFile(
      id: json['id'] ?? '',
      fileName: json['fileName'] ?? '',
      fileUrl: json['fileUrl'] ?? '',
      fileType: json['fileType'] ?? '',
      fileSize: json['fileSize'] ?? 0,
    );
  }

  /// Convert PrivateChatFile to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileName': fileName,
      'fileUrl': fileUrl,
      'fileType': fileType,
      'fileSize': fileSize,
    };
  }
}

/// Private chat conversation model
/// Contains conversation information with participant details
class PrivateChatConversation {
  final String type;
  final String chatId;
  final PrivateChatParticipant participant;
  final PrivateChatMessage lastMessage;
  final DateTime updatedAt;
  final bool isRead;

  const PrivateChatConversation({
    required this.type,
    required this.chatId,
    required this.participant,
    required this.lastMessage,
    required this.updatedAt,
    required this.isRead,
  });

  /// Create PrivateChatConversation from JSON
  factory PrivateChatConversation.fromJson(Map<String, dynamic> json) {
    return PrivateChatConversation(
      type: json['type'] ?? '',
      chatId: json['chatId'] ?? '',
      participant: PrivateChatParticipant.fromJson(json['participant'] ?? {}),
      lastMessage: PrivateChatMessage.fromJson(json['lastMessage'] ?? {}),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      isRead: json['isRead'] ?? false,
    );
  }

  /// Convert PrivateChatConversation to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'chatId': chatId,
      'participant': participant.toJson(),
      'lastMessage': lastMessage.toJson(),
      'updatedAt': updatedAt.toIso8601String(),
      'isRead': isRead,
    };
  }
}

/// Private chat participant model
/// Contains participant information in a conversation
class PrivateChatParticipant {
  final String id;
  final PrivateChatProfile profile;

  const PrivateChatParticipant({required this.id, required this.profile});

  /// Create PrivateChatParticipant from JSON
  factory PrivateChatParticipant.fromJson(Map<String, dynamic> json) {
    return PrivateChatParticipant(
      id: json['id'] ?? '',
      profile: PrivateChatProfile.fromJson(json['profile'] ?? {}),
    );
  }

  /// Convert PrivateChatParticipant to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'profile': profile.toJson()};
  }
}

/// Send message request model
/// Contains information needed to send a message
class SendMessageRequest {
  final String userId;
  final String recipientId;
  final MessageDto dto;
  final PrivateChatFile? file;

  const SendMessageRequest({
    required this.userId,
    required this.recipientId,
    required this.dto,
    this.file,
  });

  /// Create SendMessageRequest from JSON
  factory SendMessageRequest.fromJson(Map<String, dynamic> json) {
    return SendMessageRequest(
      userId: json['userId'] ?? '',
      recipientId: json['recipientId'] ?? '',
      dto: MessageDto.fromJson(json['dto'] ?? {}),
      file: json['file'] != null
          ? PrivateChatFile.fromJson(json['file'])
          : null,
    );
  }

  /// Convert SendMessageRequest to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'recipientId': recipientId,
      'dto': dto.toJson(),
      'file': file?.toJson(),
    };
  }
}

/// Message DTO for sending messages
/// Contains the actual message content
class MessageDto {
  final String content;

  const MessageDto({required this.content});

  /// Create MessageDto from JSON
  factory MessageDto.fromJson(Map<String, dynamic> json) {
    return MessageDto(content: json['content'] ?? '');
  }

  /// Convert MessageDto to JSON
  Map<String, dynamic> toJson() {
    return {'content': content};
  }
}

/// Full conversation with participants and message history
/// Used for private:load_single_conversation response
class PrivateChatFullConversation {
  final String conversationId;
  final List<PrivateChatSender> participants;
  final List<PrivateChatMessage> messages;

  const PrivateChatFullConversation({
    required this.conversationId,
    required this.participants,
    required this.messages,
  });

  /// Create PrivateChatFullConversation from JSON
  factory PrivateChatFullConversation.fromJson(Map<String, dynamic> json) {
    return PrivateChatFullConversation(
      conversationId: json['conversationId'] ?? '',
      participants:
          (json['participants'] as List<dynamic>?)
              ?.map(
                (p) => PrivateChatSender.fromJson(p as Map<String, dynamic>),
              )
              .toList() ??
          [],
      messages:
          (json['messages'] as List<dynamic>?)
              ?.map(
                (m) => PrivateChatMessage.fromJson(m as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  /// Convert PrivateChatFullConversation to JSON
  Map<String, dynamic> toJson() {
    return {
      'conversationId': conversationId,
      'participants': participants.map((p) => p.toJson()).toList(),
      'messages': messages.map((m) => m.toJson()).toList(),
    };
  }
}

/// Private chat events enum
/// Contains all WebSocket event names as specified in documentation
enum PrivateChatEvents {
  error('private:error'),
  success('private:success'),
  newMessage('private:new_message'),
  sendMessage('private:send_message'),
  newConversation('private:new_conversation'),
  conversationList('private:conversation_list'),
  loadConversations('private:load_conversations'),
  loadSingleConversation('private:load_single_conversation');

  const PrivateChatEvents(this.value);
  final String value;
}

/// Private chat error model
/// Contains error information from WebSocket
class PrivateChatError {
  final String message;

  const PrivateChatError({required this.message});

  /// Create PrivateChatError from JSON
  factory PrivateChatError.fromJson(Map<String, dynamic> json) {
    return PrivateChatError(message: json['message'] ?? '');
  }

  /// Convert PrivateChatError to JSON
  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}

/// Connection state enum
/// Represents different states of WebSocket connection
enum ConnectionState { disconnected, connecting, connected, error }

/// User role enum for business logic enforcement
/// Determines who can initiate conversations with whom
enum UserRole { admin, superadmin, employee }

/// Extension to get UserRole from string
extension UserRoleExtension on UserRole {
  /// Get UserRole from string value
  static UserRole fromString(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return UserRole.admin;
      case 'superadmin':
        return UserRole.superadmin;
      case 'employee':
        return UserRole.employee;
      default:
        return UserRole.employee;
    }
  }

  /// Check if this role can initiate conversation with target role
  bool canInitiateWith(UserRole targetRole) {
    switch (this) {
      case UserRole.admin:
      case UserRole.superadmin:
        return true; // Admin/Superadmin can initiate with anyone
      case UserRole.employee:
        return targetRole == UserRole.employee; // Employee only with employee
    }
  }
}
