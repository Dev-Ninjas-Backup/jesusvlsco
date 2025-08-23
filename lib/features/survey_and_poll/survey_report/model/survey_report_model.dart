class SurveyReportModel {
  final String date;
  final String name;
  final String jobSatisfaction;
  final String managerSupport;
  final String workLifeBalance;
  final int leaderRating;

  SurveyReportModel({
    required this.date,
    required this.name,
    required this.jobSatisfaction,
    required this.managerSupport,
    required this.workLifeBalance,
    required this.leaderRating,
  });
}
