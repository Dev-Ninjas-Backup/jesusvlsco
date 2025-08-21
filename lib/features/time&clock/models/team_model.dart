/// Team data model for project management
/// Contains team information and member list
class TeamModel {
  final String id;
  final String name;
  final List<MemberModel> members;

  const TeamModel({
    required this.id,
    required this.name,
    required this.members,
  });

  /// Create TeamModel from JSON data
  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      members:
          (json['members'] as List?)
              ?.map((m) => MemberModel.fromJson(m))
              .toList() ??
          [],
    );
  }

  /// Convert TeamModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'members': members.map((m) => m.toJson()).toList(),
    };
  }
}

/// Member data model for team management
/// Contains individual member information and selection state
class MemberModel {
  final String id;
  final String name;
  final String position;
  final String avatar;
  final bool isSelected;

  const MemberModel({
    required this.id,
    required this.name,
    required this.position,
    required this.avatar,
    this.isSelected = false,
  });

  /// Create MemberModel from JSON data
  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      position: json['position'] ?? '',
      avatar: json['avatar'] ?? '',
      isSelected: json['isSelected'] ?? false,
    );
  }

  /// Convert MemberModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'avatar': avatar,
      'isSelected': isSelected,
    };
  }

  /// Create a copy of MemberModel with updated fields
  MemberModel copyWith({
    String? id,
    String? name,
    String? position,
    String? avatar,
    bool? isSelected,
  }) {
    return MemberModel(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      avatar: avatar ?? this.avatar,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
