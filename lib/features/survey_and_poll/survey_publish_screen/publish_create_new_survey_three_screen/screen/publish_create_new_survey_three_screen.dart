import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/core/common/widgets/custom_button.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_publish_screen/create_new_survey_screen/widget/publish_survey_progress_indicator.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_publish_screen/publish_create_new_survey_four_screen/screen/publish_create_new_survey_four_screen.dart';

import 'package:jesusvlsco/features/survey_and_poll/survey_publish_screen/publish_create_new_survey_three_screen/controller/publish_create_new_survey_three_controller.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_publish_screen/publish_create_new_survey_three_screen/widget/publish_create_survey_checkbox.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_publish_screen/publish_create_new_survey_three_screen/widget/publish_create_survey_date_picker_row.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_publish_screen/publish_create_new_survey_three_screen/widget/publish_create_survey_option_selector.dart';


class PublishCreateNewSurveyThreeScreen extends StatelessWidget {
  const PublishCreateNewSurveyThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PublishCreateNewSurveyThreeController());

    final steps = ["Assign by", "Recipients", "Publish settings", "Summary"];

    return Scaffold(
      appBar: Custom_appbar(title: "Create New Survey"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),

            /// Progress Indicator
            Center(
              child: PublishSurveyProgressIndicator(
                currentStep: 3,
                steps: steps,
              ),
            ),

            const SizedBox(height: 24),

            /// Publish Option
            Obx(() => PublishCreateSurveyOptionSelector(
              groupValue: controller.publishOption.value,
              options: ["Publish now", "Select date & time"],
              onChanged: controller.setPublishOption,
            )),

            const SizedBox(height: 16),

            /// Notify Employees
            Obx(() => PublishCreateSurveyCheckbox(
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

            /// Reminder
            Obx(() => PublishCreateSurveyCheckbox(
              title: "Send on reminder if user didn’t view by",
              value: controller.reminderEnabled.value,
              onChanged: controller.toggleReminder,
              child: PublishCreateSurveyDatePickerRow(
                selectedDate: controller.selectedDate,
                selectedTime: controller.selectedTime,
                onDatePicked: controller.setDate,
                onTimePicked: controller.setTime,
              ),
            )),

            /// Show on feed
            Obx(() => PublishCreateSurveyCheckbox(
              title: "Show on feed by XYZ agency",
              value: controller.showOnFeed.value,
              onChanged: controller.toggleShowOnFeed,
            )),

            const Spacer(),

            /// Bottom Buttons
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
                      //Get.to(const CreateNewPollFiveScreen());
                      Get.to(PublishCreateNewSurveyFourScreen());
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
