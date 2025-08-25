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
      success: json['success'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final String id;
  final String email;
  final String phone;
  final int employeeID;
  final String role;
  final bool isLogin;
  final bool isVerified;
  final Profile profile;

  UserData({
    required this.id,
    required this.email,
    required this.phone,
    required this.employeeID,
    required this.role,
    required this.isLogin,
    required this.isVerified,
    required this.profile,
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
      profile: Profile.fromJson(json['profile']),
    );
  }
}

class Profile {
  final String id;
  final String firstName;
  final String lastName;
  final String profileUrl;
  final String gender;
  final String jobTitle;
  final String department;
  final String address;
  final String city;
  final String state;
  final DateTime dob;
  final String country;
  final String nationality;
  final String userId;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileUrl,
    required this.gender,
    required this.jobTitle,
    required this.department,
    required this.address,
    required this.city,
    required this.state,
    required this.dob,
    required this.country,
    required this.nationality,
    required this.userId,
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
      dob: DateTime.parse(json['dob']),
      country: json['country'],
      nationality: json['nationality'],
      userId: json['userId'],
    );
  }
}
