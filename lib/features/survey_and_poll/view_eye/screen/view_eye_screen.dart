import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_response_screen/screen/survey_response_screen.dart';
import '../../../../core/common/widgets/custom_appbar.dart';
import '../controller/view_eye_controller.dart';
import '../widget/quick_view_card.dart';

class ViewEyeScreen extends StatelessWidget {
  const ViewEyeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final controller = Get.put(ViewEyeController());

    return Scaffold(
      appBar: Custom_appbar(title: "Survey & Poll"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            QuickViewCard(),

            const Spacer(),

            /// Bottom Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF4E53B1)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Cancel",
                        style: TextStyle(color: Color(0xFF4E53B1))),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      //  Navigate to responses screen
                      //Get.to(SurveyReportScreen());
                      Get.to(SurveyResponseScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E53B1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("View Response"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
