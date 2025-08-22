import 'package:flutter/material.dart';

class TimeClockAdminChatBubble extends StatelessWidget {
  final bool isSender;
  final String avatarUrl;
  final String text;

  const TimeClockAdminChatBubble({
    super.key,
    required this.isSender,
    required this.avatarUrl,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isSender ? const Color(0xFFEDEEF7) : Color(0XFFEDEEF7);
    final alignment = isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSender) ...[
            CircleAvatar(radius: 16, backgroundImage: NetworkImage(avatarUrl)),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: alignment,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: bubbleColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(text),
                ),
              ],
            ),
          ),
          if (isSender) ...[
            const SizedBox(width: 8),
            CircleAvatar(radius: 16, backgroundImage: NetworkImage(avatarUrl)),
          ],
        ],
      ),
    );
  }
}
