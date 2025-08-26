class TimeOffRequestModel {
  final String id;
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final String type;
  final bool isFullDayOff;
  final int totalDaysOff;
  final String status;
  final String? adminNote;
  final DateTime createdAt;
  final DateTime updatedAt;

  TimeOffRequestModel({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.type,
    required this.isFullDayOff,
    required this.totalDaysOff,
    required this.status,
    this.adminNote,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TimeOffRequestModel.fromJson(Map<String, dynamic> json) {
    return TimeOffRequestModel(
      id: json['id'],
      userId: json['userId'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      reason: json['reason'],
      type: json['type'],
      isFullDayOff: json['isFullDayOff'],
      totalDaysOff: json['totalDaysOff'],
      status: json['status'],
      adminNote: json['adminNote'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
