import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/core/common/widgets/custom_button.dart';
import 'package:jesusvlsco/core/common/widgets/custom_text_field.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_publish_screen/create_new_survey_screen/widget/publish_survey_progress_indicator.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_publish_screen/publish_create_new_survey_three_screen/screen/publish_create_new_survey_three_screen.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_publish_screen/publish_create_new_survey_two_screen/controller/publish_create_new_survey_two_controller.dart';


class PublishCreateNewSurveyTwoScreen extends StatelessWidget {
  const PublishCreateNewSurveyTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PublishCreateNewSurveyTwoController());

    final steps = ["Assign by", "Recipients", "Publish settings", "Summary"];

    return Scaffold(
      appBar: Custom_appbar(title: "Create New Survey"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Progress Indicator
            Center(
              child: PublishSurveyProgressIndicator(
                currentStep: 2, // fixed: Recipients step
                steps: steps,
              ),
            ),
            const SizedBox(height: 24),

            /// Title
            const Text(
              "Select user from the list",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4E53B1),
              ),
            ),
            const SizedBox(height: 16),

            /// Search & Filter Row
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: "Search users...",
                    controller: controller.searchController,
                    onChanged: controller.updateSearch,
                  ),
                ),
                const SizedBox(width: 8),
                CustomButton(
                  onPressed: () {
                  },
                  text: "Filter",
                  leadingIcon:
                  const Icon(Icons.filter_list, color: Color(0xFF4E53B1)),
                  decorationColor: Colors.white,
                  borderColor: const Color(0xFF4E53B1),
                  textColor: const Color(0xFF4E53B1),
                  fontWeight: FontWeight.w500,
                  borderRadius: 8,
                )
              ],
            ),
            const SizedBox(height: 16),

            /// User List Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(8)),
                color: Colors.grey.shade100,
              ),
              child: Row(
                children: const [
                  SizedBox(
                      width: 30, child: Checkbox(value: false, onChanged: null)),
                  Expanded(
                      child: Text("Name",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(
                      width: 80,
                      child: Text("ID",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),


            /// User List
            Expanded(
              child: Obx(() {
                final users = controller.filteredUsers;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.grey.shade300),
                          right: BorderSide(color: Colors.grey.shade300),
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Row(
                        children: [
                          Obx(() => Checkbox(
                            value: controller.selectedUsers.contains(user["id"]),
                            onChanged: (val) {
                              controller.toggleUser(user["id"] as int);
                            },
                          )),
                          CircleAvatar(
                            backgroundImage: NetworkImage(user["avatar"] as String),
                            radius: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Text(user["name"] as String)),
                          SizedBox(width: 80, child: Text(user["id"].toString())),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),


            /// Pagination
            Obx(() {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: List.generate(8, (index) {
                        final page = index + 1;
                        final isActive = controller.currentPage.value == page;
                        return GestureDetector(
                          onTap: () => controller.setPage(page),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFF4E53B1)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isActive
                                    ? Colors.transparent
                                    : const Color(0xFF4E53B1).withValues(alpha: 0.3),
                                width: 1.2,
                              ),
                            ),
                            child: Text(
                              page.toString(),
                              style: TextStyle(
                                color: isActive ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              );
            }),

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
                    borderRadius: 8,
                    isExpanded: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      controller.goToNextStep();
                      Get.to(PublishCreateNewSurveyThreeScreen());
                    },
                    text: "Next step",
                    textColor: Colors.white,
                    decorationColor: const Color(0xFF4E53B1),
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
