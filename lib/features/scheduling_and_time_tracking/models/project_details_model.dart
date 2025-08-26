/// ProjectDetailsModel handles the detailed project data with assigned employees
/// This model contains comprehensive project information including team and assigned users
class ProjectDetailsModel {
  final String id;
  final String title;
  final String projectLocation;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String teamId;
  final String managerId;
  final TeamModel team;
  final ManagerModel manager;
  final List<ProjectUserModel> projectUsers;
  final List<dynamic> tasks;

  ProjectDetailsModel({
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

  /// Create ProjectDetailsModel from JSON response
  factory ProjectDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProjectDetailsModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      projectLocation: json['projectLocation'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      teamId: json['teamId'] ?? '',
      managerId: json['managerId'] ?? '',
      team: TeamModel.fromJson(json['team'] ?? {}),
      manager: ManagerModel.fromJson(json['manager'] ?? {}),
      projectUsers:
          (json['projectUsers'] as List<dynamic>?)
              ?.map((user) => ProjectUserModel.fromJson(user))
              .toList() ??
          [],
      tasks: json['tasks'] ?? [],
    );
  }

  /// Convert ProjectDetailsModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'projectLocation': projectLocation,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'teamId': teamId,
      'managerId': managerId,
      'team': team.toJson(),
      'manager': manager.toJson(),
      'projectUsers': projectUsers.map((user) => user.toJson()).toList(),
      'tasks': tasks,
    };
  }
}

/// TeamModel represents team information
class TeamModel {
  final String id;
  final String title;
  final String description;
  final String department;
  final String? image;
  final String creatorId;
  final String? lastMessageId;
  final DateTime createdAt;
  final DateTime updatedAt;

  TeamModel({
    required this.id,
    required this.title,
    required this.description,
    required this.department,
    this.image,
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
      image: json['image'],
      creatorId: json['creatorId'] ?? '',
      lastMessageId: json['lastMessageId'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
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
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

/// ManagerModel represents manager information
class ManagerModel {
  final String id;
  final String phone;
  final int employeeID;
  final String email;
  final String role;
  final bool isLogin;
  final DateTime? lastLoginAt;
  final String password;
  final String? otp;
  final DateTime? otpExpiresAt;
  final bool isVerified;
  final int pinCode;
  final DateTime createdAt;
  final DateTime updatedAt;

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
    required this.pinCode,
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
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.tryParse(json['lastLoginAt'])
          : null,
      password: json['password'] ?? '',
      otp: json['otp'],
      otpExpiresAt: json['otpExpiresAt'] != null
          ? DateTime.tryParse(json['otpExpiresAt'])
          : null,
      isVerified: json['isVerified'] ?? false,
      pinCode: json['pinCode'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
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
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'password': password,
      'otp': otp,
      'otpExpiresAt': otpExpiresAt?.toIso8601String(),
      'isVerified': isVerified,
      'pinCode': pinCode,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

/// ProjectUserModel represents assigned user in project
class ProjectUserModel {
  final String id;
  final String projectId;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel user;

  ProjectUserModel({
    required this.id,
    required this.projectId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  /// Create ProjectUserModel from JSON
  factory ProjectUserModel.fromJson(Map<String, dynamic> json) {
    return ProjectUserModel(
      id: json['id'] ?? '',
      projectId: json['projectId'] ?? '',
      userId: json['userId'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      user: UserModel.fromJson(json['user'] ?? {}),
    );
  }

  /// Convert ProjectUserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'user': user.toJson(),
    };
  }
}

/// UserModel represents user information with profile
class UserModel {
  final String id;
  final String phone;
  final int employeeID;
  final String email;
  final String role;
  final bool isLogin;
  final DateTime? lastLoginAt;
  final String password;
  final String? otp;
  final DateTime? otpExpiresAt;
  final bool isVerified;
  final int? pinCode;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProfileModel? profile;
  final PayrollModel? payroll;
  final List<ShiftModel> shift;
  final List<TaskUserModel> taskUsers;

  UserModel({
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
    this.profile,
    this.payroll,
    required this.shift,
    required this.taskUsers,
  });

  /// Create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      phone: json['phone'] ?? '',
      employeeID: json['employeeID'] ?? 0,
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      isLogin: json['isLogin'] ?? false,
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.tryParse(json['lastLoginAt'])
          : null,
      password: json['password'] ?? '',
      otp: json['otp'],
      otpExpiresAt: json['otpExpiresAt'] != null
          ? DateTime.tryParse(json['otpExpiresAt'])
          : null,
      isVerified: json['isVerified'] ?? false,
      pinCode: json['pinCode'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      profile: json['profile'] != null
          ? ProfileModel.fromJson(json['profile'])
          : null,
      payroll: json['payroll'] != null
          ? PayrollModel.fromJson(json['payroll'])
          : null,
      shift:
          (json['shift'] as List<dynamic>?)
              ?.map((shift) => ShiftModel.fromJson(shift))
              .toList() ??
          [],
      taskUsers:
          (json['taskUsers'] as List<dynamic>?)
              ?.map((taskUser) => TaskUserModel.fromJson(taskUser))
              .toList() ??
          [],
    );
  }

  /// Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'employeeID': employeeID,
      'email': email,
      'role': role,
      'isLogin': isLogin,
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'password': password,
      'otp': otp,
      'otpExpiresAt': otpExpiresAt?.toIso8601String(),
      'isVerified': isVerified,
      'pinCode': pinCode,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'profile': profile?.toJson(),
      'payroll': payroll?.toJson(),
      'shift': shift.map((s) => s.toJson()).toList(),
      'taskUsers': taskUsers.map((t) => t.toJson()).toList(),
    };
  }

  /// Get full name from profile
  String get fullName {
    if (profile != null) {
      return '${profile!.firstName} ${profile!.lastName}'.trim();
    }
    return email; // Fallback to email if no profile
  }

  /// Get avatar URL from profile
  String? get avatarUrl {
    return profile?.profileUrl;
  }

  /// Get job title from profile
  String get jobTitle {
    return profile?.jobTitle.replaceAll('_', ' ') ?? role;
  }
}

/// ProfileModel represents user profile information
class ProfileModel {
  final String id;
  final String firstName;
  final String lastName;
  final String? profileUrl;
  final String gender;
  final String jobTitle;
  final String department;
  final String address;
  final String city;
  final String state;
  final DateTime dob;
  final String? country;
  final String? nationality;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;

  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.profileUrl,
    required this.gender,
    required this.jobTitle,
    required this.department,
    required this.address,
    required this.city,
    required this.state,
    required this.dob,
    this.country,
    this.nationality,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  /// Create ProfileModel from JSON
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profileUrl: json['profileUrl'],
      gender: json['gender'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
      department: json['department'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      dob: DateTime.tryParse(json['dob'] ?? '') ?? DateTime.now(),
      country: json['country'],
      nationality: json['nationality'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      userId: json['userId'] ?? '',
    );
  }

  /// Convert ProfileModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'profileUrl': profileUrl,
      'gender': gender,
      'jobTitle': jobTitle,
      'department': department,
      'address': address,
      'city': city,
      'state': state,
      'dob': dob.toIso8601String(),
      'country': country,
      'nationality': nationality,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'userId': userId,
    };
  }
}

/// PayrollModel - placeholder for payroll data
class PayrollModel {
  PayrollModel();

  factory PayrollModel.fromJson(Map<String, dynamic> json) {
    return PayrollModel();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}

/// ShiftModel represents shift information
class ShiftModel {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final double locationLat;
  final double locationLng;
  final DateTime date;
  final bool allDay;
  final String shiftTitle;
  final String job;
  final String note;
  final String shiftType;
  final String shiftStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? projectId;

  ShiftModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.locationLat,
    required this.locationLng,
    required this.date,
    required this.allDay,
    required this.shiftTitle,
    required this.job,
    required this.note,
    required this.shiftType,
    required this.shiftStatus,
    required this.createdAt,
    required this.updatedAt,
    this.projectId,
  });

  /// Create ShiftModel from JSON
  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      id: json['id'] ?? '',
      startTime: DateTime.tryParse(json['startTime'] ?? '') ?? DateTime.now(),
      endTime: DateTime.tryParse(json['endTime'] ?? '') ?? DateTime.now(),
      location: json['location'] ?? '',
      locationLat: (json['locationLat'] ?? 0.0).toDouble(),
      locationLng: (json['locationLng'] ?? 0.0).toDouble(),
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      allDay: json['allDay'] ?? false,
      shiftTitle: json['shiftTitle'] ?? '',
      job: json['job'] ?? '',
      note: json['note'] ?? '',
      shiftType: json['shiftType'] ?? '',
      shiftStatus: json['shiftStatus'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      projectId: json['projectId'],
    );
  }

  /// Convert ShiftModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'location': location,
      'locationLat': locationLat,
      'locationLng': locationLng,
      'date': date.toIso8601String(),
      'allDay': allDay,
      'shiftTitle': shiftTitle,
      'job': job,
      'note': note,
      'shiftType': shiftType,
      'shiftStatus': shiftStatus,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'projectId': projectId,
    };
  }
}

/// TaskUserModel represents task assignment
class TaskUserModel {
  final String id;
  final String taskId;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  TaskUserModel({
    required this.id,
    required this.taskId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create TaskUserModel from JSON
  factory TaskUserModel.fromJson(Map<String, dynamic> json) {
    return TaskUserModel(
      id: json['id'] ?? '',
      taskId: json['taskId'] ?? '',
      userId: json['userId'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  /// Convert TaskUserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskId': taskId,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

/// ProjectDetailsResponse handles the API response structure
class ProjectDetailsResponse {
  final bool success;
  final String message;
  final ProjectDetailsModel data;

  ProjectDetailsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  /// Create ProjectDetailsResponse from JSON
  factory ProjectDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ProjectDetailsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ProjectDetailsModel.fromJson(json['data'] ?? {}),
    );
  }

  /// Convert ProjectDetailsResponse to JSON
  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}
