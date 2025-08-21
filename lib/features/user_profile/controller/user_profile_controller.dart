import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  // Text Editing Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final employeeIdController = TextEditingController();
  final addressController = TextEditingController();

  // Observable variables for dropdowns and date picker
  final selectedDateOfBirth = Rx<DateTime?>(null);
  final selectedGender = Rx<String?>(null);
  final selectedJobTitle = Rx<String?>(null);
  final selectedCity = Rx<String?>(null);
  final selectedState = Rx<String?>(null);

  // Options for dropdowns
  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> jobTitleOptions = [
    'Software Engineer',
    'Product Manager',
    'UI/UX Designer',
    'QA Engineer',
  ];
  final List<String> cityOptions = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
  ];
  final List<String> stateOptions = [
    'California',
    'Texas',
    'Florida',
    'New York',
    'Washinton',
  ];

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    employeeIdController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
