// import 'package:get/get.dart';

// class Admin {
//   final String name;
//   final String imageUrl;
//   final String code;
//   RxBool isSelected;

//   Admin({
//     required this.name,
//     required this.imageUrl,
//     required this.code,
//     bool selected = false,
//   }) : isSelected = selected.obs;
// }

// class AdminListController extends GetxController {
//   var admin = <Admin>[
//   Admin(name: "Olivia Martinez", imageUrl: "https://i.pravatar.cc/150?img=10", code: "78421"),
//   Admin(name: "Liam Anderson", imageUrl: "https://i.pravatar.cc/150?img=11", code: "45938"),
//   Admin(name: "Sophia Lee", imageUrl: "https://i.pravatar.cc/150?img=12", code: "93215"),
//   Admin(name: "Noah Brown", imageUrl: "https://i.pravatar.cc/150?img=13", code: "67209"),
//   Admin(name: "Isabella Clark", imageUrl: "https://i.pravatar.cc/150?img=14", code: "84576"),
//   Admin(name: "Mason Walker", imageUrl: "https://i.pravatar.cc/150?img=15", code: "21847"),
//   Admin(name: "Ava Harris", imageUrl: "https://i.pravatar.cc/150?img=16", code: "50673"),
//   Admin(name: "Ethan Young", imageUrl: "https://i.pravatar.cc/150?img=17", code: "39482"),
//   Admin(name: "Mia King", imageUrl: "https://i.pravatar.cc/150?img=18", code: "76134"),
// ].obs;

//   void toggleSelection(int index) {
//     admin[index].isSelected.value = !admin[index].isSelected.value;
//   }
// }
import 'package:get/get.dart';
import 'package:jesusvlsco/core/services/network_caller.dart';
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

  final NetworkCaller _networkCaller = NetworkCaller();

  @override
  void onInit() {
    super.onInit();
    fetchAdmins(); // Initial load
  }

  Future<void> fetchAdmins({int page = 1}) async {
    isLoading.value = true;

    final token = await StorageService.getAuthToken();
    print('token $token');

    final url =
        '${ApiConstants.baseurl}/admin/manage-admin/get-admins?page=$page&limit=$limit';

    final response = await _networkCaller.getRequest(url, token: '$token');

    if (response.isSuccess) {
      try {
        final List<dynamic> data = response.responseData['data'];
        admin.value = data.map((e) => Admin.fromJson(e)).toList();
        currentPage.value = page;
        print("successfully access the api");
      } catch (e) {
        print('Parsing error: $e');
      }
    } else {
      print('Admin fetch failed: ${response.errorMessage}');
    }

    isLoading.value = false;
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
