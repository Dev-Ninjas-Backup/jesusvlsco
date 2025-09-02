class TimeOffRequest {
  final String id;
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final String type;
  final bool isFullDayOff;
  final int totalDaysOff;
  final String status;
  final String? adminNote; // nullable
  final DateTime createdAt;
  final DateTime updatedAt;

  TimeOffRequest({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.type,
    required this.isFullDayOff,
    required this.totalDaysOff,
    required this.status,
    this.adminNote, // allow null
    required this.createdAt,
    required this.updatedAt,
  });

  factory TimeOffRequest.fromJson(Map<String, dynamic> json) {
    return TimeOffRequest(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      reason: json['reason'] ?? '',
      type: json['type'] ?? '',
      isFullDayOff: json['isFullDayOff'] ?? false,
      totalDaysOff: json['totalDaysOff'] ?? 0,
      status: json['status'] ?? '',
      adminNote: json['adminNote'], // nullable
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
