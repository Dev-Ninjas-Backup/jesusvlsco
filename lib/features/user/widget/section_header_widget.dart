import 'package:flutter/material.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6366F1),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
