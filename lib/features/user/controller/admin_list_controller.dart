import 'dart:convert';
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
  final RxBool isLoading = false.obs;
  final RxInt currentPage = 1.obs;
  final int limit = 8;

  @override
  void onInit() {
    super.onInit();
    // Initial load
  }

  Future<void> fetchAdmins({int page = 1}) async {
    isLoading.value = true;
    print('call admin');

    final token = await StorageService.getAuthToken();

    final url = Uri.parse(
      '${ApiConstants.baseurl}/admin/manage-admin/get-admins?page=$page&limit=$limit',
    );


    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      );
      print('Bearer $token');
      

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> data = jsonData['data'];
        admin.value = data.map((e) => Admin.fromJson(e)).toList();
        currentPage.value = page;
        print("Successfully accessed the API");
      } else {
        print("Failed to load admins: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error fetching admins: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void nextPage() => fetchAdmins(page: currentPage.value + 1);

  void previousPage() {
    if (currentPage.value > 1) {
      fetchAdmins(page: currentPage.value - 1);
    }
  }

  void toggleSelection(int index) {
    admin[index].isSelected.value = !admin[index].isSelected.value;
  }
}
