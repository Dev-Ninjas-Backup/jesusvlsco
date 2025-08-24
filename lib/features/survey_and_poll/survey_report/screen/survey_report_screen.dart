import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/common/widgets/custom_appbar.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../controller/survey_report_controller.dart';
import '../widget/survey_report_row.dart';
import '../widget/horizontal_scroll_slider.dart';

class SurveyReportScreen extends StatelessWidget {
  const SurveyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SurveyReportController());

    return Scaffold(
      appBar: Custom_appbar(title: "Survey Report"),
      body: Column(
        children: [
          /// 🔹 Filter + Date Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {},
                    text: "Filter",
                    leadingIcon: const Icon(
                      Icons.filter_list,
                      size: 18,
                      color: Color(0xFF4E53B1),
                    ),
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
                    onPressed: () {
                      controller.toggleDateSort(); // 👉 sort by date
                    },
                    text: "Date",
                    leadingIcon: const Icon(
                      Icons.calendar_today,
                      size: 18,
                      color: Color(0xFF4E53B1),
                    ),
                    trailingIcon: Obx(
                      () => Icon(
                        controller.isAscending.value
                            ? Icons
                                  .arrow_upward // ascending
                            : Icons.arrow_downward, // descending
                        size: 18,
                        color: const Color(0xFF4E53B1),
                      ),
                    ),
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

          /// 🔹 Table (header + rows scroll together)
          Expanded(
            child: Obx(() {
              return SingleChildScrollView(
                controller: controller.scrollController,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 1054, // total table width
                  child: Column(
                    children: [
                      /// Header Row
                      Container(
                        color: Colors.grey.shade100,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            // Date
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Date",
                                softWrap: true,
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF4E53B1),
                                ),
                              ),
                            ),

                            // Name
                            SizedBox(
                              width: 160,
                              child: Text(
                                "Your name",
                                softWrap: true,
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF4E53B1),
                                ),
                              ),
                            ),

                            // Job Satisfaction
                            SizedBox(
                              width: 200,
                              child: Text(
                                "How satisfied are you with your current job?",
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF4E53B1),
                                ),
                              ),
                            ),

                            // Manager Support
                            SizedBox(
                              width: 200,
                              child: Text(
                                "How supportive is your manager helping goals?",
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF4E53B1),
                                ),
                              ),
                            ),

                            // Work-life Balance
                            SizedBox(
                              width: 200,
                              child: Text(
                                "Do you feel you have a good work-life balance?",
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF4E53B1),
                                ),
                              ),
                            ),

                            // Rating
                            SizedBox(
                              width: 150,
                              child: Text(
                                "Do you like support from team leader? (Rating)",
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF4E53B1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Data Rows
                      Expanded(
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).size.height *
                              0.65, // adjust
                          child: ListView.separated(
                            itemCount: controller.reports.length,
                            separatorBuilder: (_, __) =>
                                Divider(height: 1, color: Colors.grey.shade300),
                            itemBuilder: (context, index) {
                              return SurveyReportRow(
                                report: controller.reports[index],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),

          /// 🔹 Horizontal Slider
          HorizontalScrollSlider(
            scrollController: controller.scrollController,
            scrollPosition: controller.scrollPosition,
            maxScrollExtent: controller.maxScrollExtent,
            onSliderDrag: controller.onSliderDrag,
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
