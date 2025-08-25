import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/add_user_controller.dart';
import '../widget/add_education_button_widget.dart';
import '../widget/appbar_widget.dart';
import '../widget/education_form_fields_widget.dart';
import '../widget/progress_indigator_widget.dart';
import '../widget/section_header_widget.dart';

class AddUserEducationScreen extends StatelessWidget {
  const AddUserEducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Reuse the existing AddUserController if available so createdUserId is preserved
    final controller = Get.isRegistered<AddUserController>()
        ? Get.find<AddUserController>()
        : Get.put(AddUserController());

    // If a userId was passed via arguments, store it on the controller
    if (Get.arguments != null && Get.arguments is Map) {
      final argMap = Get.arguments as Map;
      if (argMap.containsKey('userId')) {
        controller.createdUserId = argMap['userId']?.toString();
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeaderWidget(
              title: 'Education',
              subtitle:
                  'Fill in the details below to add a new employee to the system.',
            ),
            const SizedBox(height: 16),
            const ProgressIndicatorWidget(currentStep: 2, totalSteps: 4),
            const SizedBox(height: 32),
            AddEducationButtonWidget(
              onPressed: controller.addEducation,
              label: 'Add Education',
            ),
            const SizedBox(height: 32),
            EducationFormFieldsWidget(controller: controller),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.saveEducation,
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
                    onPressed: controller.cancelEducation,
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
}
