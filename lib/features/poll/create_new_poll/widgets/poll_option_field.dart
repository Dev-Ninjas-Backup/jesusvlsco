import 'package:flutter/material.dart';

class PollOptionField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onRemove;

  const PollOptionField({
    super.key,
    required this.controller,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "Option",
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // pill-shaped like your screenshot
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.close, color: Colors.red),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
