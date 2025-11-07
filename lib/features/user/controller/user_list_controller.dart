// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';

class EmployeeProfile {
  final String id;
  final int employeeID;
  final Profile profile;
  final RxBool isSelected = false.obs;

  EmployeeProfile({
    required this.id,
    required this.employeeID,
    required this.profile,
  });

  factory EmployeeProfile.fromJson(Map<String, dynamic> json) {
    return EmployeeProfile(
      id: json["id"] ?? "",
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
  var searchQuery = ''.obs;
  var isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEmployeeProfiles(); // Initial load
  }

  Future<void> fetchEmployeeProfiles({
    bool loadMore = false,
    String? searchTerm,
  }) async {
    if (isLoading.value || (!hasMore.value && loadMore)) return;

    isLoading.value = true;
    final token = await StorageService.getAuthToken();

    // Reset pagination for new search
    if (!loadMore && searchTerm != null) {
      currentPage.value = 1;
      employeeProfiles.clear();
      hasMore.value = true;
    }

    // Build URL with search parameter if provided
    String url =
        '${ApiConstants.baseurl}/admin/user?role=EMPLOYEE&page=${currentPage.value}&limit=$limit';
    if (searchTerm != null && searchTerm.isNotEmpty) {
      url += '&searchTerm=${Uri.encodeComponent(searchTerm)}';
    }

    final uri = Uri.parse(url);
    print(">>>>call user");

    try {
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      );
      print("Bearer $token");
      print("Sending GET request to: $uri");
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

          if (loadMore) {
            employeeProfiles.addAll(newProfiles);
          } else {
            employeeProfiles.value = newProfiles;
          }

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

  /// Search employees with debouncing
  void searchEmployees(String query) {
    searchQuery.value = query;
    isSearching.value = query.isNotEmpty;

    // Reset and fetch with search term
    fetchEmployeeProfiles(loadMore: false, searchTerm: query);
  }

  /// Load more employees (pagination)
  void loadMoreEmployees() {
    if (!isLoading.value && hasMore.value) {
      String? currentSearch = searchQuery.value.isNotEmpty
          ? searchQuery.value
          : null;
      fetchEmployeeProfiles(loadMore: true, searchTerm: currentSearch);
    }
  }

  /// Clear search and reload initial data
  void clearSearch() {
    searchQuery.value = '';
    isSearching.value = false;
    employeeProfiles.clear();
    currentPage.value = 1;
    hasMore.value = true;
    fetchEmployeeProfiles();
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
