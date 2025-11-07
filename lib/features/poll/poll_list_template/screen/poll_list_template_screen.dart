import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/features/poll/create_new_poll/screen/create_new_poll_screen.dart';

import '../../create_new_poll/widgets/custom_drop_down_field.dart';
import '../controller/poll_list_template_controller.dart';
import '../widget/search_bar.dart';

class PollListTemplateScreen extends StatelessWidget {
  final bool isPoll;
  const PollListTemplateScreen({super.key,required this.isPoll});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PollListTemplateController());

    return Scaffold(
      appBar: Custom_appbar(title: "Templates"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(
              () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Dropdown
              Text("Type"),
              SizedBox(height: 8),
              CustomDropdownField(
                value: controller.pollType.value,
                items: controller.pollTypes,
                onChanged: controller.setPollType,
              ),
              const SizedBox(height: 20),

              /// Section Title (Dynamic with Poll/Survey type)
              Text(
                "Employee Satisfaction ${controller.pollType.value} Template",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF4E53B1),
                ),
              ),
              const SizedBox(height: 12),

              /// Search + Filter
              SearchBarWithFilter(
                onChanged: (val) => controller.searchQuery.value = val,
                onFilterTap: () {
                },
              ),
              const SizedBox(height: 20),

              /// Template Sections (inline builder, no extra widget file)
              ...controller.pollTemplates.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      entry.key,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF4E53B1),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: entry.value.map((item) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.insert_drive_file_outlined,
                            color: Colors.grey,
                          ),
                          title: Text(item),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            Get.to(CreateNewPollScreen());
                          },
                        );
                      }).toList(),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
