class SurveyCircleStatisticsAnalyticsModel {
  final String surveyId;
  final String title;
  final String description;
  final int totalAssigned;
  final int respondedCount;
  final double responsePercentage;
  final int notRespondedCount;
  final double notResponsePercentage;
  final List<dynamic> respondedUsers;
  final List<dynamic> notRespondedUsers;

  SurveyCircleStatisticsAnalyticsModel({
    required this.surveyId,
    required this.title,
    required this.description,
    required this.totalAssigned,
    required this.respondedCount,
    required this.responsePercentage,
    required this.notRespondedCount,
    required this.notResponsePercentage,
    required this.respondedUsers,
    required this.notRespondedUsers,
  });

  factory SurveyCircleStatisticsAnalyticsModel.fromJson(Map<String, dynamic> json) {
    return SurveyCircleStatisticsAnalyticsModel(
      surveyId: json['surveyId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      totalAssigned: json['totalAssigned'] ?? 0,
      respondedCount: json['respondedCount'] ?? 0,
      responsePercentage: (json['responsePercentage'] ?? 0).toDouble(),
      notRespondedCount: json['notRespondedCount'] ?? 0,
      notResponsePercentage: (json['notResponsePercentage'] ?? 0).toDouble(),
      respondedUsers: json['respondedUsers'] ?? [],
      notRespondedUsers: json['notRespondedUsers'] ?? [],
    );
  }
}