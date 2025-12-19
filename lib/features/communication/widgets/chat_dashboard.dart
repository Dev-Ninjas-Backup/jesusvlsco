import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/communication/controllers/private_chat_controller.dart';
import 'package:jesusvlsco/features/communication/model/private_chat_models.dart'
    as chat_models;
import 'package:jesusvlsco/features/communication/screens/admin_chat_screen.dart';

class ChatDashboard extends StatelessWidget {
  ChatDashboard({super.key});

  // Get private chat controller
  final PrivateChatController _chatController =
      Get.find<PrivateChatController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizer.wp(16)),
      child: _buildConversationsList(),
    );
  }

  /// Build conversations list
  Widget _buildConversationsList() {
    return Obx(() {
      final conversations = _chatController.filteredConversations;
      final isLoading = _chatController.isLoading.value;

      // Debug logging
      if (kDebugMode) {
        print('🔍 ChatDashboard Debug:');
      }
      if (kDebugMode) {
        print('  - isLoading: $isLoading');
      }
      if (kDebugMode) {
        print('  - conversations count: ${conversations.length}');
      }
      if (kDebugMode) {
        print('  - searchQuery: "${_chatController.searchQuery.value}"');
      }

      if (conversations.isNotEmpty) {
        if (kDebugMode) {
          print(
            '  - First conversation: ${conversations.first.participant.profile.displayName}',
          );
        }
        if (kDebugMode) {
          print('  - Last message: ${conversations.first.lastMessage.content}');
        }
      }

      if (isLoading && conversations.isEmpty) {
        return _buildLoadingState();
      }

      if (conversations.isEmpty) {
        return _buildEmptyState();
      }

      return RefreshIndicator(
        onRefresh: () => _chatController.refreshChat(),
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: conversations.length,
          itemBuilder: (context, index) {
            if (index < 0 || index >= conversations.length) {
              if (kDebugMode) {
                print(
                  '⚠️ Invalid index $index ignored (list length: ${conversations.length})',
                );
              }
              return const SizedBox.shrink();
            }
            final conversation = conversations[index];
            if (kDebugMode) {
              print(
                '  - Building conversation ${index + 1}: ${conversation.participant.profile.displayName}',
              );
            }
            return _buildConversationItem(conversation);
          },
        ),
      );
    });
  }

  /// Build loading state
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          SizedBox(height: Sizer.hp(16)),
          Text(
            'Loading conversations...',
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(14),
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  /// Build empty state
  Widget _buildEmptyState() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.chat_bubble_2,
              size: Sizer.wp(60),
              color: AppColors.textSecondary.withValues(alpha: 0.3),
            ),
            SizedBox(height: Sizer.hp(16)),
            Text(
              'No conversations yet',
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(16),
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: Sizer.hp(8)),
            Text(
              'Start a new conversation to get started',
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(14),
                color: AppColors.textSecondary.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Sizer.hp(20)),
            // Add refresh button
            ElevatedButton.icon(
              onPressed: () {
                if (kDebugMode) {
                  print('🔄 Manual refresh triggered');
                }
                _chatController.refreshChat();
              },
              icon: Icon(Icons.refresh, size: Sizer.wp(18)),
              label: Text('Refresh'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: Sizer.wp(20),
                  vertical: Sizer.hp(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build individual conversation item
  Widget _buildConversationItem(
    chat_models.PrivateChatConversation conversation,
  ) {
    // Add safety checks for null data
    if (conversation.participant.profile.displayName.isEmpty) {
      if (kDebugMode) {
        print('⚠️ Warning: Conversation has empty display name');
      }
      return SizedBox.shrink();
    }

    return InkWell(
      onTap: () => _openConversation(conversation),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Sizer.hp(12),
          horizontal: Sizer.wp(4),
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Profile Avatar
                _buildProfileAvatar(conversation),
                SizedBox(width: Sizer.wp(12)),
                // Message content and info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and timestamp row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Participant name
                          Expanded(
                            child: Text(
                              conversation.participant.profile.displayName,
                              style: AppTextStyle.regular().copyWith(
                                fontSize: Sizer.wp(16),
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Timestamp
                          Text(
                            _formatTimestamp(
                              conversation.lastMessage.createdAt,
                            ),
                            style: AppTextStyle.regular().copyWith(
                              fontSize: Sizer.wp(12),
                              color: AppColors.textSecondary.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Sizer.hp(4)),
                      // Last message preview (removed unread indicator)
                      Text(
                        conversation.lastMessage.content.isNotEmpty
                            ? conversation.lastMessage.content
                            : 'No message content',
                        style: AppTextStyle.regular().copyWith(
                          fontSize: Sizer.wp(14),
                          color: conversation.isRead
                              ? AppColors.textSecondary
                              : AppColors.textPrimary,
                          fontWeight: conversation.isRead
                              ? FontWeight.w400
                              : FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Sizer.hp(12)),
            // Divider
            Divider(color: AppColors.border2, height: 1, thickness: 0.5),
          ],
        ),
      ),
    );
  }

  /// Build profile avatar (removed dummy online status)
  Widget _buildProfileAvatar(chat_models.PrivateChatConversation conversation) {
    return Container(
      width: Sizer.wp(50),
      height: Sizer.wp(50),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 2,
        ),
      ),
      child: CircleAvatar(
        radius: Sizer.wp(23),
        backgroundImage: conversation.participant.profile.profileUrl != null
            ? NetworkImage(conversation.participant.profile.profileUrl!)
            : null,
        backgroundColor: AppColors.primaryBackground,
        child: conversation.participant.profile.profileUrl == null
            ? Text(
                _getInitials(conversation.participant.profile.displayName),
                style: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(16),
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              )
            : null,
      ),
    );
  }

  /// Get initials from name for avatar placeholder
  /// Get initials from name for avatar placeholder
  String _getInitials(String name) {
    final cleanedName = name.trim();
    if (cleanedName.isEmpty) {
      return 'U';
    }

    // Split on one or more whitespace to avoid empty parts
    final names = cleanedName.split(RegExp(r'\s+'));

    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    } else if (names.isNotEmpty) {
      return names[0][0].toUpperCase();
    }

    return 'U';
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  /// Open conversation in chat screen
  void _openConversation(chat_models.PrivateChatConversation conversation) {
    // Select the conversation in the controller
    _chatController.selectConversation(conversation);

    // Navigate to chat screen
    Get.to(() => const Admin_chatscreen());
  }
}
