import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../controller/user_view_single_template_controller.dart';

class UserViewSingleTemplateScreen extends StatelessWidget {
  const UserViewSingleTemplateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserViewSingleTemplateController());

    return Scaffold(
      appBar: Custom_appbar(title: "Survey"),
      body: Obx(() {
        if (controller.questions.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final q = controller.questions[controller.currentIndex.value];

        return Column(
          children: [
            // -------- Scrollable main content --------
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---------- Title ----------
                    const Text(
                      "Employee Satisfaction Survey Template",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color(0xFF4E53B1),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // ---------- Subtitle ----------
                    const Text(
                      "This survey gathers feedback on employee satisfaction with workplace practices. "
                      "Your responses will help us improve our work environment and address any concerns.",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    // ---------- Owner, Duration, Status ----------
                    Row(
                      children: const [
                        Icon(Icons.person, size: 18, color: Colors.black54),
                        SizedBox(width: 6),
                        Text("Owner: Admin", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: const [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Duration: May 1 - May 15, 2025",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: const [
                        Text(
                          "Status: ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // ---------- Progress ----------
                    Text(
                      "Progress: ${controller.currentIndex.value + 1} "
                      "of ${controller.questions.length} questions "
                      "(${(((controller.currentIndex.value + 1) / controller.questions.length) * 100).toInt()}%)",
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 6),

                    // ---------- Progress indicator ----------
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(4)), // rounded corners
                      child: LinearProgressIndicator(
                        value: (controller.currentIndex.value + 1) /
                            controller.questions.length,
                        color: Colors.green,
                        backgroundColor: Colors.grey[300],
                        minHeight: 7,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(thickness: 1, color: Colors.black12),
                    const SizedBox(height: 12),

                    // ---------- Question ----------
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4E53B1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "${controller.currentIndex.value + 1}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                q["question"],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Please select one option that best represents your opinion",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ---------- Options ----------
                    ...List.generate(q["options"].length, (index) {
                      return Obx(() {
                        final isSelected =
                            controller.selectedAnswer.value == index;
                        return GestureDetector(
                          onTap: () => controller.selectedAnswer.value = index,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF4E53B1)
                                    : Colors.grey.shade400,
                                width: 1.3,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: isSelected
                                  ? const Color(0xFF4E53B1).withOpacity(0.08)
                                  : Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off,
                                  color: isSelected
                                      ? const Color(0xFF4E53B1)
                                      : Colors.grey,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  q["options"][index],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isSelected
                                        ? const Color(0xFF4E53B1)
                                        : Colors.black87,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    }),
                  ],
                ),
              ),
            ),

            // -------- Bottom Buttons using CustomButton --------
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: controller.previousQuestion,
                        text: "Previous",
                        decorationColor: Colors.white,
                        borderColor: const Color(0xFF4E53B1),
                        textColor: const Color(0xFF4E53B1),
                        borderRadius: 8,
                        isExpanded: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(
                        onPressed: controller.isLastQuestion
                            ? controller.submitSurvey
                            : controller.nextQuestion,
                        text: controller.isLastQuestion ? "Submit" : "Next",
                        decorationColor: const Color(0xFF4E53B1),
                        textColor: Colors.white,
                        fontWeight: FontWeight.w600,
                        borderRadius: 8,
                        isExpanded: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
