import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';

class TimeClockAdminMessageInputBar extends StatefulWidget {
  final void Function(String) onSend;

  const TimeClockAdminMessageInputBar({super.key, required this.onSend});

  @override
  State<TimeClockAdminMessageInputBar> createState() =>
      _TimeClockAdminMessageInputBarState();
}

class _TimeClockAdminMessageInputBarState
    extends State<TimeClockAdminMessageInputBar> {
  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    widget.onSend(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _controller,
              decoration:  InputDecoration(
                hintText: 'Write Something...',
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          GestureDetector(
            //handle emoji icon action
            child: Icon(Icons.emoji_emotions_outlined),
          ),
          SizedBox(width: 8),
          GestureDetector(
            //attach file icon action handle here
            child: Icon(Icons.attach_file),
          ),
          SizedBox(width: 8),
          GestureDetector(
            //attach file icon action handle here
            child: Icon(Icons.mic),
          ),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.send, size: 18),
            onPressed: _handleSend,
          ),
        ],
      ),
    );
  }
}
