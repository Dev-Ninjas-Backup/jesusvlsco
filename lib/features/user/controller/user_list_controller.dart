import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';

class EmployeeProfile {
  final int employeeID;
  final Profile profile;
  final RxBool isSelected = false.obs;

  EmployeeProfile({required this.employeeID, required this.profile});

  factory EmployeeProfile.fromJson(Map<String, dynamic> json) {
    return EmployeeProfile(
      employeeID: json['employeeID'],
      profile: Profile.fromJson(json['profile']),
    );
  }
}

class Profile {
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String department;
  final String address;
  final String city;
  final String state;
  final String country;
  final String nationality;
  final String gender;
  final String dob;

  Profile({
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.department,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.nationality,
    required this.gender,
    required this.dob,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
      department: json['department'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      nationality: json['nationality'] ?? '',
      gender: json['gender'] ?? '',
      dob: json['dob'] ?? '',
    );
  }
}

class UserListController extends GetxController {
  var employeeProfiles = <EmployeeProfile>[].obs;
  var currentPage = 1.obs;
  final int limit = 10;
  var isLoading = false.obs;
  var hasMore = true.obs;
  RxInt totalEmployeeCount = 0.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchEmployeeProfiles(); // Initial load
  // }

  Future<void> fetchEmployeeProfiles({bool loadMore = false}) async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    final token = await StorageService.getAuthToken();
    final url = Uri.parse(
      '${ApiConstants.baseurl}/admin/user?role=EMPLOYEE&page=${currentPage.value}&limit=$limit',
    );
    print(">>>>call user");

    try {
      //final response = await http.get(Uri.parse(url));
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      );
      print("Bearer $token");
      print("Sending GET request to: $url");
      print("Request headers:");
      print({
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': '*/*',
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> data = jsonData['data'];

        if (data.isEmpty) {
          hasMore.value = false;
        } else {
          final newProfiles = data.map((userJson) {
            return EmployeeProfile.fromJson(userJson);
          }).toList();

          employeeProfiles.addAll(newProfiles);
          totalEmployeeCount.value = employeeProfiles.length;
          currentPage.value++;
          print("Total employees fetched so far: ${totalEmployeeCount.value}");
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching employee profiles: $e');
    } finally {
      isLoading.value = false;
    }
  }

  ///For delete and add employee after selected
  List<EmployeeProfile> get selectedEmployees =>
      employeeProfiles.where((e) => e.isSelected.value).toList();

  void deleteSelectedEmployees() {
    employeeProfiles.removeWhere((e) => e.isSelected.value);
  }

  void clearSelections() {
    for (var e in employeeProfiles) {
      e.isSelected.value = false;
    }
  }
}
