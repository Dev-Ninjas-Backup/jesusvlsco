// ignore_for_file: constant_identifier_names

class TimeOffRequestModel {
  final bool success;
  final String message;
  final List<TimeOffRequestData> data;
  final TimeOffRequestMetadata metadata;

  const TimeOffRequestModel({
    required this.success,
    required this.message,
    required this.data,
    required this.metadata,
  });

  /// Factory constructor to create model from JSON response
  factory TimeOffRequestModel.fromJson(Map<String, dynamic> json) {
    return TimeOffRequestModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((item) => TimeOffRequestData.fromJson(item))
              .toList() ??
          [],
      metadata: TimeOffRequestMetadata.fromJson(json['metadata'] ?? {}),
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
      'metadata': metadata.toJson(),
    };
  }
}

/// TimeOffRequestData represents individual time-off request
class TimeOffRequestData {
  final String id;
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final TimeOffRequestType type;
  final bool isFullDayOff;
  final int totalDaysOff;
  final TimeOffRequestStatus status;
  final String? adminNote;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TimeOffRequestUser user;

  const TimeOffRequestData({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.type,
    required this.isFullDayOff,
    required this.totalDaysOff,
    required this.status,
    this.adminNote,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  /// Factory constructor to create from JSON
  factory TimeOffRequestData.fromJson(Map<String, dynamic> json) {
    return TimeOffRequestData(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      startDate: DateTime.parse(
        json['startDate'] ?? DateTime.now().toIso8601String(),
      ),
      endDate: DateTime.parse(
        json['endDate'] ?? DateTime.now().toIso8601String(),
      ),
      reason: json['reason'] ?? '',
      type: _parseTimeOffRequestType(json['type']),
      isFullDayOff: json['isFullDayOff'] ?? false,
      totalDaysOff: json['totalDaysOff'] ?? 0,
      status: _parseTimeOffRequestStatus(json['status']),
      adminNote: json['adminNote'],
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
      user: TimeOffRequestUser.fromJson(json['user'] ?? {}),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'reason': reason,
      'type': type.toString().split('.').last,
      'isFullDayOff': isFullDayOff,
      'totalDaysOff': totalDaysOff,
      'status': status.toString().split('.').last,
      'adminNote': adminNote,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'user': user.toJson(),
    };
  }

  /// Helper method to parse time-off request type
  static TimeOffRequestType _parseTimeOffRequestType(String? type) {
    switch (type?.toUpperCase()) {
      case 'SICK_LEAVE':
        return TimeOffRequestType.SICK_LEAVE;
      case 'VACATION':
        return TimeOffRequestType.VACATION;
      case 'PERSONAL':
        return TimeOffRequestType.PERSONAL;
      case 'EMERGENCY':
        return TimeOffRequestType.EMERGENCY;
      default:
        return TimeOffRequestType.SICK_LEAVE;
    }
  }

  /// Helper method to parse time-off request status
  static TimeOffRequestStatus _parseTimeOffRequestStatus(String? status) {
    switch (status?.toUpperCase()) {
      case 'PENDING':
        return TimeOffRequestStatus.PENDING;
      case 'APPROVED':
        return TimeOffRequestStatus.APPROVED;
      case 'REJECTED':
        return TimeOffRequestStatus.REJECTED;
      default:
        return TimeOffRequestStatus.PENDING;
    }
  }
}

/// TimeOffRequestUser represents the user who made the request
class TimeOffRequestUser {
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
  final TimeOffRequestProfile? profile;

  const TimeOffRequestUser({
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
  });

  /// Factory constructor to create from JSON
  factory TimeOffRequestUser.fromJson(Map<String, dynamic> json) {
    return TimeOffRequestUser(
      id: json['id'] ?? '',
      phone: json['phone'] ?? '',
      employeeID: json['employeeID'] ?? 0,
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      isLogin: json['isLogin'] ?? false,
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'])
          : null,
      password: json['password'] ?? '',
      otp: json['otp'],
      otpExpiresAt: json['otpExpiresAt'] != null
          ? DateTime.parse(json['otpExpiresAt'])
          : null,
      isVerified: json['isVerified'] ?? false,
      pinCode: json['pinCode'],
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
      profile: json['profile'] != null
          ? TimeOffRequestProfile.fromJson(json['profile'])
          : null,
    );
  }

  /// Convert to JSON
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
    };
  }

  /// Get full name from profile or email
  String get fullName {
    if (profile != null) {
      final firstName = profile!.firstName?.trim() ?? '';
      final lastName = profile!.lastName?.trim() ?? '';
      if (firstName.isNotEmpty || lastName.isNotEmpty) {
        return '$firstName $lastName'.trim();
      }
    }
    return email.split('@').first; // Fallback to email username
  }
}

/// TimeOffRequestProfile represents user profile information
class TimeOffRequestProfile {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? profileUrl;
  final String gender;
  final String jobTitle;
  final String department;
  final String address;
  final String city;
  final String state;
  final DateTime dob;
  final String country;
  final String nationality;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;

  const TimeOffRequestProfile({
    required this.id,
    this.firstName,
    this.lastName,
    this.profileUrl,
    required this.gender,
    required this.jobTitle,
    required this.department,
    required this.address,
    required this.city,
    required this.state,
    required this.dob,
    required this.country,
    required this.nationality,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  /// Factory constructor to create from JSON
  factory TimeOffRequestProfile.fromJson(Map<String, dynamic> json) {
    return TimeOffRequestProfile(
      id: json['id'] ?? '',
      firstName: json['firstName'],
      lastName: json['lastName'],
      profileUrl: json['profileUrl'],
      gender: json['gender'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
      department: json['department'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      dob: DateTime.parse(json['dob'] ?? DateTime.now().toIso8601String()),
      country: json['country'] ?? '',
      nationality: json['nationality'] ?? '',
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
      userId: json['userId'] ?? '',
    );
  }

  /// Convert to JSON
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

/// TimeOffRequestMetadata represents pagination metadata
class TimeOffRequestMetadata {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  const TimeOffRequestMetadata({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  /// Factory constructor to create from JSON
  factory TimeOffRequestMetadata.fromJson(Map<String, dynamic> json) {
    return TimeOffRequestMetadata(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 15,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 1,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'totalPage': totalPage,
    };
  }
}

/// Enum for time-off request types
enum TimeOffRequestType { SICK_LEAVE, VACATION, PERSONAL, EMERGENCY }

/// Enum for time-off request status
enum TimeOffRequestStatus { PENDING, APPROVED, REJECTED }

/// Extension for TimeOffRequestType to get display names
extension TimeOffRequestTypeExtension on TimeOffRequestType {
  /// Get display name for UI
  String get displayName {
    switch (this) {
      case TimeOffRequestType.SICK_LEAVE:
        return 'Sick Leave';
      case TimeOffRequestType.VACATION:
        return 'Vacation';
      case TimeOffRequestType.PERSONAL:
        return 'Personal';
      case TimeOffRequestType.EMERGENCY:
        return 'Emergency';
    }
  }

  /// Get API string value
  String get apiValue {
    return toString().split('.').last;
  }
}

/// Extension for TimeOffRequestStatus to get display names and colors
extension TimeOffRequestStatusExtension on TimeOffRequestStatus {
  /// Get display name for UI
  String get displayName {
    switch (this) {
      case TimeOffRequestStatus.PENDING:
        return 'Pending';
      case TimeOffRequestStatus.APPROVED:
        return 'Approved';
      case TimeOffRequestStatus.REJECTED:
        return 'Rejected';
    }
  }

  /// Get API string value
  String get apiValue {
    return toString().split('.').last;
  }
}
