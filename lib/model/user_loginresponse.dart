class LoginResponse {
  bool success;
  String message;
  LoginData data;

  LoginResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json['success'],
        message: json['message'],
        data: LoginData.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data.toJson(),
      };
}

class LoginData {
  User user;
  String token;

  LoginData({
    required this.user,
    required this.token,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        user: User.fromJson(json['user']),
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'token': token,
      };
}

class User {
  String id;
  String email;
  String phone;
  int employeeID;
  String role;
  bool isLogin;
  bool isVerified;
  DateTime lastLoginAt;
  DateTime createdAt;
  DateTime updatedAt;
  Profile profile;
  List<dynamic> shift;

  User({
    required this.id,
    required this.email,
    required this.phone,
    required this.employeeID,
    required this.role,
    required this.isLogin,
    required this.isVerified,
    required this.lastLoginAt,
    required this.createdAt,
    required this.updatedAt,
    required this.profile,
    required this.shift,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        email: json['email'],
        phone: json['phone'],
        employeeID: json['employeeID'],
        role: json['role'],
        isLogin: json['isLogin'],
        isVerified: json['isVerified'],
        lastLoginAt: DateTime.parse(json['lastLoginAt']),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        profile: Profile.fromJson(json['profile']),
        shift: List<dynamic>.from(json['shift'] ?? []),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'phone': phone,
        'employeeID': employeeID,
        'role': role,
        'isLogin': isLogin,
        'isVerified': isVerified,
        'lastLoginAt': lastLoginAt.toIso8601String(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'profile': profile.toJson(),
        'shift': shift,
      };
}

class Profile {
  String id;
  String firstName;
  String lastName;
  String profileUrl;
  String gender;
  String jobTitle;
  String department;
  String address;
  String city;
  String state;
  DateTime dob;
  String country;
  String nationality;
  DateTime createdAt;
  DateTime updatedAt;
  String userId;

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
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
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
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() => {
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
