import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EducationFormFieldsWidget extends StatelessWidget {
  final dynamic controller;

  const EducationFormFieldsWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final educations = controller.educations as List<dynamic>;

      if (educations.isEmpty) {
        return Column(
          children: [
            const Text('No education entries. Use "Add Education" to add one.'),
            const SizedBox(height: 12),
          ],
        );
      }

      return Column(
        children: educations.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value as Map<String, dynamic>;
          String programText = (item['program'] ?? '').toString();
          String institutionText = (item['institution'] ?? '').toString();
          String yearText = item['year'] != null ? item['year'].toString() : '';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Education ${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    onPressed: () => controller.removeEducation(index),
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildSelectableField(
                'Program',
                programText.isNotEmpty ? programText : 'Select program',
                () => controller.selectProgramFor(index),
              ),
              const SizedBox(height: 12),
              _buildSelectableField(
                'Institution',
                institutionText.isNotEmpty
                    ? institutionText
                    : 'Select institution',
                () => controller.selectInstitutionFor(index),
              ),
              const SizedBox(height: 12),
              _buildSelectableField(
                'Year',
                yearText.isNotEmpty ? yearText : 'Select year',
                () => controller.selectYearFor(index),
              ),
              const SizedBox(height: 20),
            ],
          );
        }).toList(),
      );
    });
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
                Flexible(
                  child: Text(hint, style: const TextStyle(color: Colors.grey)),
                ),
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
