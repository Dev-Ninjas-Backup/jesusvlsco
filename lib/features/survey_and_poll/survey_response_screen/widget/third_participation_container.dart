import 'package:flutter/material.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_response_screen/widget/custom_pie_chart.dart';

class ThirdParticipationContainer extends StatelessWidget {
  const ThirdParticipationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Pie Chart
          CustomPieChart(
            size: 100,
            strokeWidth: 25,
            segments: [
              RingSegment(color: Colors.green, fraction: 0.4),
              RingSegment(color: Colors.brown, fraction: 0.1),
              RingSegment(color: Colors.blue, fraction: 0.3),
              RingSegment(color: Colors.orange, fraction: 0.3),
            ],
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Participation by department",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF4E53B1),
                ),
              ),
              _statisticsRow(circleColor: Colors.green, nameText: "sales"),
              _statisticsRow(circleColor: Colors.brown, nameText: "HR"),
              _statisticsRow(circleColor: Colors.blue, nameText: "IT"),
              _statisticsRow(circleColor: Colors.orange, nameText: "Marketing"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statisticsRow({
    required Color circleColor,
    required String nameText,
  }) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Text(nameText),
      ],
    );
  }
}
