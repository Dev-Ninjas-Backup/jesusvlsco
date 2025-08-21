import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/survey_and_poll/create_new_survey_screen/controller/create_new_survey_screen_controller.dart';

class DropdownFieldDialog extends StatelessWidget {
  final CreateNewSurveyScreenController controller = Get.find();

  DropdownFieldDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  const Checkbox(value: true, onChanged: null),
                  const Text('Dropdown', style: TextStyle(fontSize: 16)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              // Question Field
              TextField(
                controller: controller.questionController,
                decoration: const InputDecoration(
                  hintText: 'Question',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Answer', style: TextStyle(fontWeight: FontWeight.bold)),
              ),

              const SizedBox(height: 8),
              Obx(() => Column(
                    children: List.generate(controller.answerControllers.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller.answerControllers[index],
                                decoration: const InputDecoration(
                                  hintText: 'option 1',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (controller.answerControllers.length > 1)
                              IconButton(
                                icon: const Icon(Icons.remove_circle, color: Colors.red),
                                onPressed: () => controller.removeAnswerField(index),
                              ),
                          ],
                        ),
                      );
                    }),
                  )),

              // Add Field Button
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: controller.addAnswerField,
                  icon: const Icon(Icons.add),
                  label: const Text('Add field'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4C4CD9),
                  ),
                ),
              ),

              const SizedBox(height: 8),
              // Checkboxes
              Obx(() => CheckboxListTile(
                    value: controller.isRequired.value,
                    onChanged: (val) => controller.isRequired.value = val ?? false,
                    title: const Text('Required'),
                    controlAffinity: ListTileControlAffinity.leading,
                  )),
              Obx(() => CheckboxListTile(
                    value: controller.locationStamp.value,
                    onChanged: (val) => controller.locationStamp.value = val ?? false,
                    title: const Text('Location stamp capture'),
                    controlAffinity: ListTileControlAffinity.leading,
                  )),
              Obx(() => CheckboxListTile(
                    value: controller.multipleSelection.value,
                    onChanged: (val) => controller.multipleSelection.value = val ?? false,
                    title: const Text('Multiple selection'),
                    controlAffinity: ListTileControlAffinity.leading,
                  )),

              const SizedBox(height: 12),
              // Confirm Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle confirm logic here
                    Get.back();
                  },
                  
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4C4CD9),
                  ),
                  child:  Text('Confirm'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
