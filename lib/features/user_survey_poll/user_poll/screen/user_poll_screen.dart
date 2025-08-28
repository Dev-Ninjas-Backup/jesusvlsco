import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../controller/user_poll_controller.dart';
import '../../user_survey/widget/survey_tile.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import '../../user_survey/screen/user_survey_screen.dart';

class UserPollScreen extends StatelessWidget {
  const UserPollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserPollController());

    return Scaffold(
      appBar: Custom_appbar(title: "Survey & Poll"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search box
            CustomTextField(
              hintText: "Search polls",
              controller: controller.searchController,
              onChanged: controller.updateSearch,
            ),

            const SizedBox(height: 18),

            // Tab buttons
            Row(
              children: [
                Expanded(
                  child: _buildTabButton(
                    title: 'Surveys',
                    isSelected: false,
                    onTap: () {
                      Get.to(() => const UserSurveyScreen());
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTabButton(
                    title: 'Polls',
                    isSelected: true,
                    onTap: () {
                      // Already on poll screen
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Section header
            const Text(
              "Available polls",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4E53B1),
              ),
            ),
            const SizedBox(height: 8),

            // Subheader row "Poll title"
            const Text(
              "Poll title",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            // List
            Expanded(
              child: Obx(() {
                final list = controller.filteredPolls;
                if (controller.polls.isEmpty) {
                  // still loading or no data
                  return const Center(child: CircularProgressIndicator());
                }
                if (list.isEmpty) {
                  return const Center(child: Text("No polls found"));
                }

                return ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 0),
                  itemBuilder: (context, index) {
                    final item = list[index];
                    final title = (item['title'] ?? '').toString();
                    return SurveyTile(
                      title: title,
                      buttonText: "Take poll",
                      onTap: () => controller.takePoll(item),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Build tab button widget
  Widget _buildTabButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4E53B1) : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF4E53B1) : Colors.grey[300]!,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
