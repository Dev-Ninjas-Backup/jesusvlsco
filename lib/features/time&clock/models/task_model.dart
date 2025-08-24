/// Task model for shift task management
/// Contains task information with completion status
class TaskModel {
  final String id;
  final String title;
  final bool isCompleted;

  /// Constructor for TaskModel
  /// [id] - Unique identifier for the task
  /// [title] - Task description or title
  /// [isCompleted] - Whether the task is completed
  const TaskModel({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  /// Create a copy of TaskModel with updated values
  TaskModel copyWith({String? id, String? title, bool? isCompleted}) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// Convert TaskModel to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'isCompleted': isCompleted};
  }

  /// Create TaskModel from JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}
