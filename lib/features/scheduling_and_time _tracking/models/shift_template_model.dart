/// Shift template model
/// Contains shift template information and serialization methods
class ShiftTemplateModel {
  final String id;
  final String title;
  final String startTime;
  final String endTime;

  const ShiftTemplateModel({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
  });

  /// Create ShiftTemplateModel from JSON
  factory ShiftTemplateModel.fromJson(Map<String, dynamic> json) {
    return ShiftTemplateModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
    );
  }

  /// Convert ShiftTemplateModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'start_time': startTime,
      'end_time': endTime,
    };
  }

  /// Create a copy of ShiftTemplateModel with updated values
  ShiftTemplateModel copyWith({
    String? id,
    String? title,
    String? startTime,
    String? endTime,
  }) {
    return ShiftTemplateModel(
      id: id ?? this.id,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}
