import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/common/widgets/custom_appbar.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../controller/user_poll_controller.dart';

class UserPollScreen extends StatelessWidget {
  const UserPollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserPollController());

    return Scaffold(
      appBar: Custom_appbar(title: "Poll"),
      body: Obx(() {
        final poll = controller.pollQuestion as Map<String, dynamic>;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                poll["title"] ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF4E53B1),
                ),
              ),
              const SizedBox(height: 8),

              // Owner, Duration, Status
              Row(
                children: const [
                  Icon(Icons.person, size: 16, color: Colors.black54),
                  SizedBox(width: 6),
                  Text("Owner: Admin", style: TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: const [
                  Icon(Icons.calendar_today, size: 16, color: Colors.black54),
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
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
              const SizedBox(height: 20),

              // Question
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E53B1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      "1",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      poll["question"] ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Options
              ...List.generate((poll["options"] as List).length, (index) {
                final option = (poll["options"] as List)[index];
                return Obx(() {
                  final isSelected = controller.selectedAnswer.value == index;
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
                            ? const Color(0xFF4E53B1).withValues(alpha: 0.08)
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
                            option,
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

              const Spacer(),

              // ✅ Submit button
              CustomButton(
                onPressed: controller.submitPoll,
                text: "Submit",
                isExpanded: true,
                decorationColor: const Color(0xFF4E53B1),
                textColor: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                borderRadius: 8,
              ),
              SizedBox(height: 8),
            ],
          ),
        );
      }),
    );
  }
}
