import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/common/widgets/custom_appbar.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../controller/survey_report_controller.dart';
import '../widget/survey_report_row.dart';

class SurveyReportScreen extends StatelessWidget {
  const SurveyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SurveyReportController());

    return Scaffold(
      appBar: Custom_appbar(title: "Survey Report"),
      body: Column(
        children: [
          // ✅ Filter + Date Row using CustomButton
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {},
                    text: "Filter",
                    leadingIcon: const Icon(Icons.filter_list, size: 18, color: Color(0xFF4E53B1)),
                    decorationColor: Colors.white,
                    borderColor: const Color(0xFF4E53B1),
                    textColor: const Color(0xFF4E53B1),
                    borderRadius: 8,
                    isExpanded: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    onPressed: () {},
                    text: "Date",
                    leadingIcon: const Icon(Icons.calendar_today, size: 18, color: Color(0xFF4E53B1)),
                    trailingIcon: const Icon(Icons.arrow_drop_down, size: 20, color: Color(0xFF4E53B1)),
                    decorationColor: Colors.white,
                    borderColor: const Color(0xFF4E53B1),
                    textColor: const Color(0xFF4E53B1),
                    borderRadius: 8,
                    isExpanded: true,
                  ),
                ),
              ],
            ),
          ),

          // ✅ Table Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Date",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF4E53B1)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "Your name",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF4E53B1),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "How satisfied are you with your current job?",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF4E53B1)),
                  ),
                ),
              ],
            ),
          ),

          // ✅ Table Data
          Expanded(
            child: Obx(() {
              return ListView.separated(
                itemCount: controller.reports.length,
                separatorBuilder: (_, __) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  return SurveyReportRow(report: controller.reports[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
