// ignore_for_file: deprecated_member_use, camel_case_types

import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';

class Admin_chatscreen extends StatefulWidget {
  const Admin_chatscreen({super.key});

  @override
  Admin_chatscreenState createState() => Admin_chatscreenState();
}

class Admin_chatscreenState extends State<Admin_chatscreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hey! How is the new project coming along?",
      isMe: false,
      time: "9:40",
      avatar: "https://randomuser.me/api/portraits/men/32.jpg",
    ),
    ChatMessage(
      text:
          "Going great! Just finished the wireframes... Will share them with you shortly.",
      isMe: true,
      time: "9:41",
      avatar: "https://randomuser.me/api/portraits/women/44.jpg",
    ),
    ChatMessage(
      text: "Hey! How is the new project coming along?",
      isMe: false,
      time: "9:41",
      avatar: "https://randomuser.me/api/portraits/men/32.jpg",
    ),
    ChatMessage(
      text:
          "Going great! Just finished the wireframes... Will share them with you shortly.",
      isMe: true,
      time: "9:41",
      avatar: "https://randomuser.me/api/portraits/women/44.jpg",
    ),
    ChatMessage(
      text: "Hey! How is the new project coming along?",
      isMe: false,
      time: "9:41",
      avatar: "https://randomuser.me/api/portraits/men/32.jpg",
    ),
    ChatMessage(
      text:
          "Going great! Just finished the wireframes... Will share them with you shortly.",
      isMe: true,
      time: "9:41",
      avatar: "https://randomuser.me/api/portraits/women/44.jpg",
    ),
  ];

  void _sendMessage(String message) {
    if (message.trim().isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: message,
            isMe: true,
            time: TimeOfDay.now().format(context),
            avatar: "https://randomuser.me/api/portraits/women/44.jpg",
          ),
        );
        _messageController.clear();
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
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
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildMessageBubble(message, index),
                    );
                  },
                ),
              ),
            ),
          ),
          // Message input area using MessageBar from chat_bubbles
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

  Widget _buildMessageBubble(ChatMessage message, int index) {
    // Check if this message should have a tail (last message in a sequence from the same sender)
    bool shouldShowTail = true;
    if (index < _messages.length - 1) {
      shouldShowTail = _messages[index + 1].isMe != message.isMe;
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
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(message.avatar),
            ),
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
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(message.avatar),
            ),
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
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(Sizer.wp(16)),
        child: Row(
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
                    border: Border.all(color: AppColors.primary, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: const NetworkImage(
                      'https://randomuser.me/api/portraits/men/1.jpg',
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
                  const Text(
                    'Project ABC',
                    style: TextStyle(
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
            // Action buttons
            SvgPicture.asset('assets/icons/Call.svg', width: 24, height: 24),
            const SizedBox(width: 8),
            SvgPicture.asset('assets/icons/Camera.svg', width: 24, height: 24),
            const SizedBox(width: 8),
            SvgPicture.asset(
              'assets/icons/more_vert.svg',
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;
  final String avatar;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
    required this.avatar,
  });
}
