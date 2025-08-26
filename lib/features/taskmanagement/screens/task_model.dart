class TaskData {
  final Analytics? analytics;
  final List<Task>? data;
  final List<dynamic>? overdueTasks;
  final Grouped? grouped;
  final Meta? meta;

  TaskData({
    this.analytics,
    this.data,
    this.overdueTasks,
    this.grouped,
    this.meta,
  });

  factory TaskData.fromJson(Map<String, dynamic> json) {
    return TaskData(
      analytics: json['analytics'] != null ? Analytics.fromJson(json['analytics']) : null,
      data: json['data'] != null ? (json['data'] as List).map((i) => Task.fromJson(i)).toList() : null,
      overdueTasks: json['overdueTasks'] as List<dynamic>?,
      grouped: json['grouped'] != null ? Grouped.fromJson(json['grouped']) : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }
}

class Analytics {
  final int? total;
  final int? done;
  final int? open;

  Analytics({
    this.total,
    this.done,
    this.open,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) {
    return Analytics(
      total: json['total'] as int?,
      done: json['done'] as int?,
      open: json['open'] as int?,
    );
  }
}

class Task {
  final String? id;
  final String? title;
  final String? description;
  final String? startTime;
  final String? endTime;
  final String? location;
  final String? attachment;
  final String? labels;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? projectId;
  final List<TasksUser>? tasksUsers;
  final AssignTo? assignTo;

  Task({
    this.id,
    this.title,
    this.description,
    this.startTime,
    this.endTime,
    this.location,
    this.attachment,
    this.labels,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.projectId,
    this.tasksUsers,
    this.assignTo,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      location: json['location'] as String?,
      attachment: json['attachment'] as String?,
      labels: json['labels'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      projectId: json['projectId'] as String?,
      tasksUsers: json['tasksUsers'] != null ? (json['tasksUsers'] as List).map((i) => TasksUser.fromJson(i)).toList() : null,
      assignTo: json['assignTo'] != null ? AssignTo.fromJson(json['assignTo']) : null,
    );
  }
}

class TasksUser {
  final String? id;
  final String? taskId;
  final String? userId;
  final String? createdAt;
  final String? updatedAt;
  final User? user;

  TasksUser({
    this.id,
    this.taskId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory TasksUser.fromJson(Map<String, dynamic> json) {
    return TasksUser(
      id: json['id'] as String?,
      taskId: json['taskId'] as String?,
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class User {
  final String? id;
  final String? phone;
  final int? employeeID;
  final String? email;
  final String? role;
  final bool? isLogin;
  final String? lastLoginAt;
  final String? password;
  final dynamic otp;
  final dynamic otpExpiresAt;
  final bool? isVerified;
  final int? pinCode;
  final String? createdAt;
  final String? updatedAt;
  final Profile? profile;

  User({
    this.id,
    this.phone,
    this.employeeID,
    this.email,
    this.role,
    this.isLogin,
    this.lastLoginAt,
    this.password,
    this.otp,
    this.otpExpiresAt,
    this.isVerified,
    this.pinCode,
    this.createdAt,
    this.updatedAt,
    this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      phone: json['phone'] as String?,
      employeeID: json['employeeID'] as int?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      isLogin: json['isLogin'] as bool?,
      lastLoginAt: json['lastLoginAt'] as String?,
      password: json['password'] as String?,
      otp: json['otp'],
      otpExpiresAt: json['otpExpiresAt'],
      isVerified: json['isVerified'] as bool?,
      pinCode: json['pinCode'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      profile: json['profile'] != null ? Profile.fromJson(json['profile']) : null,
    );
  }
}

class Profile {
  final String? id;
  final String? firstName;
  final String? lastName;
  final dynamic profileUrl;
  final String? gender;
  final String? jobTitle;
  final String? department;
  final String? address;
  final String? city;
  final String? state;
  final String? dob;
  final String? country;
  final String? nationality;
  final String? createdAt;
  final String? updatedAt;
  final String? userId;

  Profile({
    this.id,
    this.firstName,
    this.lastName,
    this.profileUrl,
    this.gender,
    this.jobTitle,
    this.department,
    this.address,
    this.city,
    this.state,
    this.dob,
    this.country,
    this.nationality,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      profileUrl: json['profileUrl'],
      gender: json['gender'] as String?,
      jobTitle: json['jobTitle'] as String?,
      department: json['department'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      dob: json['dob'] as String?,
      country: json['country'] as String?,
      nationality: json['nationality'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      userId: json['userId'] as String?,
    );
  }
}

class AssignTo {
  final String? name;
  final String? profileUrl;

  AssignTo({
    this.name,
    this.profileUrl,
  });

  factory AssignTo.fromJson(Map<String, dynamic> json) {
    return AssignTo(
      name: json['name'] as String?,
      profileUrl: json['profileUrl'] as String?,
    );
  }
}

class Grouped {
  final List<Task>? medium;

  Grouped({
    this.medium,
  });

  factory Grouped.fromJson(Map<String, dynamic> json) {
    return Grouped(
      medium: json['MEDIUM'] != null ? (json['MEDIUM'] as List).map((i) => Task.fromJson(i)).toList() : null,
    );
  }
}

class Meta {
  final int? total;
  final int? page;
  final int? limit;
  final int? pages;

  Meta({
    this.total,
    this.page,
    this.limit,
    this.pages,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'] as int?,
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      pages: json['pages'] as int?,
    );
  }
}