import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/services/network_caller.dart';
import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';
import 'package:jesusvlsco/features/user/controller/admin_list_controller.dart';
import 'package:jesusvlsco/features/user/controller/user_list_controller.dart';
import 'package:jesusvlsco/features/user/screen/add_user_education_screen.dart';
import 'package:jesusvlsco/features/user/screen/add_user_experience_screen.dart';

import '../screen/add_user_payroll_screen.dart';
import '../screen/view_user_screen.dart';

class AddUserController extends GetxController {
  AdminListController adminListController = Get.put(AdminListController());
  UserListController userListController = Get.put(UserListController());
  void refreshEmployeeAdmin() async {
    adminListController.fetchAdmins();
    userListController.fetchEmployeeProfiles();
  }

  // Observable variables
  final RxString firstName = ''.obs;
  final RxString lastName = ''.obs;
  var selectedRole = Rx<String?>(null);
  var currentStep = 1.obs;
  var isCurrentlyWorking = false.obs;

  // Text controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final employeeIdController = TextEditingController();
  final addressController = TextEditingController();

  // Education Text controllers
  final programController = TextEditingController();
  final institutionController = TextEditingController();
  final yearController = TextEditingController();
  // Multi-education entries
  final RxList<Map<String, dynamic>> educations = <Map<String, dynamic>>[].obs;
  String? createdUserId;
  // Multi-experience entries
  final RxList<Map<String, dynamic>> experiences = <Map<String, dynamic>>[].obs;

  // Experience Text controllers
  final positionController = TextEditingController();
  final companyNameController = TextEditingController();
  final jobTypeController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final descriptionController = TextEditingController();

  // Payroll Text controllers and observables
  final regularPayRateController = TextEditingController();
  final overtimePayRateController = TextEditingController();
  final casualLeaveController = TextEditingController();
  final sickLeaveController = TextEditingController();
  final offDayController = TextEditingController();
  final breakTimeController = TextEditingController();

  // Observable form values
  var selectedGender = Rx<String?>(null);
  var selectedJobTitle = Rx<String?>(null);
  var selectedDepartment = Rx<String?>(null);
  var selectedCity = Rx<String?>(null);
  var selectedState = Rx<String?>(null);
  var selectedDateOfBirth = Rx<DateTime?>(null);

  var selectedPayRateType = Rx<String?>(null);
  var selectedOvertimeRateType = Rx<String?>(null);
  var selectedCasualLeave = Rx<String?>(null);
  var selectedSickLeave = Rx<String?>(null);
  var selectedOffDay = Rx<String?>(null);
  var selectedBreakTime = Rx<String?>(null);

  // Role options
  final List<String> roles = ['Employee', 'Admin'];

  // Job type options
  final List<String> jobTypes = [
    'Full-time',
    'Part-time',
    'Contract',
    'Internship',
    'Freelance',
  ];

  // Pay rate type options
  final List<String> payRateTypes = ['Hour', 'Day', 'Week', 'Month'];

  // Leave options
  final List<String> leaveOptions = [
    '10 days',
    '15 days',
    '20 days',
    '30 days',
  ];

  // Off day options
  final List<String> offDayOptions = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  // Dropdown options
  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> jobTitleOptions = [
    '1901 Thornridge Cir, Shiloh, Hawaii, 811063',
    'Other Location',
  ];
  final List<String> cityOptions = ['America', 'Canada', 'UK'];
  final List<String> stateOptions = ['Los angeles', 'New York', 'California'];

  // Break time options
  final List<String> breakTimeOptions = ['30 min', '1 hour', '3 hour'];

  // Profile image path (local file path). UI may set this when image is picked.
  // profile image upload removed — currently not needed

  @override
  void onInit() {
    super.onInit();
    // Initialize controllers
    firstNameController.addListener(() {
      firstName.value = firstNameController.text;
    });
    lastNameController.addListener(() {
      lastName.value = lastNameController.text;
    });
  }

  void setRole(String role) {
    selectedRole.value = role;
  }

  void setCurrentStep(int step) {
    currentStep.value = step;
  }

  void setPayRateType(String type) {
    selectedPayRateType.value = type;
  }

  void setOvertimeRateType(String type) {
    selectedOvertimeRateType.value = type;
  }

  void setCasualLeave(String leave) {
    selectedCasualLeave.value = leave;
    casualLeaveController.text = leave;
  }

  void setSickLeave(String leave) {
    selectedSickLeave.value = leave;
    sickLeaveController.text = leave;
  }

  void setOffDay(String day) {
    selectedOffDay.value = day;
    offDayController.text = day;
  }

  void setBreakTime(String time) {
    selectedBreakTime.value = time;
    breakTimeController.text = time;
  }

  void selectAddress() {}

  void selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF6366F1)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Save the selected date as a DateTime object in UTC
      selectedDateOfBirth.value = DateTime.utc(
        picked.year,
        picked.month,
        picked.day,
      );
    }
  }

  // Education Methods
  void addEducation() {
    // Add an empty education entry
    educations.add({'program': '', 'institution': '', 'year': null});
  }

  void removeEducation(int index) {
    if (index >= 0 && index < educations.length) {
      educations.removeAt(index);
    }
  }

  // ...implemented below

  // Education selectors implementations
  void selectProgram() {
    final programs = [
      'Bachelor of Science',
      'Bachelor of Arts',
      'Master of Science',
      'Master of Arts',
      'PhD',
      'Associate Degree',
      'Diploma',
      'Certificate',
    ];

    Get.bottomSheet(
      SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Program',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              ...programs.map(
                (p) => ListTile(
                  title: Text(p),
                  onTap: () {
                    programController.text = p;
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void selectInstitution() {
    final institutions = [
      'Harvard University',
      'MIT',
      'Stanform University',
      'UC Berkeley',
      'Yale University',
      'Princeton University',
      'Columbia University',
      'Other',
    ];

    Get.bottomSheet(
      SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Institution',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              ...institutions.map(
                (i) => ListTile(
                  title: Text(i),
                  onTap: () {
                    institutionController.text = i;
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void selectYear() {
    final years = List.generate(
      2025 - 1976 + 1,
      (i) => (1976 + i).toString(),
    ).reversed.toList();

    Get.bottomSheet(
      SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(Get.context!).size.height * 0.8,
          ),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              const Text(
                'Select Year',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(Get.context!).size.height * 0.6,
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: years
                      .map(
                        (y) => ListTile(
                          title: Text(y),
                          onTap: () {
                            yearController.text = y;
                            Get.back();
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  // Per-entry selectors (for multi-education)
  void selectProgramFor(int index) {
    final programs = [
      'Bachelor of Science',
      'Bachelor of Arts',
      'Master of Science',
      'Master of Arts',
      'PhD',
      'Associate Degree',
      'Diploma',
      'Certificate',
    ];

    Get.bottomSheet(
      SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Program',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              ...programs.map(
                (p) => ListTile(
                  title: Text(p),
                  onTap: () {
                    if (index >= 0 && index < educations.length) {
                      final current = Map<String, dynamic>.from(
                        educations[index],
                      );
                      current['program'] = p;
                      educations[index] = current;
                    }
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void selectInstitutionFor(int index) {
    final institutions = [
      'Harvard University',
      'MIT',
      'Stanford University',
      'UC Berkeley',
      'Yale University',
      'Princeton University',
      'Columbia University',
      'Other',
    ];

    Get.bottomSheet(
      SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Institution',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              ...institutions.map(
                (i) => ListTile(
                  title: Text(i),
                  onTap: () {
                    if (index >= 0 && index < educations.length) {
                      final current = Map<String, dynamic>.from(
                        educations[index],
                      );
                      current['institution'] = i;
                      educations[index] = current;
                    }
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void selectYearFor(int index) {
    final years = List.generate(
      2025 - 1976 + 1,
      (i) => (1976 + i).toString(),
    ).reversed.toList();

    Get.bottomSheet(
      SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(Get.context!).size.height * 0.8,
          ),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              const Text(
                'Select Year',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(Get.context!).size.height * 0.6,
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: years
                      .map(
                        (y) => ListTile(
                          title: Text(y),
                          onTap: () {
                            if (index >= 0 && index < educations.length) {
                              final current = Map<String, dynamic>.from(
                                educations[index],
                              );
                              current['year'] = int.tryParse(y);
                              educations[index] = current;
                            }
                            Get.back();
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void saveUser() {
    // Validate form first and show specific error message if any
    final validationError = _validateForm();
    if (validationError != null && validationError.isNotEmpty) {
      Get.snackbar(
        'Validation Error',
        validationError,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Build fields map
    // Map UI values to backend expected enums
    final mappedRole = _mapRole(selectedRole.value);
    final mappedGender = _mapGender(selectedGender.value);
    final mappedJobTitle = _mapJobTitle(selectedJobTitle.value);
    final mappedDepartment = _mapDepartment(selectedDepartment.value ?? '');

    final Map<String, String> fields = {
      'phone': phoneController.text.trim(),
      'employeeID': employeeIdController.text.trim(),
      'email': emailController.text.trim(),
      'role': mappedRole ?? '',
      'firstName': firstNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
      'gender': mappedGender ?? '',
      'jobTitle': mappedJobTitle ?? '',
      'department': mappedDepartment ?? '',
      'address': addressController.text.trim(),
      'city': selectedCity.value ?? '',
      'state': selectedState.value ?? '',
      'dob': selectedDateOfBirth.value != null
          ? selectedDateOfBirth.value!.toIso8601String()
          : '',
      'country': '',
      'nationality': '',
      'password': '',
      'pinCode': '',
    };

    _createUser(fields);
  }

  Future<void> _createUser(Map<String, String> fields) async {
    final NetworkCaller caller = NetworkCaller();
    final token = StorageService.token;

    final url = '${ApiConstants.baseurl}${ApiConstants.createUser}';

    final response = await caller.postRequest(url, body: fields, token: token);

    if (response.isSuccess) {
      Get.snackbar(
        'Success',
        response.responseData['message'] ?? 'User created',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // Extract created user id (try common keys) and navigate to education screen
      try {
        final data = response.responseData['data'];
        String? userId;
        if (data != null) {
          if (data is String) {
            userId = data;
          } else if (data is Map) {
            if (data.containsKey('id')) userId = data['id']?.toString();
            if (userId == null && data.containsKey('_id')) {
              userId = data['_id']?.toString();
            }
            if (userId == null && data.containsKey('userId')) {
              userId = data['userId']?.toString();
            }
          }
        }
        createdUserId = userId;
        Get.to(AddUserEducationScreen(), arguments: {'userId': userId});
      } catch (e) {
        // fallback: navigate without userId
        Get.to(AddUserEducationScreen());
      }
    } else {
      final errMsg = response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to create user';
      Get.snackbar(
        'Error',
        errMsg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Save education entries for the created user
  Future<void> saveEducation() async {
    final token = StorageService.token;
    final userIdFromArg = Get.arguments != null && Get.arguments is Map
        ? (Get.arguments as Map)['userId']?.toString()
        : null;
    final userId = createdUserId ?? userIdFromArg;

    if (userId == null || userId.isEmpty) {
      Get.snackbar(
        'Error',
        'User id not found. Cannot save education.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (educations.isEmpty) {
      Get.snackbar(
        'Validation',
        'Please add at least one education entry.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final body = {
      'educations': educations
          .map(
            (e) => {
              'program': e['program'] ?? '',
              'institution': e['institution'] ?? '',
              'year': e['year'],
            },
          )
          .toList(),
    };

    final url =
        '${ApiConstants.baseurl}${ApiConstants.createUserEducation}/$userId';
    final caller = NetworkCaller();
    final response = await caller.postRequest(url, body: body, token: token);

    if (response.isSuccess) {
      Get.snackbar(
        'Success',
        response.responseData['message'] ?? 'Educations saved',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // Navigate to experience screen
      Get.to(AddUserExperienceScreen(), arguments: {'userId': userId});
    } else {
      Get.snackbar(
        'Error',
        response.errorMessage.isNotEmpty
            ? response.errorMessage
            : 'Failed to save educations',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void cancelEducation() {
    Get.dialog(
      AlertDialog(
        title: const Text('Cancel Education'),
        content: const Text(
          'Are you sure you want to cancel? All entered data will be lost.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('No')),
          TextButton(
            onPressed: () {
              Get.back();
              _clearEducationForm();
              Get.back();
            },
            child: const Text('Yes', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _clearEducationForm() {
    programController.clear();
    institutionController.clear();
    yearController.clear();
  }

  void cancelAddUser() {
    Get.dialog(
      AlertDialog(
        title: const Text('Cancel Adding User'),
        content: const Text(
          'Are you sure you want to cancel? All entered data will be lost.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('No')),
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              _clearForm();
              Get.back(); // Go back to previous screen
            },
            child: const Text('Yes', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void saveExperience() {
    // Post experiences to backend and navigate to payroll on success
    _postExperiences();
  }

  Future<void> _postExperiences() async {
    final token = StorageService.token;
    final userIdFromArg = Get.arguments != null && Get.arguments is Map
        ? (Get.arguments as Map)['userId']?.toString()
        : null;
    final userId = createdUserId ?? userIdFromArg;

    if (userId == null || userId.isEmpty) {
      Get.snackbar(
        'Error',
        'User id not found. Cannot save experiences.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (experiences.isEmpty) {
      Get.snackbar(
        'Validation',
        'Please add at least one experience entry.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Build body
    final List<Map<String, dynamic>> bodyExps = [];
    for (final e in experiences) {
      final designation = (e['position'] ?? '').toString();
      final companyName = (e['company'] ?? '').toString();
      final uiJobType = (e['jobType'] ?? '').toString();
      final jobType = _mapJobType(uiJobType);
      final startIso = _toIso(e['startDate']?.toString());
      final endIso = _toIso(e['endDate']?.toString());
      final description = (e['description'] ?? '').toString();
      final isCurrentlyWorking = e['isCurrentlyWorking'] == true;

      bodyExps.add({
        'designation': designation,
        'companyName': companyName,
        'jobType': jobType,
        'startDate': startIso,
        'endDate': isCurrentlyWorking ? null : endIso,
        'description': description,
        'isCurrentlyWorking': isCurrentlyWorking,
      });
    }

    final body = {'experiences': bodyExps};

    final url =
        '${ApiConstants.baseurl}${ApiConstants.createUserExperience}/$userId';
    final caller = NetworkCaller();
    final response = await caller.postRequest(url, body: body, token: token);

    if (response.isSuccess) {
      Get.snackbar(
        'Success',
        response.responseData['message'] ?? 'Experiences saved',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // proceed to payroll
      currentStep.value = 4;
      Get.to(AddUserPayrollScreen(), arguments: {'userId': userId});
    } else {
      Get.snackbar(
        'Error',
        response.errorMessage.isNotEmpty
            ? response.errorMessage
            : 'Failed to save experiences',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  String? _mapJobType(String? ui) {
    if (ui == null) return null;
    final v = ui.toLowerCase();
    if (v.contains('full')) return 'FULL_TIME';
    if (v.contains('part')) return 'PART_TIME';
    if (v.contains('contract')) return 'CONTRACT';
    if (v.contains('intern')) return 'INTERNSHIP';
    if (v.contains('freel')) return 'FREELANCE';
    return ui.toUpperCase().replaceAll(' ', '_');
  }

  String? _toIso(String? dateStr) {
    if (dateStr == null) return null;
    final s = dateStr.trim();
    if (s.isEmpty) return null;
    // expected format stored like 'd/m/yyyy' or already ISO
    if (s.contains('T') && s.contains('-')) return s; // already ISO
    final parts = s.split('/');
    if (parts.length == 3) {
      final d = int.tryParse(parts[0]);
      final m = int.tryParse(parts[1]);
      final y = int.tryParse(parts[2]);
      if (d != null && m != null && y != null) {
        try {
          return DateTime.utc(y, m, d).toIso8601String();
        } catch (_) {
          return null;
        }
      }
    }
    // fallback null
    return null;
  }

  void savePayroll() async {
    await _postPayrollSettings();
    //refreshEmployeeAdmin();
    adminListController.fetchAdmins;
    userListController.fetchEmployeeProfiles;
    debugPrint("info, employee and admin refresh");
    Get.snackbar("info", "employee and admin refresh");
  }

  Future<void> _postPayrollSettings() async {
    final token = StorageService.token;
    final userIdFromArg = Get.arguments != null && Get.arguments is Map
        ? (Get.arguments as Map)['userId']?.toString()
        : null;
    final userId = createdUserId ?? userIdFromArg;

    if (userId == null || userId.isEmpty) {
      Get.snackbar(
        'Error',
        'User id not found. Cannot save payroll settings.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Build pay rate body
    final regularPayRate =
        int.tryParse(regularPayRateController.text.trim()) ?? 0;
    final overtimePayRate =
        int.tryParse(overtimePayRateController.text.trim()) ?? 0;
    int casualLeave = 0;
    final casualFromField = int.tryParse(casualLeaveController.text.trim());
    if (casualFromField != null) {
      casualLeave = casualFromField;
    } else if (selectedCasualLeave.value != null &&
        selectedCasualLeave.value!.isNotEmpty) {
      casualLeave =
          int.tryParse(selectedCasualLeave.value!.split(' ').first) ?? 0;
    }

    int sickLeave = 0;
    final sickFromField = int.tryParse(sickLeaveController.text.trim());
    if (sickFromField != null) {
      sickLeave = sickFromField;
    } else if (selectedSickLeave.value != null &&
        selectedSickLeave.value!.isNotEmpty) {
      sickLeave = int.tryParse(selectedSickLeave.value!.split(' ').first) ?? 0;
    }

    final payRateBody = {
      'regularPayRate': regularPayRate,
      'regularPayRateType': _mapPayRateType(selectedPayRateType.value),
      'overTimePayRate': overtimePayRate,
      'overTimePayRateType': _mapPayRateType(selectedOvertimeRateType.value),
      'casualLeave': casualLeave,
      'sickLeave': sickLeave,
    };

    final payUrl =
        '${ApiConstants.baseurl}${ApiConstants.payrollPayrate}/$userId';
    final caller = NetworkCaller();
    final payResp = await caller.patchRequest(
      payUrl,
      body: payRateBody,
      token: token,
    );

    if (!payResp.isSuccess) {
      Get.snackbar(
        'Error',
        payResp.errorMessage.isNotEmpty
            ? payResp.errorMessage
            : 'Failed to save pay rate',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Build offday & break body
    int numberOffDay = int.tryParse(offDayController.text.trim()) ?? -1;
    final offDay = <String>[];
    if (selectedOffDay.value != null) {
      // If user selected multiple off days format not supported by single selection UI,
      // try to map single value
      offDay.add(_mapOffDay(selectedOffDay.value));
    }

    // Ensure numberOffDay meets backend minimum requirement (>=1).
    // Prefer explicit user input; otherwise derive from selected off days count; default to 1.
    if (numberOffDay < 1) {
      numberOffDay = offDay.isNotEmpty ? offDay.length : 1;
    }

    final breakBody = {
      'numberOffDay': numberOffDay,
      'offDay': offDay,
      'breakTimePerDay': _mapBreakTime(selectedBreakTime.value),
    };

    final breakUrl =
        '${ApiConstants.baseurl}${ApiConstants.payrollOffday}/$userId';
    final breakResp = await caller.patchRequest(
      breakUrl,
      body: breakBody,
      token: token,
    );

    if (!breakResp.isSuccess) {
      Get.snackbar(
        'Error',
        breakResp.errorMessage.isNotEmpty
            ? breakResp.errorMessage
            : 'Failed to save offday/break settings',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    Get.snackbar(
      'Success',
      payResp.responseData['message'] ?? 'Payroll settings saved',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Finished — navigate to view user screen
    //Get.to(AdminDashboardScreen());
    Get.to(ViewUserScreen());
  }

  String _mapPayRateType(String? ui) {
    if (ui == null) return 'HOUR';
    final v = ui.toLowerCase();
    if (v.contains('hour')) return 'HOUR';
    if (v.contains('day')) return 'DAY';
    if (v.contains('week')) return 'WEEK';
    if (v.contains('month')) return 'MONTH';
    return ui.toUpperCase();
  }

  String _mapOffDay(String? ui) {
    if (ui == null) return 'SUNDAY';
    // Map single selection to backend enum (uppercase)
    return ui.toUpperCase();
  }

  String _mapBreakTime(String? ui) {
    if (ui == null) return 'NONE';
    final v = ui.toLowerCase();
    if (v.contains('30')) return 'HALF_HOUR';
    if (v.contains('1 hour') || v.contains('1')) return 'ONE_HOUR';
    if (v.contains('3')) return 'THREE_HOUR';
    return ui.toUpperCase();
  }

  void setCurrentlyWorking(bool value) {
    isCurrentlyWorking.value = value;
    if (value) {
      endDateController.clear();
    }
  }

  /// Validates the form and returns an error message string when invalid,
  /// or null when the form is valid.
  String? _validateForm() {
    if (selectedRole.value == null || selectedRole.value!.isEmpty) {
      return 'Please select a role';
    }

    if (firstNameController.text.trim().isEmpty) {
      return 'First name is required';
    }

    if (lastNameController.text.trim().isEmpty) {
      return 'Last name is required';
    }

    final email = emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      return 'Valid email is required';
    }

    if (phoneController.text.trim().isEmpty) {
      return 'Phone number is required';
    }

    if (employeeIdController.text.trim().isEmpty) {
      return 'Employee ID is required';
    }

    return null;
  }

  void _clearForm() {
    selectedRole.value = null;
    firstNameController.clear();
    lastNameController.clear();
    phoneController.clear();
    emailController.clear();
    employeeIdController.clear();
    addressController.clear();
    _clearEducationForm();
    _clearExperienceForm();
    _clearPayrollForm();
  }

  void _clearExperienceForm() {
    positionController.clear();
    companyNameController.clear();
    jobTypeController.clear();
    startDateController.clear();
    endDateController.clear();
    descriptionController.clear();
    isCurrentlyWorking.value = false;
  }

  void _clearPayrollForm() {
    regularPayRateController.clear();
    overtimePayRateController.clear();
    casualLeaveController.clear();
    sickLeaveController.clear();
    offDayController.clear();
    breakTimeController.clear();
    selectedPayRateType.value = null;
    selectedOvertimeRateType.value = null;
    selectedCasualLeave.value = null;
    selectedSickLeave.value = null;
    selectedOffDay.value = null;
    selectedBreakTime.value = null;
  }

  // --- Mapping helpers to convert UI labels to backend enum values ---
  String? _mapRole(String? uiRole) {
    if (uiRole == null) return null;
    switch (uiRole.toLowerCase()) {
      case 'admin':
        return 'ADMIN';
      case 'employee':
        return 'EMPLOYEE';
      case 'super admin':
      case 'super_admin':
      case 'superadmin':
        return 'SUPER_ADMIN';
      case 'user':
        return 'USER';
      case 'manager':
        return 'MANAGER';
      default:
        return uiRole.toUpperCase();
    }
  }

  String? _mapGender(String? uiGender) {
    if (uiGender == null) return null;
    switch (uiGender.toLowerCase()) {
      case 'male':
        return 'MALE';
      case 'female':
        return 'FEMALE';
      case 'other':
        return 'OTHER';
      case 'prefer not to say':
      case 'prefer_not_to_say':
        return 'PREFER_NOT_TO_SAY';
      default:
        return uiGender.toUpperCase();
    }
  }

  String? _mapJobTitle(String? uiJob) {
    if (uiJob == null) return null;
    // Explicit mappings for UI labels used in the form
    switch (uiJob.toLowerCase()) {
      case 'software engineer':
        return 'FULL_STACK_DEVELOPER';
      case 'product manager':
        return 'MARKETING_MANAGER';
      case 'designer':
        return 'UI_DEVELOPER';
      case 'qa engineer':
      case 'qa':
      case 'quality assurance':
        return 'SEALS_ENGINEER';
    }

    final v = uiJob.toLowerCase();
    if (v.contains('back') || v.contains('back end')) {
      return 'BACK_END_DEVELOPER';
    }
    if (v.contains('front') || v.contains('front end')) {
      return 'FRONT_END_DEVELOPER';
    }
    if (v.contains('full')) return 'FULL_STACK_DEVELOPER';
    if (v.contains('mobile')) return 'MOBILE_DEVELOPER';
    if (v.contains('ui')) return 'UI_DEVELOPER';
    if (v.contains('ux')) return 'UX_DEVELOPER';
    if (v.contains('seals') || v.contains('sales')) return 'SEALS_ENGINEER';
    if (v.contains('data scientist')) return 'DATA_SCIENTIST';
    if (v.contains('data analyst')) return 'DATA_ANALYST';
    if (v.contains('data engineer')) return 'DATA_ENGINEER';
    if (v.contains('hr')) return 'HR_MANAGER';
    if (v.contains('finance')) return 'FINANCE_MANAGER';
    if (v.contains('marketing')) return 'MARKETING_MANAGER';

    // Fallback: convert to uppercase and replace spaces with underscores
    return uiJob.toUpperCase().replaceAll(' ', '_');
  }

  String? _mapDepartment(String? uiDept) {
    if (uiDept == null) return null;
    switch (uiDept.toLowerCase()) {
      case 'it':
      case 'information technology':
        return 'IT';
      case 'development':
      case 'dev':
      case 'engineering':
        return 'DEVELOPMENT';
      case 'hr':
      case 'human resources':
        return 'HR';
      case 'finance':
        return 'FINANCE';
      case 'marketing':
        return 'MARKETING';
      case 'seals':
      case 'sales':
        return 'SEALS';
      default:
        return uiDept.toUpperCase().replaceAll(' ', '_');
    }
  }

  // Experience Methods
  void editExperience() {}

  void addExperience() {
    experiences.add({
      'position': '',
      'company': '',
      'jobType': '',
      'startDate': '',
      'endDate': '',
      'description': '',
      'isCurrentlyWorking': false,
    });
  }

  void removeExperienceAt(int index) {
    if (index >= 0 && index < experiences.length) experiences.removeAt(index);
  }

  void updateExperienceField(int index, String key, dynamic value) {
    if (index < 0 || index >= experiences.length) return;
    final current = Map<String, dynamic>.from(experiences[index]);
    current[key] = value;
    experiences[index] = current;
  }

  void selectJobTypeFor(int index) {
    Get.bottomSheet(
      SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Job Type',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              ...jobTypes.map(
                (type) => ListTile(
                  title: Text(type),
                  onTap: () {
                    updateExperienceField(index, 'jobType', type);
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void selectStartDateFor(int index) async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF6366F1)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formatted = '${picked.day}/${picked.month}/${picked.year}';
      updateExperienceField(index, 'startDate', formatted);
    }
  }

  void selectEndDateFor(int index) async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF6366F1)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formatted = '${picked.day}/${picked.month}/${picked.year}';
      updateExperienceField(index, 'endDate', formatted);
    }
  }

  void toggleCurrentlyWorkingFor(int index, bool value) {
    updateExperienceField(index, 'isCurrentlyWorking', value);
    if (value) updateExperienceField(index, 'endDate', '');
  }

  void selectJobType() {
    Get.bottomSheet(
      SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Job Type',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              ...jobTypes
                  .map(
                    (type) => ListTile(
                      title: Text(type),
                      onTap: () {
                        jobTypeController.text = type;
                        Get.back();
                      },
                    ),
                  )
                  ,
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF6366F1)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      startDateController.text = '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  void selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF6366F1)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      endDateController.text = '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  // Payroll Methods
  void editPayroll() {
    Get.snackbar(
      'Edit Payroll',
      'Opening payroll editor...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF6366F1),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void selectPayRateTypeBottomSheet() {
    Get.bottomSheet(
      SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pay rate',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              ...payRateTypes
                  .map(
                    (type) => ListTile(
                      title: Text(type),
                      onTap: () {
                        setPayRateType(type);
                        Get.back();
                      },
                    ),
                  )
                  ,
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void selectOvertimeRateTypeBottomSheet() {
    Get.bottomSheet(
      SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Overtime rate',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              ...payRateTypes
                  .map(
                    (type) => ListTile(
                      title: Text(type),
                      onTap: () {
                        setOvertimeRateType(type);
                        Get.back();
                      },
                    ),
                  )
                  ,
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void selectCasualLeaveBottomSheet() {
    Get.bottomSheet(
      SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Casual Leave',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              ...leaveOptions
                  .map(
                    (leave) => ListTile(
                      title: Text(leave),
                      onTap: () {
                        setCasualLeave(leave);
                        Get.back();
                      },
                    ),
                  )
                  ,
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void selectSickLeaveBottomSheet() {
    Get.bottomSheet(
      SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sick Leave',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              ...leaveOptions
                  .map(
                    (leave) => ListTile(
                      title: Text(leave),
                      onTap: () {
                        setSickLeave(leave);
                        Get.back();
                      },
                    ),
                  )
                  ,
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void selectOffDayBottomSheet() {
    Get.bottomSheet(
      SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select day here',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              ...offDayOptions
                  .map(
                    (day) => ListTile(
                      title: Text(day),
                      onTap: () {
                        setOffDay(day);
                        Get.back();
                      },
                    ),
                  )
                  ,
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void selectBreakTimeBottomSheet() {
    Get.bottomSheet(
      SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Time Here',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              ...breakTimeOptions
                  .map(
                    (time) => ListTile(
                      title: Text(time),
                      onTap: () {
                        setBreakTime(time);
                        Get.back();
                      },
                    ),
                  )
                  ,
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  void onClose() {
    // Personal Information controllers
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    employeeIdController.dispose();
    addressController.dispose();

    // Education controllers
    programController.dispose();
    institutionController.dispose();
    yearController.dispose();

    // Experience controllers
    positionController.dispose();
    companyNameController.dispose();
    jobTypeController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    descriptionController.dispose();

    // Payroll controllers
    regularPayRateController.dispose();
    overtimePayRateController.dispose();
    casualLeaveController.dispose();
    sickLeaveController.dispose();
    offDayController.dispose();
    breakTimeController.dispose();
    super.onClose();
  }
}
