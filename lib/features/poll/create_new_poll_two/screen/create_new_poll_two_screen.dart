import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import '../../create_new_poll_three/screen/create_new_poll_three_screen.dart';
import '../controller/create_new_poll_two_controller.dart';
import '../widgets/progress_indicator.dart';

class CreateNewPollTwoScreen extends StatelessWidget {
  const CreateNewPollTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateNewPollTwoController());

    final steps = ["Assign by", "Recipients", "Publish settings", "Summary"];

    return Scaffold(
      appBar: Custom_appbar(title: "Create New Poll"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16,),
            /// 🔹 Custom Progress Indicator
            Center(
              child: ProgressIndicatorWithLabels(
                currentStep: 1,
                steps: steps,
              ),
            ),
            const SizedBox(height: 40),

            /// 🔹 Centered Option Buttons
            Expanded(
              child: Center(
                child: Obx(
                      () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => controller.selectOption("All"),
                          child: Container(
                            height: 48,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: controller.isSelected("All")
                                  ? const Color(0xFF4E53B1)
                                  : Colors.white,
                              border: Border.all(color: const Color(0xFF4E53B1)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "All",
                              style: TextStyle(
                                color: controller.isSelected("All")
                                    ? Colors.white
                                    : const Color(0xFF4E53B1),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InkWell(
                          onTap: () => controller.selectOption("Select user"),
                          child: Container(
                            height: 48,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: controller.isSelected("Select user")
                                  ? const Color(0xFF4E53B1)
                                  : Colors.white,
                              border: Border.all(color: const Color(0xFF4E53B1)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "Select user",
                              style: TextStyle(
                                color: controller.isSelected("Select user")
                                    ? Colors.white
                                    : const Color(0xFF4E53B1),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// 🔹 Bottom Buttons
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
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Color(0xFF4E53B1)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.nextStep();
                      Get.to(() => const CreateNewPollThreeScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E53B1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Next"),
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
