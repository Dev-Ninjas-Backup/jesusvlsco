// import 'package:get/get.dart';

// // class UserModel {
// //   final String id;
// //   final String name;
// //   final String email;
// //   final String role;
// //   final String phone;
// //   final int employeeID;
// //   final String? imageUrl;
// //   RxBool isSelected;

// //   UserModel({
// //     required this.id,
// //     required this.name,
// //     required this.email,
// //     required this.role,
// //     required this.phone,
// //     required this.employeeID,
// //     this.imageUrl,
// //     bool selected = false,
// //   }) : isSelected = selected.obs;

// //   factory UserModel.fromJson(Map<String, dynamic> json) {
// //     return UserModel(
// //       id: json['id'] ?? '',
// //       name: json['name'] ?? json['email']?.split('@')?.first ?? 'Unknown',
// //       email: json['email'] ?? '',
// //       role: json['role'] ?? '',
// //       phone: json['phone'] ?? '',
// //       employeeID: json['employeeID'] ?? 0,
// //       imageUrl: json['imageUrl'], // optional
// //     );
// //   }
// // }

// class UserModel {
//   final int employeeID;
//   final List<String> profile;
//   RxBool isSelected;

//   UserModel({
//     required this.employeeID,
//     required this.profile,
//     bool selected = false,
//   }) : isSelected = selected.obs;

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     final profileJson = json['profile'] ?? {};
//     final profileList = <String>[
//       profileJson['firstName'] ?? '',
//       profileJson['lastName'] ?? '',
//       profileJson['gender'] ?? '',
//       profileJson['jobTitle'] ?? '',
//       profileJson['department'] ?? '',
//       profileJson['address'] ?? '',
//       profileJson['city'] ?? '',
//       profileJson['state'] ?? '',
//       profileJson['country'] ?? '',
//       profileJson['nationality'] ?? '',
//     ];

//     return UserModel(
//       employeeID: json['employeeID'] ?? 0,
//       profile: profileList,
//     );
//   }
// }

