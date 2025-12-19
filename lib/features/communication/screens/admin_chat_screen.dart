// ignore_for_file: deprecated_member_use, camel_case_types

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/features/communication/controllers/private_chat_controller.dart';

class Admin_chatscreen extends StatefulWidget {
  const Admin_chatscreen({super.key});

  @override
  Admin_chatscreenState createState() => Admin_chatscreenState();
}

class Admin_chatscreenState extends State<Admin_chatscreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _messageFocusNode = FocusNode();
  late final PrivateChatController _chatController;

  @override
  void initState() {
    super.initState();
    _chatController = Get.find<PrivateChatController>();

    // Listen to message changes and auto-scroll to bottom
    ever(_chatController.currentMessages, (messages) {
      if (messages.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
      }
    });

    // Auto-scroll when keyboard appears
    _messageFocusNode.addListener(() {
      if (_messageFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 400), () {
          _scrollToBottom();
        });
      }
    });

    // Auto-scroll when user starts typing
    _messageController.addListener(() {
      if (_messageFocusNode.hasFocus && _scrollController.hasClients) {
        Future.delayed(const Duration(milliseconds: 100), () {
          _scrollToBottom();
        });
      }
    });

    // Initial scroll to bottom when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _scrollToBottom();
      });
    });
  }

  /// Auto-scroll to bottom like Facebook Messenger
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      try {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        if (maxScrollExtent > 0) {
          _scrollController.animateTo(
            maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      } catch (e) {
        // Handle any scroll errors gracefully
        if (kDebugMode) {
          print('Scroll error: $e');
        }
      }
    }
  }

  /// Send message using the private chat controller
  Future<void> _sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    final selectedConversation = _chatController.selectedConversation.value;
    if (selectedConversation == null) {
      Get.snackbar('Error', 'No conversation selected');
      return;
    }

    try {
      await _chatController.sendMessage(
        recipientId: selectedConversation.participant.id,
        content: message.trim(),
      );
      _messageController.clear();

      // Auto-scroll to bottom after sending message
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    } catch (error) {
      Get.snackbar('Error', 'Failed to send message: $error');
    }
  }

  /// Generate user initials from display name
  /// Generate user initials from display name – 100% crash-proof
  String _getUserInitials(String? displayName) {
    final name = (displayName ?? '').trim();

    if (name.isEmpty) {
      return 'U';
    }

    // Split on whitespace and filter out empty parts
    final parts = name
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();

    if (parts.isEmpty) {
      return 'U';
    }

    if (parts.length >= 2) {
      final first = parts[0][0].toUpperCase();
      final second = parts[1][0].toUpperCase();
      return '$first$second';
    }

    // Single name or single valid part
    return parts[0][0].toUpperCase();
  }

  /// Create avatar widget with initials fallback
  Widget _buildAvatarWidget(
    String? avatarUrl,
    String displayName, {
    double radius = 16,
  }) {
    // Check if it's a demo/placeholder image or invalid URL
    final isDemoImage =
        avatarUrl == null ||
        avatarUrl.isEmpty ||
        avatarUrl.contains('randomuser.me') ||
        avatarUrl.contains('placeholder') ||
        avatarUrl.contains('demo');

    if (!isDemoImage) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(avatarUrl),
        onBackgroundImageError: (error, stackTrace) {
          // If image fails to load, rebuild with initials
          setState(() {});
        },
        child: null,
      );
    } else {
      // Show initials instead of demo image
      final initials = _getUserInitials(displayName);
      return CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.primary.withValues(alpha: 0.8),
        child: Text(
          initials,
          style: TextStyle(
            color: Colors.white,
            fontSize: radius * 0.7,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
  }

  /// Format timestamp for display
  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return DateFormat('HH:mm').format(dateTime);
    } else if (difference.inDays == 1) {
      return 'Yesterday ${DateFormat('HH:mm').format(dateTime)}';
    } else {
      return DateFormat('MMM dd, HH:mm').format(dateTime);
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: Custom_appbar(title: "Chat"),
      body: Column(
        children: [
          // Custom Header Container
          _buildCustomHeader(),
          // Chat messages
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Obx(() {
                  final messages = _chatController.currentMessages;
                  final currentUserId = _chatController.currentUserId.value;

                  if (messages.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: Sizer.wp(80),
                            color: AppColors.textSecondary.withValues(
                              alpha: 0.3,
                            ),
                          ),
                          SizedBox(height: Sizer.hp(16)),
                          Text(
                            'No messages yet',
                            style: AppTextStyle.regular().copyWith(
                              fontSize: Sizer.wp(18),
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: Sizer.hp(8)),
                          Text(
                            'Start the conversation!',
                            style: AppTextStyle.regular().copyWith(
                              fontSize: Sizer.wp(14),
                              color: AppColors.textSecondary.withValues(
                                alpha: 0.7,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 8,
                    ),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message.sender.id == currentUserId;

                      // Convert to UI message format with real user data
                      final chatMessage = ChatMessage(
                        text: message.content,
                        isMe: isMe,
                        time: _formatTime(message.createdAt),
                        avatar: message.sender.profile.profileUrl,
                        displayName: message.sender.profile.displayName,
                      );

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildMessageBubble(chatMessage, index),
                      );
                    },
                  );
                }),
              ),
            ),
          ),
          // Message input area using original design
          Padding(
            padding: EdgeInsets.all(Sizer.wp(16)),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: Sizer.hp(48),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBackground,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.border1,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: Sizer.wp(16)),
                            child: TextField(
                              textAlign: TextAlign.start,
                              controller: _messageController,
                              focusNode: _messageFocusNode,
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Write Something ...',
                                hintStyle: AppTextStyle.regular().copyWith(
                                  fontSize: Sizer.wp(14),
                                  color: AppColors.textSecondary,
                                ),
                                border: InputBorder.none,
                              ),
                              onSubmitted: (value) => _sendMessage(value),
                              onTap: () {
                                // Scroll to bottom when user taps on text field
                                Future.delayed(
                                  const Duration(milliseconds: 300),
                                  () {
                                    _scrollToBottom();
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/icons/add_reaction.svg",
                          height: Sizer.hp(24),
                          width: Sizer.wp(24),
                          color: AppColors.textPrimary,
                        ),
                        SizedBox(width: Sizer.wp(8)),
                        SvgPicture.asset(
                          "assets/icons/attachment.svg",
                          height: Sizer.hp(24),
                          width: Sizer.wp(24),
                          color: AppColors.textPrimary,
                        ),
                        SizedBox(width: Sizer.wp(8)),
                        SvgPicture.asset(
                          "assets/icons/mic.svg",
                          height: Sizer.hp(24),
                          width: Sizer.wp(24),
                          color: AppColors.textPrimary,
                        ),
                        SizedBox(width: Sizer.wp(8)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: Sizer.wp(8)),
                GestureDetector(
                  onTap: () => _sendMessage(_messageController.text),
                  child: Container(
                    height: Sizer.hp(48),
                    width: Sizer.wp(48),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(Sizer.wp(12)),
                    child: SvgPicture.asset(
                      "assets/icons/material-symbols_send.svg",
                      height: Sizer.hp(20),
                      width: Sizer.wp(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build message bubble with proper styling
  Widget _buildMessageBubble(ChatMessage message, int index) {
    // Check if this message should have a tail (last message in a sequence from the same sender)
    bool shouldShowTail = true;
    final messages = _chatController.currentMessages;
    if (index < messages.length - 1) {
      final currentUserId = _chatController.currentUserId.value;
      final nextMessage = messages[index + 1];
      final nextIsMe = nextMessage.sender.id == currentUserId;
      shouldShowTail = nextIsMe != message.isMe;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: message.isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!message.isMe) ...[
            _buildAvatarWidget(message.avatar, message.displayName),
            // const SizedBox(width: 8 ),
          ],
          Flexible(
            child: BubbleNormal(
              text: message.text,
              isSender: message.isMe,
              color: AppColors.border3,
              tail: shouldShowTail,
              textStyle: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                height: 1.3,
              ),
              bubbleRadius: 8,
            ),
          ),
          if (message.isMe) ...[
            // const SizedBox(width: 8),
            _buildAvatarWidget(message.avatar, message.displayName),
          ],
        ],
      ),
    );
  }

  Widget _buildCustomHeader() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.border3,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(Sizer.wp(16)),
        child: Obx(() {
          final selectedConversation =
              _chatController.selectedConversation.value;
          final participantName =
              selectedConversation?.participant.profile.displayName
                      .trim()
                      .isNotEmpty ==
                  true
              ? selectedConversation!.participant.profile.displayName
              : 'User';
          final participantAvatar =
              selectedConversation?.participant.profile.profileUrl;

          return Row(
            children: [
              // Profile avatar
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: Sizer.wp(40),
                    height: Sizer.wp(40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFE8E8EE),
                      // border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: ClipOval(
                      child: _buildAvatarWidget(
                        participantAvatar,
                        participantName,
                        radius: 18,
                      ),
                    ),
                  ),
                  Container(
                    width: Sizer.wp(10),
                    height: Sizer.wp(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryBackground,
                        width: 1,
                      ),
                      shape: BoxShape.circle,
                      color: AppColors.progresstext,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              // Name and status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      participantName,
                      style: const TextStyle(
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Online',
                      style: TextStyle(
                        color: Color(0xFF4A90E2),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

/// Simple message model for UI compatibility
class ChatMessage {
  final String text;
  final bool isMe;
  final String time;
  final String? avatar;
  final String displayName;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
    this.avatar,
    required this.displayName,
  });
}
