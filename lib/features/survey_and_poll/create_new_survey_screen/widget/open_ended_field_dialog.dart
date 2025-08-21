import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/survey_and_poll/create_new_survey_screen/controller/open_ended_field_controller.dart';


class OpenEndedFieldDialog extends StatelessWidget {
  final OpenEndedFieldController controller = Get.find();

  OpenEndedFieldDialog({super.key});

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
                  const Icon(Icons.subject),
                  const SizedBox(width: 8),
                  const Text('Open ended', style: TextStyle(fontSize: 16)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              // Question Field
              TextField(
                controller: controller.questionController,
                decoration: const InputDecoration(
                  hintText: 'Question',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),
              // Description Field
              TextField(
                controller: controller.descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),
              // Answer Field
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Answer', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller.answerController,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),
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
                  child: const Text('Confirm'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
