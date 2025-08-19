import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/add_user_controller.dart';

class ExperienceFormFieldsWidget extends StatelessWidget {
  const ExperienceFormFieldsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddUserController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Position/ Designation'),
        const SizedBox(height: 8),
        _buildTextField(
          controller: controller.positionController,
          hintText: 'Enter designation',
        ),

        const SizedBox(height: 20),

        _buildFieldLabel('Company name'),
        const SizedBox(height: 8),
        _buildTextField(
          controller: controller.companyNameController,
          hintText: 'Enter company name',
        ),

        const SizedBox(height: 20),

        _buildFieldLabel('Job type'),
        const SizedBox(height: 8),
        _buildSelectableField(
          controller: controller.jobTypeController,
          hintText: 'Select job type here',
          onTap: () => controller.selectJobType(),
        ),

        const SizedBox(height: 20),

        _buildFieldLabel('Start date'),
        const SizedBox(height: 8),
        _buildDateField(
          controller: controller.startDateController,
          hintText: 'Select date here',
          onTap: () => controller.selectStartDate(),
        ),

        const SizedBox(height: 20),

        _buildFieldLabel('End date'),
        const SizedBox(height: 8),
        _buildDateField(
          controller: controller.endDateController,
          hintText: 'Select date here',
          onTap: () => controller.selectEndDate(),
        ),

        const SizedBox(height: 16),

        Obx(
          () => Row(
            children: [
              Checkbox(
                value: controller.isCurrentlyWorking.value,
                onChanged: (bool? value) {
                  controller.setCurrentlyWorking(value ?? false);
                },
                activeColor: const Color(0xFF6366F1),
              ),
              const Text(
                'I am currently working there',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        _buildFieldLabel('Description'),
        const SizedBox(height: 8),
        _buildTextArea(
          controller: controller.descriptionController,
          hintText: 'Description',
        ),
      ],
    );
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
    required TextEditingController controller,
    required String hintText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        controller: controller,
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
    required TextEditingController controller,
    required String hintText,
    required VoidCallback onTap,
  }) {
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
                controller.text.isEmpty ? hintText : controller.text,
                style: TextStyle(
                  fontSize: 16,
                  color: controller.text.isEmpty
                      ? Colors.grey[500]
                      : Colors.black87,
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
    required TextEditingController controller,
    required String hintText,
    required VoidCallback onTap,
  }) {
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
                controller.text.isEmpty ? hintText : controller.text,
                style: TextStyle(
                  fontSize: 16,
                  color: controller.text.isEmpty
                      ? Colors.grey[500]
                      : Colors.black87,
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
    required TextEditingController controller,
    required String hintText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        controller: controller,
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
