import 'package:flutter/material.dart';

class EditButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const EditButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.edit, size: 16, color: Colors.white),
      label: const Text(
        'Edit',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6366F1),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    );
  }
}
