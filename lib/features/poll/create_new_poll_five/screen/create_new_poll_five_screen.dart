import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/core/common/widgets/custom_button.dart';
import 'package:jesusvlsco/core/common/widgets/custom_text_field.dart';
import '../../create_new_poll_two/widgets/progress_indicator.dart';
import '../controller/create_new_poll_five_controller.dart';

class CreateNewPollFiveScreen extends StatelessWidget {
  const CreateNewPollFiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateNewPollFiveController());

    final steps = ["Assign by", "Recipients", "Publish Settings", "Summary"];

    return Scaffold(
      appBar: Custom_appbar(title: "Create New Poll"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Progress Indicator (Step 4 active)
            Center(
              child: ProgressIndicatorWithLabels(
                currentStep: 4,
                steps: steps,
              ),
            ),
            const SizedBox(height: 24),

            /// 🔹 Summary Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Poll is Live!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF4E53B1),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "\"Your survey is live and ready for participation!\"",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Asset will be published on ${controller.publishDate.value} "
                        "at ${controller.publishTime.value}",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  if (controller.notifyUsers.value)
                    const Text("User will be notified"),
                  const SizedBox(height: 12),

                  /// 🔹 Notification Message Preview
                  CustomTextField(
                    hintText: controller.notificationMessage.value,
                    controller: TextEditingController(),
                    maxLines: 2,
                  ),
                ],
              )),
            ),

            const Spacer(),

            /// 🔹 Bottom Buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () => Get.back(),
                    text: "Cancel",
                    textColor: const Color(0xFF4E53B1),
                    borderColor: const Color(0xFF4E53B1),
                    decorationColor: Colors.white,
                    fontWeight: FontWeight.w500,
                    borderRadius: 8,
                    isExpanded: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    onPressed: controller.createPoll,
                    text: "Create Poll",
                    textColor: Colors.white,
                    decorationColor: const Color(0xFF4E53B1),
                    fontWeight: FontWeight.w600,
                    borderRadius: 8,
                    isExpanded: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
