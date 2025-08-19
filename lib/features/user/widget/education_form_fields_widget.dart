import 'package:flutter/material.dart';

class EducationFormFieldsWidget extends StatelessWidget {
  final dynamic controller;

  const EducationFormFieldsWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSelectableField(
          'Program',
          'Enter name here',
          controller.selectProgram,
        ),
        const SizedBox(height: 20),
        _buildSelectableField(
          'Institution',
          'Enter name here',
          controller.selectInstitution,
        ),
        const SizedBox(height: 20),
        _buildSelectableField('Year', 'Enter Year here', controller.selectYear),
      ],
    );
  }

  Widget _buildSelectableField(String label, String hint, VoidCallback onTap) {
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
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(hint, style: const TextStyle(color: Colors.grey)),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
