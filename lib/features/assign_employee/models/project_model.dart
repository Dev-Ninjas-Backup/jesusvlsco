// Add these classes at the end of project_model.dart (no other changes)

import 'package:jesusvlsco/features/assign_employee/models/assign_user_response_model.dart';

class UserShiftScheduleResponse {
  final bool success;
  final String message;
  final UserShiftScheduleData data;

  UserShiftScheduleResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserShiftScheduleResponse.fromJson(Map<String, dynamic> json) {
    return UserShiftScheduleResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: UserShiftScheduleData.fromJson(json['data'] ?? {}),
    );
  }
}

class UserShiftScheduleData {
  final UserData user;
  final List<ProjectWithShifts> projectWithShifts;

  UserShiftScheduleData({required this.user, required this.projectWithShifts});

  factory UserShiftScheduleData.fromJson(Map<String, dynamic> json) {
    return UserShiftScheduleData(
      user: UserData.fromJson(json['user'] ?? {}),
      projectWithShifts:
          (json['projectWithShifts'] as List<dynamic>?)
              ?.map((item) => ProjectWithShifts.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class UserData {
  final String id;
  final String email;
  final bool isAvailable;
  final String firstName;
  final String lastName;
  final String profileUrl;
  final List<String> offDay;

  UserData({
    required this.id,
    required this.email,
    required this.isAvailable,
    required this.firstName,
    required this.lastName,
    required this.profileUrl,
    required this.offDay,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      isAvailable: json['isAvailable'] ?? false,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profileUrl: json['profileUrl'] ?? '',
      offDay: (json['offDay'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }
}

class ProjectWithShifts {
  final ProjectData project;
  final List<ShiftModel> shifts;

  ProjectWithShifts({required this.project, required this.shifts});

  factory ProjectWithShifts.fromJson(Map<String, dynamic> json) {
    return ProjectWithShifts(
      project: ProjectData.fromJson(json['project'] ?? {}),
      shifts:
          (json['shifts'] as List<dynamic>?)
              ?.map((item) => ShiftModel.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class ProjectData {
  final String id;
  final String title;
  final String location;

  ProjectData({required this.id, required this.title, required this.location});

  factory ProjectData.fromJson(Map<String, dynamic> json) {
    return ProjectData(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      location: json['location'] ?? '',
    );
  }
}
