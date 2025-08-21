import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/core/common/widgets/custom_button.dart';
import '../../create_new_poll_five/screen/create_new_poll_five_screen.dart';
import '../../create_new_poll_two/widgets/progress_indicator.dart';
import '../controller/create_new_poll_four_controller.dart';
import '../widgets/custom_option_selector.dart';
import '../widgets/custom_checkbox_tile.dart';
import '../widgets/custom_date_time_picker_row.dart';

class CreateNewPollFourScreen extends StatelessWidget {
  const CreateNewPollFourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateNewPollFourController());

    final steps = ["Assign by", "Recipients", "Publish settings", "Summary"];

    return Scaffold(
      appBar: Custom_appbar(title: "Create New Poll"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),

            /// 🔹 Progress Indicator
            Center(
              child: ProgressIndicatorWithLabels(
                currentStep: 3,
                steps: steps,
              ),
            ),

            const SizedBox(height: 24),

            /// 🔹 Publish Option
            Obx(() => CustomOptionSelector(
              groupValue: controller.publishOption.value,
              options: ["Publish now", "Select date & time"],
              onChanged: controller.setPublishOption,
            )),

            const SizedBox(height: 16),

            /// 🔹 Notify Employees
            Obx(() => CustomCheckboxTile(
              title: "Notify employees via push up notification",
              value: controller.notifyEmployees.value,
              onChanged: controller.toggleNotifyEmployees,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "A new update is waiting for you in the XYZ company app",
                ),
              ),
            )),

            /// 🔹 Reminder
            Obx(() => CustomCheckboxTile(
              title: "Send on reminder if user didn’t view by",
              value: controller.reminderEnabled.value,
              onChanged: controller.toggleReminder,
              child: CustomDateTimePickerRow(
                selectedDate: controller.selectedDate,
                selectedTime: controller.selectedTime,
                onDatePicked: controller.setDate,
                onTimePicked: controller.setTime,
              ),
            )),

            /// 🔹 Show on feed
            Obx(() => CustomCheckboxTile(
              title: "Show on feed by XYZ agency",
              value: controller.showOnFeed.value,
              onChanged: controller.toggleShowOnFeed,
            )),

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
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      controller.nextStep();
                      Get.to(const CreateNewPollFiveScreen());
                    },
                    text: "Next",
                    textColor: Colors.white,
                    decorationColor: const Color(0xFF4E53B1),
                    fontWeight: FontWeight.w600,
                    borderRadius: 8,
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
