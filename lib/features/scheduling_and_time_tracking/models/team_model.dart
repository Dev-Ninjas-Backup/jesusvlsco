/// Team data model for project management
/// Contains team information and member list
class TeamModel {
  final String id;
  final String name;
  final String? description;
  final String? department;
  final String? image;
  final String? creatorId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<MemberModel> members;

  const TeamModel({
    required this.id,
    required this.name,
    this.description,
    this.department,
    this.image,
    this.creatorId,
    this.createdAt,
    this.updatedAt,
    required this.members,
  });

  /// Create TeamModel from JSON data
  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] ?? '',
      name: json['title'] ?? json['name'] ?? '',
      description: json['description'],
      department: json['department'],
      image: json['image'],
      creatorId: json['creatorId'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      members:
          (json['members'] as List?)
              ?.map((m) => MemberModel.fromTeamMemberJson(m))
              .toList() ??
          [],
    );
  }

  /// Convert TeamModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'description': description,
      'department': department,
      'image': image,
      'creatorId': creatorId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
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
  final String? email;
  final String? phone;
  final int? employeeID;
  final String? role;
  final String? department;
  final String? jobTitle;
  final bool isSelected;

  const MemberModel({
    required this.id,
    required this.name,
    required this.position,
    required this.avatar,
    this.email,
    this.phone,
    this.employeeID,
    this.role,
    this.department,
    this.jobTitle,
    this.isSelected = false,
  });

  /// Create MemberModel from JSON data (general format)
  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      position: json['position'] ?? '',
      avatar: json['avatar'] ?? '',
      email: json['email'],
      phone: json['phone'],
      employeeID: json['employeeID'],
      role: json['role'],
      department: json['department'],
      jobTitle: json['jobTitle'],
      isSelected: json['isSelected'] ?? false,
    );
  }

  /// Create MemberModel from team member JSON (API response format)
  factory MemberModel.fromTeamMemberJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};
    final profile = user['profile'] ?? {};

    return MemberModel(
      id: user['id'] ?? '',
      name: '${profile['firstName'] ?? ''} ${profile['lastName'] ?? ''}'.trim(),
      position: profile['jobTitle'] ?? '',
      avatar: profile['profileUrl'] ?? 'https://i.pravatar.cc/150?img=1',
      email: user['email'],
      phone: user['phone'],
      employeeID: user['employeeID'],
      role: user['role'],
      department: profile['department'],
      jobTitle: profile['jobTitle'],
      isSelected: false,
    );
  }

  /// Create MemberModel from manager/user JSON (API response format)
  factory MemberModel.fromManagerJson(Map<String, dynamic> json) {
    final profile = json['profile'] ?? {};

    return MemberModel(
      id: json['id'] ?? '',
      name: '${profile['firstName'] ?? ''} ${profile['lastName'] ?? ''}'.trim(),
      position: profile['jobTitle'] ?? '',
      avatar: profile['profileUrl'] ?? 'https://i.pravatar.cc/150?img=1',
      email: json['email'],
      phone: json['phone'],
      employeeID: json['employeeID'],
      role: json['role'],
      department: profile['department'],
      jobTitle: profile['jobTitle'],
      isSelected: false,
    );
  }

  /// Convert MemberModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'avatar': avatar,
      'email': email,
      'phone': phone,
      'employeeID': employeeID,
      'role': role,
      'department': department,
      'jobTitle': jobTitle,
      'isSelected': isSelected,
    };
  }

  /// Create a copy of MemberModel with updated fields
  MemberModel copyWith({
    String? id,
    String? name,
    String? position,
    String? avatar,
    String? email,
    String? phone,
    int? employeeID,
    String? role,
    String? department,
    String? jobTitle,
    bool? isSelected,
  }) {
    return MemberModel(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      employeeID: employeeID ?? this.employeeID,
      role: role ?? this.role,
      department: department ?? this.department,
      jobTitle: jobTitle ?? this.jobTitle,
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
