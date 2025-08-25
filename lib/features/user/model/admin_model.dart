// import 'package:get/get.dart';

// class Admin {
//   final String id;
//   final String email;
//   final String role;
//   final int employeeID;
//   final bool isLogin;
//   final bool isVerified;
//   final String phone;
//   final int pinCode;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   RxBool isSelected;

//   Admin({
//     required this.id,
//     required this.email,
//     required this.role,
//     required this.employeeID,
//     required this.isLogin,
//     required this.isVerified,
//     required this.phone,
//     required this.pinCode,
//     required this.createdAt,
//     required this.updatedAt,
//     bool selected = false,
//   }) : isSelected = selected.obs;

//   factory Admin.fromJson(Map<String, dynamic> json) {
//     return Admin(
//       id: json['id'] ?? "",
//       email: json['email'] ?? "",
//       role: json['role'] ?? "",
//       employeeID: json['employeeID'] ?? 0,
//       isLogin: json['isLogin'] ?? false,
//       isVerified: json['isVerified'] ?? false,
//       phone: json['phone'] ?? "",
//       pinCode: json['pinCode'] ?? 0,
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }
// }