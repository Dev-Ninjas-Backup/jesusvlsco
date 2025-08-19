import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SurveyPollStatisticCircle extends StatelessWidget {
  final String? title;
  final double? percent;
  final String? responseRate;
  final int? totalResponses;
  final int? totalPeople;
  final VoidCallback? onViewPressed;
  final Color? progressColor;
  final Color? backgroundColor;
  final double? radius;
  final double? lineWidth;
  final double? startAngle;

  const SurveyPollStatisticCircle({
    super.key,
    this.title,
    this.percent,
    this.responseRate,
    this.totalResponses,
    this.totalPeople,
    this.onViewPressed,
    this.progressColor,
    this.backgroundColor,
    this.radius,
    this.lineWidth,
    this.startAngle,
  });

  @override
  Widget build(BuildContext context) {
    final displayPercent = percent ?? 0.75;
    final displayTitle = title ?? "Employee Satisfaction Survey 2025";
    final displayResponseRate = responseRate ?? "${(displayPercent * 100).toInt()}%";
    final displayTotalResponses = totalResponses ?? 150;
    final displayTotalPeople = totalPeople ?? 200;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: Column(
        children: [
          Text(
            displayTitle,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          CircularPercentIndicator(
            radius: radius ?? 70.0,
            lineWidth: lineWidth ?? 24.0,
            percent: displayPercent,
            center: Text("${(displayPercent * 100).toInt()}%"),
            progressColor: progressColor ?? Colors.green,
            backgroundColor: backgroundColor ?? Colors.grey.shade300,
            startAngle: startAngle ?? 180.0, 
          ),
          SizedBox(height: 16),
          Text(
            "Response Rate: $displayResponseRate ($displayTotalResponses of $displayTotalPeople responded)",
            style: TextStyle(fontSize: 14, color: Color(0xFF949494)),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: onViewPressed ?? () {},
            child: Text("View")
          )
        ],
      ),
    );
  }
}