// models/assigned_users_model.dart

import 'package:timezone/timezone.dart' as tz;

class AssignedUsersResponse {
  final bool success;
  final String message;
  final List<AssignedUserData> data;

  AssignedUsersResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AssignedUsersResponse.fromJson(Map<String, dynamic> json) {
    return AssignedUsersResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((item) => AssignedUserData.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class AssignedUserData {
  final UserModel user;
  final ProjectInfo project;
  final List<ShiftModel> shifts;
  final List<ShiftModel> allShifts;

  AssignedUserData({
    required this.user,
    required this.project,
    required this.shifts,
    required this.allShifts,
  });

  factory AssignedUserData.fromJson(Map<String, dynamic> json) {
    return AssignedUserData(
      user: UserModel.fromJson(json['user'] ?? {}),
      project: ProjectInfo.fromJson(json['project'] ?? {}),
      shifts:
          (json['shifts'] as List<dynamic>?)
              ?.map((item) => ShiftModel.fromJson(item))
              .toList() ??
          [],
      allShifts:
          (json['allShifts'] as List<dynamic>?)
              ?.map((item) => ShiftModel.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class UserModel {
  final String id;
  final String email;
  final bool isAvailable;
  final String firstName;
  final String lastName;
  final String profileUrl;
  final List<String> offDay;

  UserModel({
    required this.id,
    required this.email,
    required this.isAvailable,
    required this.firstName,
    required this.lastName,
    required this.profileUrl,
    required this.offDay,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      isAvailable: json['isAvailable'] ?? true,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profileUrl: json['profileUrl'] ?? '',
      offDay:
          (json['offDay'] as List<dynamic>?)
              ?.map((item) => item.toString())
              .toList() ??
          [],
    );
  }

  String get fullName => '$firstName $lastName';

  String get formattedOffDays {
    if (offDay.isEmpty) return 'No off days';
    return offDay.join(', ');
  }
}

class ProjectInfo {
  final String id;
  final String title;
  final String location;

  ProjectInfo({required this.id, required this.title, required this.location});

  factory ProjectInfo.fromJson(Map<String, dynamic> json) {
    return ProjectInfo(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      location: json['location'] ?? '',
    );
  }
}

class ShiftModel {
  final String id;
  final String title;
  final String projectId;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final String shiftStatus;
  final String location;
  final double lat;
  final double lng;

  ShiftModel({
    required this.id,
    required this.title,
    required this.projectId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.shiftStatus,
    required this.location,
    required this.lat,
    required this.lng,
  });

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      projectId: json['projectId'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      startTime: DateTime.parse(
        json['startTime'] ?? DateTime.now().toIso8601String(),
      ),
      endTime: DateTime.parse(
        json['endTime'] ?? DateTime.now().toIso8601String(),
      ),
      shiftStatus: json['shiftStatus'] ?? '',
      location: json['location'] ?? '',
      lat: (json['lat'] ?? 0.0).toDouble(),
      lng: (json['lng'] ?? 0.0).toDouble(),
    );
  }

  String get formattedViewerTime {
    // CHANGE THIS to your project's actual timezone (e.g., where shifts are created)
    const String projectTimeZone =
        'UTC'; // or 'America/New_York', 'Asia/Dhaka', etc.

    final location = tz.getLocation(projectTimeZone);

    // Convert project-local naive DateTime to TZ-aware
    final tz.TZDateTime startInProjectTz = tz.TZDateTime.from(
      startTime,
      location,
    );
    final tz.TZDateTime endInProjectTz = tz.TZDateTime.from(endTime, location);

    // Convert to user's local timezone
    final tz.TZDateTime startLocal = startInProjectTz.toLocal();
    final tz.TZDateTime endLocal = endInProjectTz.toLocal();

    final String startStr =
        '${startLocal.hour.toString().padLeft(2, '0')}:${startLocal.minute.toString().padLeft(2, '0')}';
    final String endStr =
        '${endLocal.hour.toString().padLeft(2, '0')}:${endLocal.minute.toString().padLeft(2, '0')}';

    return '$startStr - $endStr';
  }

  String get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }

  String get statusColor {
    switch (shiftStatus.toLowerCase()) {
      case 'published':
        return 'green';
      case 'draft':
        return 'orange';
      case 'cancelled':
        return 'red';
      default:
        return 'grey';
    }
  }
}
