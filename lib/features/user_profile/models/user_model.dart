// user_profile_model.dart
class UserProfileModel {
  final bool success;
  final String message;
  final UserData data;

  UserProfileModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final String? id;
  final String? email;
  final String? phone;
  final int? employeeID;
  final String? role;
  final bool? isLogin;
  final bool? isVerified;
  final Profile? profile;

  UserData({
    this.id,
    this.email,
    this.phone,
    this.employeeID,
    this.role,
    this.isLogin,
    this.isVerified,
    this.profile,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      employeeID: json['employeeID'],
      role: json['role'],
      isLogin: json['isLogin'],
      isVerified: json['isVerified'],
      profile: json['profile'] != null
          ? Profile.fromJson(json['profile'])
          : null,
    );
  }
}

class Profile {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? profileUrl;
  final String? gender;
  final String? jobTitle;
  final String? department;
  final String? address;
  final String? city;
  final String? state;
  final DateTime? dob;
  final String? country;
  final String? nationality;
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
    this.userId,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profileUrl: json['profileUrl'],
      gender: json['gender'],
      jobTitle: json['jobTitle'],
      department: json['department'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      country: json['country'],
      nationality: json['nationality'],
      userId: json['userId'],
    );
  }
}
