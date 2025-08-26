// models/project_model.dart
class ProjectModel {
  final String id;
  final String title;
  final String projectLocation;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String teamId;
  final String? managerId;

  ProjectModel({
    required this.id,
    required this.title,
    required this.projectLocation,
    required this.createdAt,
    required this.updatedAt,
    required this.teamId,
    this.managerId,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      projectLocation: json['projectLocation'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      teamId: json['teamId'] ?? '',
      managerId: json['managerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'projectLocation': projectLocation,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'teamId': teamId,
      'managerId': managerId,
    };
  }
}

class ProjectResponse {
  final bool success;
  final String message;
  final List<ProjectModel> data;
  final ProjectMetadata metadata;

  ProjectResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.metadata,
  });

  factory ProjectResponse.fromJson(Map<String, dynamic> json) {
    return ProjectResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((item) => ProjectModel.fromJson(item))
              .toList() ??
          [],
      metadata: ProjectMetadata.fromJson(json['metadata'] ?? {}),
    );
  }
}

class ProjectMetadata {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  ProjectMetadata({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory ProjectMetadata.fromJson(Map<String, dynamic> json) {
    return ProjectMetadata(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 1,
    );
  }
}
