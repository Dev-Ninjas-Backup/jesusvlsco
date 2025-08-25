class NotificationSettingsModel {
  final String id;
  bool email;
  bool communication;
  bool userUpdates;
  bool surveyAndPoll;
  bool tasksAndProjects;
  bool scheduling;
  bool message;
  bool userRegistration;

  NotificationSettingsModel({
    required this.id,
    required this.email,
    required this.communication,
    required this.userUpdates,
    required this.surveyAndPoll,
    required this.tasksAndProjects,
    required this.scheduling,
    required this.message,
    required this.userRegistration,
  });

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) {
    return NotificationSettingsModel(
      id: json["id"],
      email: json["email"] ?? false,
      communication: json["communication"] ?? false,
      userUpdates: json["userUpdates"] ?? false,
      surveyAndPoll: json["surveyAndPoll"] ?? false,
      tasksAndProjects: json["tasksAndProjects"] ?? false,
      scheduling: json["scheduling"] ?? false,
      message: json["message"] ?? false,
      userRegistration: json["userRegistration"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "communication": communication,
      "surveyAndPoll": surveyAndPoll,
      "tasksAndProjects": tasksAndProjects,
      "scheduling": scheduling,
      "message": message,
      "userRegistration": userRegistration,
    };
  }
}
