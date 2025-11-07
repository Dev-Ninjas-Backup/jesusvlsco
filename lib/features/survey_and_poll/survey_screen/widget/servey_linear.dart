import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SurveyProgressCard extends StatelessWidget {
  final String? title;
  final int? totalResponses;
  final String? status;
  final List<SurveyOption>? options;
  final Color? containerBGColor;
  final String? containerText;

  const SurveyProgressCard({
    super.key,
    this.title,
    this.totalResponses,
    this.status,
    this.options,
    this.containerBGColor,
    this.containerText
  });

  @override
  Widget build(BuildContext context) {
    final displayTitle = title ?? "How satisfied are you with the current safety protocols on-site?";
    final displayResponses = totalResponses ?? 120;
    final displayStatus = status ?? "Live";
    final displayOptions = options ?? [
      SurveyOption("Very satisfied", 60),
      SurveyOption("Satisfied", 14),
      SurveyOption("Neutral", 5),
      SurveyOption("Dissatisfied", 20),
      SurveyOption("Very dissatisfied", 11),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Center(
            child: Text(
              textAlign: TextAlign.center,
              displayTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2196F3),
              ),
            ),
          ),
          SizedBox(height: 12),
          
          // Responses and Status
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Responses: $displayResponses",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(width: 16),
              Text(
                "Status:",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: containerBGColor ?? Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  displayStatus,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          
          // Survey Options with Progress Bars
          ...displayOptions.map((option) => Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      option.label,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "${option.percentage}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return LinearPercentIndicator(
                      width: constraints.maxWidth,
                      lineHeight: 8.0,
                      percent: option.percentage / 100,
                      backgroundColor: Colors.grey.shade300,
                      progressColor: Color(0xFF3F51B5),
                      barRadius: Radius.circular(4),
                      padding: EdgeInsets.zero,
                    );
                  },
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class SurveyOption {
  final String label;
  final int percentage;

  SurveyOption(this.label, this.percentage);
}