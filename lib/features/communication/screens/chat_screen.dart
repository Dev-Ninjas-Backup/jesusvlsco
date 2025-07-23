import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  String _currentMessage = '';
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hey! How is the new project coming along?",
      isMe: false,
      time: "9:40",
      avatar: "https://randomuser.me/api/portraits/men/32.jpg",
    ),
    ChatMessage(
      text: "Going great! Just finished the wireframes... Will share them with you shortly.",
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
      text: "Going great! Just finished the wireframes... Will share them with you shortly.",
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
      text: "Going great! Just finished the wireframes... Will share them with you shortly.",
      isMe: true,
      time: "9:41",
      avatar: "https://randomuser.me/api/portraits/women/44.jpg",
    ),
  ];

  void _sendMessage() {
    if (_currentMessage.trim().isNotEmpty) {
      setState(() {

        _messages.add(
          ChatMessage(
            text: _currentMessage,
            isMe: true,
            time: TimeOfDay.now().format(context),
            avatar: "https://randomuser.me/api/portraits/women/44.jpg",
          ),
        );
        _currentMessage = '';
      });
    }
  }

  void disspose(){
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: Container(
              color: const Color(0xFFF5F5F5),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return _buildMessageBubble(message);
                },
              ),
            ),
          ),
          // Message input area
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Text input field
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _currentMessage = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Write Something...',
                        hintStyle: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Attachment button
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.attach_file,
                      color: Color(0xFF666666),
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 8),
                // Microphone button
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.mic,
                      color: Color(0xFF666666),
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 8),
                // Send button
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4A90E2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(message.avatar),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isMe ? const Color(0xFF4A90E2) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(message.isMe ? 18 : 4),
                  bottomRight: Radius.circular(message.isMe ? 4 : 18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isMe ? Colors.white : const Color(0xFF333333),
                  fontSize: 15,
                  height: 1.3,
                ),
              ),
            ),
          ),
          if (message.isMe) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(message.avatar),
            ),
          ],
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      shadowColor: Colors.grey.withOpacity(0.3),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xFF333333),
          size: 20,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: const NetworkImage(
              'https://randomuser.me/api/portraits/men/1.jpg',
            ),
          ),
          const SizedBox(width: 12),
          Column(
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
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.phone,
            color: Color(0xFF666666),
            size: 22,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.videocam,
            color: Color(0xFF666666),
            size: 24,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.more_horiz,
            color: Color(0xFF333333),
            size: 24,
          ),
          onPressed: () {},
        ),
      ],
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