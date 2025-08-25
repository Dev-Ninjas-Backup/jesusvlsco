import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/services/network_caller.dart';
import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';
import 'package:jesusvlsco/features/user/screen/add_user_education_screen.dart';
import 'package:jesusvlsco/features/user/screen/add_user_experience_screen.dart';

import '../screen/add_user_payroll_screen.dart';
import '../screen/view_user_screen.dart';

class AddUserController extends GetxController {
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

    if (picked != null) {}
  }

  // Education Methods
  void addEducation() {}

  void selectProgram() {}

  void selectInstitution() {}

  void selectYear() {
    Get.snackbar(
      'Year',
      'Opening year selector...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF6366F1),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void saveUser() {
    // Validate form first
    if (!_validateForm()) return;

    // Build fields map
    final Map<String, String> fields = {
      'phone': phoneController.text.trim(),
      'employeeID': employeeIdController.text.trim(),
      'email': emailController.text.trim(),
      'role': selectedRole.value ?? '',
      'firstName': firstNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
      'gender': selectedGender.value ?? '',
      'jobTitle': selectedJobTitle.value ?? '',
      'department': '',
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

  final url = '${ApiConstants.baseurl}/admin/user';

  final response = await caller.postRequest(url, body: fields, token: token);

    if (response.isSuccess) {
      Get.snackbar('Success', response.responseData['message'] ?? 'User created',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      // Navigate to next step
      Get.to(AddUserEducationScreen());
    } else {
      final errMsg = response.errorMessage.isNotEmpty ? response.errorMessage : 'Failed to create user';
      Get.snackbar('Error', errMsg,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void saveEducation() {
    Get.to(AddUserExperienceScreen());
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
    currentStep.value = 4; // Move to Payroll step
    Get.to(AddUserPayrollScreen());
  }

  void savePayroll() {
    Get.to(ViewUserScreen());
  }

  void setCurrentlyWorking(bool value) {
    isCurrentlyWorking.value = value;
    if (value) {
      endDateController.clear();
    }
  }

  bool _validateForm() {
    if (selectedRole.value == null) {
      Get.snackbar(
        'Validation Error',
        'Please select a role',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (firstNameController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'First name is required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (lastNameController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Last name is required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (emailController.text.trim().isEmpty ||
        !emailController.text.contains('@')) {
      Get.snackbar(
        'Validation Error',
        'Valid email is required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (phoneController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Phone number is required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (employeeIdController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Employee ID is required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  void _clearForm() {
    selectedRole.value = '';
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

  // Experience Methods
  void editExperience() {}

  void addExperience() {}

  void selectJobType() {
    Get.bottomSheet(
      Container(
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
                .toList(),
          ],
        ),
      ),
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
      Container(
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
                .toList(),
          ],
        ),
      ),
    );
  }

  void selectOvertimeRateTypeBottomSheet() {
    Get.bottomSheet(
      Container(
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
                .toList(),
          ],
        ),
      ),
    );
  }

  void selectCasualLeaveBottomSheet() {
    Get.bottomSheet(
      Container(
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
                .toList(),
          ],
        ),
      ),
    );
  }

  void selectSickLeaveBottomSheet() {
    Get.bottomSheet(
      Container(
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
                .toList(),
          ],
        ),
      ),
    );
  }

  void selectOffDayBottomSheet() {
    Get.bottomSheet(
      Container(
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
                .toList(),
          ],
        ),
      ),
    );
  }

  void selectBreakTimeBottomSheet() {
    Get.bottomSheet(
      Container(
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
                .toList(),
          ],
        ),
      ),
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
