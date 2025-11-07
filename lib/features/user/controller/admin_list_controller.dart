
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';

class Admin {
  final String id;
  final String email;
  final String role;
  final int employeeID;
  final bool isLogin;
  final bool isVerified;
  final String phone;
  final int pinCode;
  final DateTime createdAt;
  final DateTime updatedAt;
  RxBool isSelected;

  Admin({
    required this.id,
    required this.email,
    required this.role,
    required this.employeeID,
    required this.isLogin,
    required this.isVerified,
    required this.phone,
    required this.pinCode,
    required this.createdAt,
    required this.updatedAt,
    bool selected = false,
  }) : isSelected = selected.obs;

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'] ?? "",
      email: json['email'] ?? "",
      role: json['role'] ?? "",
      employeeID: json['employeeID'] ?? 0,
      isLogin: json['isLogin'] ?? false,
      isVerified: json['isVerified'] ?? false,
      phone: json['phone'] ?? "",
      pinCode: json['pinCode'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class AdminListController extends GetxController {
  final RxList<Admin> admin = <Admin>[].obs;
  final RxInt currentPage = 1.obs;
  final int limit = 12;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  final RxInt totalAdminCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAdmins(); // Initial load
  }
  
  //to refresh data
 

  Future<void> fetchAdmins() async {
  if (isLoading.value || !hasMore.value) return;

  isLoading.value = true;
  final token = await StorageService.getAuthToken();

  try {
    while (hasMore.value) {
      final url = Uri.parse(
        '${ApiConstants.baseurl}/admin/manage-admin/get-admins?page=${currentPage.value}&limit=$limit',
      );


      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      );

      if (kDebugMode) {
        print('Bearer $token');
      }


      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> data = jsonData['data'];

        if (data.isEmpty) {
          hasMore.value = false;
        } else {
          final newAdmins = data.map((adminJson) => Admin.fromJson(adminJson)).toList();
          admin.addAll(newAdmins);
          currentPage.value++;
        }

        // Optional: break early if fewer than limit returned
        if (data.length < limit) {
          hasMore.value = false;
        }
      } else {
        if (kDebugMode) {
          print("Failed to load admins: ${response.statusCode}");
        }
        hasMore.value = false;
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error fetching admins: $e");
    }
  } finally {
    isLoading.value = false;
  }
}


  /// Selection logic
  void toggleSelection(int index) {
    admin[index].isSelected.value = !admin[index].isSelected.value;
  }

  /// Batch actions
  List<Admin> get selectedAdmins =>
      admin.where((a) => a.isSelected.value).toList();

  void deleteSelectedAdmins() {
    admin.removeWhere((a) => a.isSelected.value);
  }

  void clearSelections() {
    for (var a in admin) {
      a.isSelected.value = false;
    }
  }
}



