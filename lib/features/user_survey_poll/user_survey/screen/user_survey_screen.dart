import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../controller/user_survey_controller.dart';
import '../widget/survey_tile.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';

class UserSurveyScreen extends StatelessWidget {
  const UserSurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserSurveyController());

    return Scaffold(
      appBar: Custom_appbar(title: "Survey & Poll"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search box
            CustomTextField(
              hintText: "Search articles",
              controller: controller.searchController,
              onChanged: controller.updateSearch,
            ),

            const SizedBox(height: 18),

            // Section header
            const Text(
              "Available survey",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4E53B1),
              ),
            ),
            const SizedBox(height: 8),

            // Subheader row "Survey title"
            const Text(
              "Survey title",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            // List
            Expanded(
              child: Obx(() {
                final list = controller.filteredSurveys;
                if (controller.surveys.isEmpty) {
                  // still loading or no data
                  return const Center(child: CircularProgressIndicator());
                }
                if (list.isEmpty) {
                  return const Center(child: Text("No surveys found"));
                }

                return ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 0),
                  itemBuilder: (context, index) {
                    final item = list[index];
                    final title = (item['title'] ?? '').toString();
                    return SurveyTile(
                      title: title,
                      onTap: () => controller.takeSurvey(item),
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
}
