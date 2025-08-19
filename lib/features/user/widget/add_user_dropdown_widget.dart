import 'package:flutter/material.dart';

import '../controller/add_user_controller.dart';

Widget buildDropdownField(
  String label,
  String hint,
  List<String> options,
  AddUserController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(hint, style: const TextStyle(color: Colors.grey)),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option, style: const TextStyle(color: Colors.grey)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              // Handle dropdown change
            },
          ),
        ),
      ),
    ],
  );
}
