/// Project model for handling project data from API
/// Based on the API response structure from all_project.json
class ProjectModel {
  final String id;
  final String title;
  final String projectLocation;
  final String createdAt;
  final String updatedAt;
  final String teamId;
  final String managerId;
  final TeamModel team;
  final ManagerModel manager;
  final List<ProjectUserModel> projectUsers;
  final List<TaskModel> tasks;

  ProjectModel({
    required this.id,
    required this.title,
    required this.projectLocation,
    required this.createdAt,
    required this.updatedAt,
    required this.teamId,
    required this.managerId,
    required this.team,
    required this.manager,
    required this.projectUsers,
    required this.tasks,
  });

  /// Create ProjectModel from JSON
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      projectLocation: json['projectLocation'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      teamId: json['teamId'] ?? '',
      managerId: json['managerId'] ?? '',
      team: TeamModel.fromJson(json['team'] ?? {}),
      manager: ManagerModel.fromJson(json['manager'] ?? {}),
      projectUsers:
          (json['projectUsers'] as List<dynamic>?)
              ?.map((user) => ProjectUserModel.fromJson(user))
              .toList() ??
          [],
      tasks:
          (json['tasks'] as List<dynamic>?)
              ?.map((task) => TaskModel.fromJson(task))
              .toList() ??
          [],
    );
  }

  /// Convert ProjectModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'projectLocation': projectLocation,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'teamId': teamId,
      'managerId': managerId,
      'team': team.toJson(),
      'manager': manager.toJson(),
      'projectUsers': projectUsers.map((user) => user.toJson()).toList(),
      'tasks': tasks.map((task) => task.toJson()).toList(),
    };
  }

  /// Create a copy of ProjectModel with updated fields
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
