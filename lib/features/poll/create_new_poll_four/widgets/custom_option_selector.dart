// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CustomOptionSelector extends StatelessWidget {
  final String groupValue;
  final List<String> options;
  final Function(String) onChanged;

  const CustomOptionSelector({
    super.key,
    required this.groupValue,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options.map((option) {
        return Row(
          children: [
            Radio(
              value: option,
              groupValue: groupValue,
              onChanged: (val) => onChanged(val!),
              activeColor: const Color(0xFF4E53B1),
            ),
            Text(option),
            const SizedBox(width: 20),
          ],
        );
      }).toList(),
    );
  }
}
