import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/add_user_controller.dart';

class ExperienceFormFieldsWidget extends StatelessWidget {
  const ExperienceFormFieldsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddUserController>();

    return Obx(() {
      final exps = controller.experiences;

      if (exps.isEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'No experiences added. Use "Add Experience" to add one.',
            ),
            const SizedBox(height: 12),
          ],
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: exps.asMap().entries.map((entry) {
          final idx = entry.key;
          final item = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Experience ${idx + 1}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    onPressed: () => controller.removeExperienceAt(idx),
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildFieldLabel('Position/ Designation'),
              const SizedBox(height: 8),
              _buildTextField(
                initialText: item['position'] ?? '',
                hintText: 'Enter designation',
                onChanged: (v) =>
                    controller.updateExperienceField(idx, 'position', v),
              ),
              const SizedBox(height: 20),
              _buildFieldLabel('Company name'),
              const SizedBox(height: 8),
              _buildTextField(
                initialText: item['company'] ?? '',
                hintText: 'Enter company name',
                onChanged: (v) =>
                    controller.updateExperienceField(idx, 'company', v),
              ),
              const SizedBox(height: 20),
              _buildFieldLabel('Job type'),
              const SizedBox(height: 8),
              _buildSelectableField(
                text: item['jobType'] ?? 'Select job type here',
                hintText: 'Select job type here',
                onTap: () => controller.selectJobTypeFor(idx),
              ),
              const SizedBox(height: 20),
              _buildFieldLabel('Start date'),
              const SizedBox(height: 8),
              _buildDateField(
                text: item['startDate'] ?? '',
                hintText: 'Select date here',
                onTap: () => controller.selectStartDateFor(idx),
              ),
              const SizedBox(height: 20),
              _buildFieldLabel('End date'),
              const SizedBox(height: 8),
              _buildDateField(
                text: item['endDate'] ?? '',
                hintText: 'Select date here',
                onTap: () => controller.selectEndDateFor(idx),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: item['isCurrentlyWorking'] == true,
                    onChanged: (bool? value) => controller
                        .toggleCurrentlyWorkingFor(idx, value ?? false),
                    activeColor: const Color(0xFF6366F1),
                  ),
                  const Text(
                    'I am currently working there',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildFieldLabel('Description'),
              const SizedBox(height: 8),
              _buildTextArea(
                initialText: item['description'] ?? '',
                hintText: 'Description',
                onChanged: (v) =>
                    controller.updateExperienceField(idx, 'description', v),
              ),
              const SizedBox(height: 20),
            ],
          );
        }).toList(),
      );
    });
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    String initialText = '',
    required String hintText,
    ValueChanged<String>? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        initialValue: initialText,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  Widget _buildSelectableField({
    required String text,
    required String hintText,
    required VoidCallback onTap,
  }) {
    final isEmpty = text.trim().isEmpty;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                isEmpty ? hintText : text,
                style: TextStyle(
                  fontSize: 16,
                  color: isEmpty ? Colors.grey[500] : Colors.black87,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField({
    required String text,
    required String hintText,
    required VoidCallback onTap,
  }) {
    final isEmpty = text.trim().isEmpty;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                isEmpty ? hintText : text,
                style: TextStyle(
                  fontSize: 16,
                  color: isEmpty ? Colors.grey[500] : Colors.black87,
                ),
              ),
            ),
            Icon(Icons.calendar_today, size: 20, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  Widget _buildTextArea({
    String initialText = '',
    required String hintText,
    ValueChanged<String>? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        initialValue: initialText,
        onChanged: onChanged,
        maxLines: 6,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }
}
