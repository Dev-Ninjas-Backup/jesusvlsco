import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/add_user_controller.dart';
import '../widget/add_user_form_widget.dart';
import '../widget/appbar_widget.dart';
import '../widget/progress_indigator_widget.dart';
import '../widget/section_header_widget.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddUserController());
    // final AddUserController controller = Get.find<AddUserController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRoleSelector(controller),
            const SizedBox(height: 24),
            const SectionHeaderWidget(
              title: 'Personal Information',
              subtitle:
                  'Fill in the details below to add a new employee to the system.',
            ),
            const SizedBox(height: 16),
            const ProgressIndicatorWidget(currentStep: 1, totalSteps: 4),
            const SizedBox(height: 32),
            buildFormFields(controller),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.saveUser(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => controller.cancelAddUser(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Color(0xFF6366F1)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFF6366F1),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleSelector(AddUserController controller) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFB3C5EF),
            width: 2,
          ), // Light blue border
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: controller.selectedRole.value == ''
                ? null
                : controller.selectedRole.value,
            isExpanded: true,
            hint: const Text(
              'Select role',
              style: TextStyle(color: Colors.grey),
            ),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            items: controller.roles.map((String role) {
              return DropdownMenuItem<String>(
                value: role,
                child: Text(
                  role,
                  style: TextStyle(
                    color: role == 'Admin'
                        ? const Color(0xFF6366F1)
                        : Colors.grey[600], // Match text colors
                    fontSize: 16,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                controller.setRole(newValue);
              }
            },
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
            dropdownColor:
                Colors.white, // Background color of the dropdown menu
            borderRadius: BorderRadius.circular(
              12,
            ), // Rounded corners for dropdown
          ),
        ),
      ),
    );
  }
}
