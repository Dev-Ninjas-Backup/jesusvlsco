// Model for the API response
class AssignShiftModel {
  final bool success;
  final String message;
  final List<ProjectData> data;

  AssignShiftModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AssignShiftModel.fromJson(Map<String, dynamic> json) {
    return AssignShiftModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>)
          .map((item) => ProjectData.fromJson(item))
          .toList(),
    );
  }
}

// Model for metadata (if needed)
class Metadata {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  Metadata({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 1,
    );
  }
}

// Model for project data
class ProjectData {
  final User user;
  final Project project;
  final List<Shift> shifts;

  ProjectData({
    required this.user,
    required this.project,
    required this.shifts,
  });

  factory ProjectData.fromJson(Map<String, dynamic> json) {
    return ProjectData(
      user: User.fromJson(json['user'] ?? {}),
      project: Project.fromJson(json['project'] ?? {}),
      shifts: (json['shifts'] as List<dynamic>)
          .map((item) => Shift.fromJson(item))
          .toList(),
    );
  }
}

// Model for user
class User {
  final String id;
  final String email;
  final bool isAvailable;
  final String firstName;
  final String lastName;
  final String profileUrl;
  final List<String> offDay;

  User({
    required this.id,
    required this.email,
    required this.isAvailable,
    required this.firstName,
    required this.lastName,
    required this.profileUrl,
    required this.offDay,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      isAvailable: json['isAvailable'] ?? false,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profileUrl: json['profileUrl'] ?? '',
      offDay: List<String>.from(json['offDay'] ?? []),
    );
  }
}

// Model for project
class Project {
  final String id;
  final String title;
  final String location;

  Project({required this.id, required this.title, required this.location});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      location: json['location'] ?? '',
    );
  }
}

// Model for shift
class Shift {
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
  final String note;
  final String job;
  final bool allDay;

  Shift({
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
    required this.note,
    required this.job,
    required this.allDay,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
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
      note: json['note'] ?? '',
      job: json['job'] ?? '',
      allDay: json['allDay'] ?? false,
    );
  }
}
