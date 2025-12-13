import 'package:jesusvlsco/features/assign_employee/models/assign_user_response_model.dart';

class ProjectModel {
  final String id;
  final String title;
  final String projectLocation;
  final String? createdAt; // ← Now nullable
  final String? updatedAt; // ← Now nullable
  final String teamId;
  final String? managerId; // ← Now nullable
  final TeamModel? team; // ← Now nullable
  final ManagerModel? manager; // ← Now nullable
  final List<ProjectUserModel>? projectUsers; // ← Now nullable
  final List<TaskModel>? tasks; // ← Now nullable

  ProjectModel({
    required this.id,
    required this.title,
    required this.projectLocation,
    this.createdAt,
    this.updatedAt,
    required this.teamId,
    this.managerId,
    this.team,
    this.manager,
    this.projectUsers,
    this.tasks,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      projectLocation: json['projectLocation'] ?? '',
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      teamId: json['teamId'] ?? '',
      managerId: json['managerId'],
      team: json['team'] != null ? TeamModel.fromJson(json['team']) : null,
      manager: json['manager'] != null
          ? ManagerModel.fromJson(json['manager'])
          : null,
      projectUsers: (json['projectUsers'] as List<dynamic>?)
          ?.map((user) => ProjectUserModel.fromJson(user))
          .toList(),
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((task) => TaskModel.fromJson(task))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'projectLocation': projectLocation,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'teamId': teamId,
      'managerId': managerId,
      'team': team?.toJson(),
      'manager': manager?.toJson(),
      'projectUsers': projectUsers?.map((user) => user.toJson()).toList(),
      'tasks': tasks?.map((task) => task.toJson()).toList(),
    };
  }

  ProjectModel copyWith({
    String? id,
    String? title,
    String? projectLocation,
    String? createdAt,
    String? updatedAt,
    String? teamId,
    String? managerId,
    TeamModel? team,
    ManagerModel? manager,
    List<ProjectUserModel>? projectUsers,
    List<TaskModel>? tasks,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      title: title ?? this.title,
      projectLocation: projectLocation ?? this.projectLocation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      teamId: teamId ?? this.teamId,
      managerId: managerId ?? this.managerId,
      team: team ?? this.team,
      manager: manager ?? this.manager,
      projectUsers: projectUsers ?? this.projectUsers,
      tasks: tasks ?? this.tasks,
    );
  }
}

/// Team model for project teams
class TeamModel {
  final String id;
  final String title;
  final String description;
  final String department;
  final String image;
  final String creatorId;
  final String? lastMessageId;
  final String createdAt;
  final String updatedAt;

  TeamModel({
    required this.id,
    required this.title,
    required this.description,
    required this.department,
    required this.image,
    required this.creatorId,
    this.lastMessageId,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create TeamModel from JSON
  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      department: json['department'] ?? '',
      image: json['image'] ?? '',
      creatorId: json['creatorId'] ?? '',
      lastMessageId: json['lastMessageId'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  /// Convert TeamModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'department': department,
      'image': image,
      'creatorId': creatorId,
      'lastMessageId': lastMessageId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

/// Manager model for project managers
class ManagerModel {
  final String id;
  final String phone;
  final int employeeID;
  final String email;
  final String role;
  final bool isLogin;
  final String? lastLoginAt;
  final String password;
  final String? otp;
  final String? otpExpiresAt;
  final bool isVerified;
  final int? pinCode;
  final String createdAt;
  final String updatedAt;

  ManagerModel({
    required this.id,
    required this.phone,
    required this.employeeID,
    required this.email,
    required this.role,
    required this.isLogin,
    this.lastLoginAt,
    required this.password,
    this.otp,
    this.otpExpiresAt,
    required this.isVerified,
    this.pinCode,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create ManagerModel from JSON
  factory ManagerModel.fromJson(Map<String, dynamic> json) {
    return ManagerModel(
      id: json['id'] ?? '',
      phone: json['phone'] ?? '',
      employeeID: json['employeeID'] ?? 0,
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      isLogin: json['isLogin'] ?? false,
      lastLoginAt: json['lastLoginAt'],
      password: json['password'] ?? '',
      otp: json['otp'],
      otpExpiresAt: json['otpExpiresAt'],
      isVerified: json['isVerified'] ?? false,
      pinCode: json['pinCode'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  /// Convert ManagerModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'employeeID': employeeID,
      'email': email,
      'role': role,
      'isLogin': isLogin,
      'lastLoginAt': lastLoginAt,
      'password': password,
      'otp': otp,
      'otpExpiresAt': otpExpiresAt,
      'isVerified': isVerified,
      'pinCode': pinCode,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

/// Project user model for assigned users
class ProjectUserModel {
  final String id;
  final String projectId;
  final String userId;

  ProjectUserModel({
    required this.id,
    required this.projectId,
    required this.userId,
  });

  /// Create ProjectUserModel from JSON
  factory ProjectUserModel.fromJson(Map<String, dynamic> json) {
    return ProjectUserModel(
      id: json['id'] ?? '',
      projectId: json['projectId'] ?? '',
      userId: json['userId'] ?? '',
    );
  }

  /// Convert ProjectUserModel to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'projectId': projectId, 'userId': userId};
  }
}

/// Task model for project tasks
class TaskModel {
  final String projectId;

  TaskModel({required this.projectId});

  /// Create TaskModel from JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(projectId: json['projectId'] ?? '');
  }

  /// Convert TaskModel to JSON
  Map<String, dynamic> toJson() {
    return {'projectId': projectId};
  }
}

/// API Response model for projects
class ProjectApiResponse {
  final bool success;
  final String message;
  final ProjectDataModel data;

  ProjectApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  /// Create ProjectApiResponse from JSON
  factory ProjectApiResponse.fromJson(Map<String, dynamic> json) {
    return ProjectApiResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ProjectDataModel.fromJson(json['data'] ?? {}),
    );
  }

  /// Convert ProjectApiResponse to JSON
  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

/// Project data model containing projects and pagination info
class ProjectDataModel {
  final List<ProjectModel> projects;
  final MetaModel meta;

  ProjectDataModel({required this.projects, required this.meta});

  /// Create ProjectDataModel from JSON
  factory ProjectDataModel.fromJson(Map<String, dynamic> json) {
    return ProjectDataModel(
      projects:
          (json['projects'] as List<dynamic>?)
              ?.map((project) => ProjectModel.fromJson(project))
              .toList() ??
          [],
      meta: MetaModel.fromJson(json['meta'] ?? {}),
    );
  }

  /// Convert ProjectDataModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'projects': projects.map((project) => project.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}

/// Meta model for pagination information
class MetaModel {
  final int total;
  final int page;
  final int limit;
  final int pages;

  MetaModel({
    required this.total,
    required this.page,
    required this.limit,
    required this.pages,
  });

  /// Create MetaModel from JSON
  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      pages: json['pages'] ?? 1,
    );
  }

  /// Convert MetaModel to JSON
  Map<String, dynamic> toJson() {
    return {'total': total, 'page': page, 'limit': limit, 'pages': pages};
  }
}

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
