/// Activity model for shift activity tracking
/// Contains activity information with user details and timestamps
class ActivityModel {
  final String id;
  final String userName;
  final String userAvatar;
  final String action;
  final DateTime timestamp;

  /// Constructor for ActivityModel
  /// [id] - Unique identifier for the activity
  /// [userName] - Name of the user who performed the action
  /// [userAvatar] - Avatar URL or path for the user
  /// [action] - Description of the action performed
  /// [timestamp] - When the action was performed
  const ActivityModel({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.action,
    required this.timestamp,
  });

  /// Create a copy of ActivityModel with updated values
  ActivityModel copyWith({
    String? id,
    String? userName,
    String? userAvatar,
    String? action,
    DateTime? timestamp,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      action: action ?? this.action,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  /// Convert ActivityModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'userAvatar': userAvatar,
      'action': action,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  /// Create ActivityModel from JSON
  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      userAvatar: json['userAvatar'] ?? '',
      action: json['action'] ?? '',
      timestamp: DateTime.parse(
        json['timestamp'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  /// Get formatted time string (e.g., "2:30 PM")
  String get formattedTime {
    final hour = timestamp.hour > 12 ? timestamp.hour - 12 : timestamp.hour;
    final period = timestamp.hour >= 12 ? 'PM' : 'AM';
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }
}
