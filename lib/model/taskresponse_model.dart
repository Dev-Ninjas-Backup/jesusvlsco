// lib/features/task/models/task_model.dart

class TaskResponse {
  final bool success;
  final String message;
  final TaskData data;

  TaskResponse({required this.success, required this.message, required this.data});

  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
      success: json['success'],
      message: json['message'],
      data: TaskData.fromJson(json['data']),
    );
  }
}

class TaskData {
  final List<Task> tasks;

  TaskData({required this.tasks});

  factory TaskData.fromJson(Map<String, dynamic> json) {
    return TaskData(
      tasks: (json['data'] as List).map((e) => Task.fromJson(e)).toList(),
    );
  }
}

class Task {
  final String id;
  final String title;
  final String description;
  final String startTime;
  final String endTime;
  final String status;
  final AssignTo assignTo;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.assignTo,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      startTime: json['startTime'],
      endTime: json['endTime'],
      status: json['status'],
      assignTo: AssignTo.fromJson(json['assignTo']),
    );
  }
}

class AssignTo {
  final String name;
  final String? profileUrl;

  AssignTo({required this.name, this.profileUrl});

  factory AssignTo.fromJson(Map<String, dynamic> json) {
    return AssignTo(
      name: json['name'],
      profileUrl: json['profileUrl'],
    );
  }
}
