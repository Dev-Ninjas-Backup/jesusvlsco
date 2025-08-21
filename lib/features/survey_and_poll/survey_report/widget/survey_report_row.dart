import 'package:flutter/material.dart';
import '../model/survey_report_model.dart';

class SurveyReportRow extends StatelessWidget {
  final SurveyReportModel report;

  const SurveyReportRow({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(report.date)),
          SizedBox(width: 160, child: Text(report.name)),
          SizedBox(width: 200, child: Text(report.jobSatisfaction)),
          SizedBox(width: 200, child: Text(report.managerSupport)),
          SizedBox(width: 200, child: Text(report.workLifeBalance)),
          SizedBox(
            width: 150,
            child: Row(
              children: List.generate(
                5,
                    (i) => Icon(
                  i < report.leaderRating ? Icons.star : Icons.star_border,
                  size: 16,
                  color: Color(0xFF4E53B1),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
