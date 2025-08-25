class LoginResponse {
  bool success;
  String message;
  LoginData? data; // Made nullable since it might be null on error

  LoginResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
        data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
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
        token: json['token'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'token': token,
      };
}

class User {
  String id;
  String email;
  String? phone; // Made nullable
  int employeeID;
  String role;
  bool isLogin;
  bool isVerified;
  DateTime? lastLoginAt; // Made nullable
  DateTime createdAt;
  DateTime updatedAt;
  Profile? profile; // Made nullable
  List<dynamic> shift;

  User({
    required this.id,
    required this.email,
    this.phone,
    required this.employeeID,
    required this.role,
    required this.isLogin,
    required this.isVerified,
    this.lastLoginAt,
    required this.createdAt,
    required this.updatedAt,
    this.profile,
    required this.shift,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] ?? '',
        email: json['email'] ?? '',
        phone: json['phone'],
        employeeID: json['employeeID'] ?? 0,
        role: json['role'] ?? '',
        isLogin: json['isLogin'] ?? false,
        isVerified: json['isVerified'] ?? false,
        lastLoginAt: json['lastLoginAt'] != null 
            ? DateTime.tryParse(json['lastLoginAt']) 
            : null,
        createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
        updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
        profile: json['profile'] != null 
            ? Profile.fromJson(json['profile']) 
            : null,
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
        'lastLoginAt': lastLoginAt?.toIso8601String(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'profile': profile?.toJson(),
        'shift': shift,
      };
}

class Profile {
  String id;
  String? firstName; // Made nullable
  String? lastName; // Made nullable
  String? profileUrl; // Made nullable
  String? gender; // Made nullable
  String? jobTitle; // Made nullable
  String? department; // Made nullable
  String? address; // Made nullable
  String? city; // Made nullable
  String? state; // Made nullable
  DateTime? dob; // Made nullable
  String? country; // Made nullable
  String? nationality; // Made nullable
  DateTime createdAt;
  DateTime updatedAt;
  String userId;

  Profile({
    required this.id,
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
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json['id'] ?? '',
        firstName: json['firstName'],
        lastName: json['lastName'],
        profileUrl: json['profileUrl'],
        gender: json['gender'],
        jobTitle: json['jobTitle'],
        department: json['department'],
        address: json['address'],
        city: json['city'],
        state: json['state'],
        dob: json['dob'] != null ? DateTime.tryParse(json['dob']) : null,
        country: json['country'],
        nationality: json['nationality'],
        createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
        updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
        userId: json['userId'] ?? '',
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
        'dob': dob?.toIso8601String(),
        'country': country,
        'nationality': nationality,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'userId': userId,
      };
}