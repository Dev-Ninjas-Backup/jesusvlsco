import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../controller/create_new_poll_controller.dart';
import '../widgets/custom_drop_down_field.dart';
import '../widgets/question_card.dart';

class CreateNewPollScreen extends StatelessWidget {
  const CreateNewPollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateNewPollController());

    return Scaffold(
      appBar: Custom_appbar(title: 'Create Survey & Poll'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(
              () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Type Dropdown
              const Text("Type"),
              const SizedBox(height: 12),
              CustomDropdownField(
                value: controller.pollType.value,
                items: controller.pollTypes,
                onChanged: (val) => controller.setPollType(val), // 🔑 Updated
              ),
              const SizedBox(height: 16),

              // 🔹 Title (only when Poll)
              if (controller.pollType.value == "Poll") ...[
                Text(controller.titleLabel),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText:
                  "Enter ${controller.pollType.value.toLowerCase()} title here",
                  controller: controller.titleController,
                ),
                const SizedBox(height: 16),

                // 🔹 Description
                Text(controller.descriptionLabel),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText:
                  "Enter ${controller.pollType.value.toLowerCase()} description here",
                  controller: controller.descriptionController,
                  maxLines: 3,
                ),
                const SizedBox(height: 24),

                // 🔹 Section Header
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    controller.detailsLabel,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4E53B1),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // 🔹 Dynamic Questions
                Column(
                  children:
                  List.generate(controller.questions.length, (index) {
                    final question = controller.questions[index];
                    return QuestionCard(
                      index: index,
                      questionController: question.questionController,
                      optionControllers: question.options,
                      onRemoveQuestion: () =>
                          controller.removeQuestion(index),
                      onAddOption: () => controller.addOption(index),
                      onRemoveOption: (optIndex) =>
                          controller.removeOption(index, optIndex),
                    );
                  }),
                ),
                const SizedBox(height: 10),

                // 🔹 Bottom Buttons
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: "Save Template",
                        onPressed: controller.saveTemplate,
                        borderColor: const Color(0xFF4E53B1),
                        textColor: const Color(0xFF4E53B1),
                        borderRadius: 8,
                        isExpanded: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(
                        text: "Publish",
                        onPressed: controller.publishPoll,
                        decorationColor: const Color(0xFF4E53B1),
                        textColor: Colors.white,
                        borderRadius: 8,
                        isExpanded: true,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
