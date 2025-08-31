import 'package:get/get.dart';

class TeamMember {
  final String id;

  TeamMember({required this.id});

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(id: json['id'] ?? '');
  }
}

class TeamListModel {
  final String? id;
  final String title;
  final String description;
  final String department;
  final String? image;
  final String creatorId;
  final String? lastMessageId;
  final String createdAt;
  final String updatedAt;
  final List<TeamMember> members;
  var isSelected = false.obs;

  TeamListModel({
    this.id,
    required this.title,
    required this.description,
    required this.department,
    this.image,
    required this.creatorId,
    this.lastMessageId,
    required this.createdAt,
    required this.updatedAt,
    required this.members,
  });

  factory TeamListModel.fromJson(Map<String, dynamic> jsonData) {
    return TeamListModel(
      id: jsonData["id"] ?? "",
      title: jsonData["title"] ?? "",
      description: jsonData["description"] ?? "",
      department: jsonData["department"] ?? "",
      image: jsonData["image"] ?? "",
      creatorId: jsonData["creatorId"] ?? "",
      lastMessageId: jsonData["lastMessageId"],
      createdAt: jsonData["createdAt"] ?? "",
      updatedAt: jsonData["updatedAt"] ?? "",
      members:
          (jsonData["members"] as List<dynamic>?)
              ?.map((member) => TeamMember.fromJson(member))
              .toList() ??
          [],
    );
  }
}
