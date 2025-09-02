import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../core/common/widgets/custom_appbar.dart';
import '../controller/response_controller.dart';
import '../widget/response_row.dart';

class ResponseScreen extends StatelessWidget {
  const ResponseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResponseController());

    return Scaffold(
      appBar: Custom_appbar(title: "Response"),
      body: Column(
        children: [
          // ✅ Top cards (viewed / not viewed)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildCard(
                    percent: 0.8,
                    count: "210 /250",
                    label: "Users Have viewed",
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildCard(
                    percent: 0.2,
                    count: "40 /1250",
                    label: "Users have not viewed",
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),

          // ✅ Table header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            color: Colors.grey.shade100,
            child: const Row(
              children: [
                SizedBox(width: 40, child: Text("")),
                Expanded(
                  child: Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    "Status",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // ✅ List of responses
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.responses.length,
                itemBuilder: (context, index) {
                  return ResponseRow(response: controller.responses[index]);
                },
              );
            }),
          ),

          // ✅ Pagination
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Obx(() {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(12, (index) {
                      final page = index + 1;
                      final isActive = controller.currentPage.value == page;
                      return GestureDetector(
                        onTap: () => controller.currentPage.value = page,
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
                                  : const Color(
                                      0xFF4E53B1,
                                    ).withValues(alpha: 0.3),
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
              );
            }),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  /// 🔹 Custom card builder (like screenshot #2)
  Widget _buildCard({
    required double percent,
    required String count,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularPercentIndicator(
            radius: 40.0,
            lineWidth: 8.0,
            percent: percent,
            startAngle: 290,
            center: Text(
              "${(percent * 100).toInt()}%",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: color,
              ),
            ),
            progressColor: color,
            backgroundColor: color.withValues(alpha: 0.2),
            circularStrokeCap: CircularStrokeCap.round,
            animation: true,
            animationDuration: 800,
          ),
          const SizedBox(height: 12),
          Text(
            count,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
