import 'package:flutter/material.dart';
import '../model/survey_report_model.dart';

class SurveyReportRow extends StatelessWidget {
  final SurveyReportModel report;

  const SurveyReportRow({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 2, child: Text(report.date)),
          Expanded(flex: 3, child: Text(report.name)),
          Expanded(flex: 3, child: Text(report.status)),
        ],
      ),
    );
  }
}
