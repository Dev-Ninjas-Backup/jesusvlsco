import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/view_eye_controller.dart';

class QuickViewCard extends StatelessWidget {
  final controller = Get.find<ViewEyeController>();

  QuickViewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Survey Quick View",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4E53B1),
              ),
            ),
          ),
          const SizedBox(height: 16),

          /// Title
          Obx(() => Text(
            "Title: ${controller.surveyTitle.value}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),

          /// Status
          Obx(() => Text.rich(
            TextSpan(
              text: "Status: ",
              children: [
                TextSpan(
                  text: controller.status.value,
                  style: const TextStyle(color: Colors.green),
                )
              ],
            ),
          )),
          const SizedBox(height: 4),

          /// Duration
          Obx(() => Text("Duration: ${controller.duration.value}")),

          /// Top Departments
          const SizedBox(height: 6),
          const Text("Top Departments by response rate:"),
          Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: controller.topDepartments
                .map((dept) => Text("• ${dept["name"]} (${dept["rate"]})"))
                .toList(),
          )),
          const SizedBox(height: 6),

          /// Creator
          Obx(() => Text("Creator : ${controller.creator.value}")),
          /// Category
          Obx(() => Text("Category : ${controller.category.value}")),
          /// Time Remaining
          Obx(() => Text("Time remaining: ${controller.timeRemaining.value}")),

          /// Description
          const SizedBox(height: 6),
          Obx(() => Text("Description: ${controller.description.value}")),
        ],
      ),
    );
  }
}
