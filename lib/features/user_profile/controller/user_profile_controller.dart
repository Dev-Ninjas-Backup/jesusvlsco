import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/splasho_screen/controller/splasho_controller.dart';
import 'package:jesusvlsco/features/user_profile/models/user_model.dart';
import 'package:jesusvlsco/features/user_profile/repository/user_repository.dart';

class UserProfileController extends GetxController {
  final splashController = Get.find<SplashController>();
  final isEditing = false.obs; // default: read-only
  final isLoading = false.obs;

  void toggleEdit() => isEditing.value = !isEditing.value;

  // Text Editing Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final employeeIdController = TextEditingController();
  final addressController = TextEditingController();
  final departmentController = TextEditingController();
  final nationalityController = TextEditingController();

  // Observable variables for dropdowns and date picker
  final selectedDateOfBirth = Rx<DateTime?>(null);
  final selectedGender = Rx<String?>(null);
  final selectedJobTitle = Rx<String?>(null);
  final selectedCity = Rx<String?>(null);
  final selectedState = Rx<String?>(null);
  final selectedCountry = Rx<String?>(null);
  final profileImageUrl = Rx<String?>(null);

  // Repository instance
  late UserProfileRepository repository;

  @override
  void onInit() {
    super.onInit();
    _initRepositoryAndFetch();
  }

  Future<void> _initRepositoryAndFetch() async {
    final token = await splashController.getAuthToken();
    final userId = await splashController.getId();

    if (token != null && userId != null) {
      debugPrint('Token retrieved in controller: $token');
      repository = UserProfileRepository(token: token);

      UserProfileModel? profile = await repository.fetchUserProfile(userId);

      if (profile != null) {
        _setControllers(profile.data); // pass UserData, not Profile
        debugPrint('✅ Profile fetched successfully');
      } else {
        print('🚨 Failed to fetch profile');
      }
    } else {
      print('🚨 Token or User ID is null');
    }
  }

  void _setControllers(UserData? data) {
    if (data?.profile == null) {
      debugPrint('🚨 Profile data is null');
      return;
    }

    final profile = data!.profile!;

    firstNameController.text = profile.firstName ?? '';
    lastNameController.text = profile.lastName ?? '';
    phoneController.text = data.phone ?? '';
    emailController.text = data.email ?? '';
    employeeIdController.text = data.employeeID?.toString() ?? '';
    addressController.text = profile.address ?? '';
    departmentController.text = profile.department ?? '';
    nationalityController.text = profile.nationality ?? '';

    selectedDateOfBirth.value = profile.dob;
    selectedGender.value = profile.gender;
    selectedJobTitle.value = profile.jobTitle;
    selectedCity.value = profile.city;
    selectedState.value = profile.state;
    selectedCountry.value = profile.country;
    profileImageUrl.value = profile.profileUrl;
  }

  Future<void> updateProfile() async {
    isLoading.value = true;

    final updatedProfile = await repository.updateProfile(
      firstName: firstNameController.text.isNotEmpty
          ? firstNameController.text
          : null,
      lastName: lastNameController.text.isNotEmpty
          ? lastNameController.text
          : null,
      gender: selectedGender.value,
      jobTitle: selectedJobTitle.value,
      department: departmentController.text.isNotEmpty
          ? departmentController.text
          : null,
      address: addressController.text.isNotEmpty
          ? addressController.text
          : null,
      city: selectedCity.value,
      state: selectedState.value,
      country: selectedCountry.value,
      nationality: nationalityController.text.isNotEmpty
          ? nationalityController.text
          : null,
      // not allowing phone, email, dob to be changed
      profileUrl: profileImageUrl.value,
    );

    if (updatedProfile != null) {
      _setControllers(updatedProfile.data);
      isEditing.value = false;
      Get.snackbar('Success', 'Profile updated successfully');
    } else {
      Get.snackbar('Error', 'Failed to update profile');
    }
    isLoading.value = false;
  }

  // Helper methods to get display values with fallbacks
  String get displayName =>
      '${firstNameController.text} ${lastNameController.text}'.trim().isNotEmpty
      ? '${firstNameController.text} ${lastNameController.text}'.trim()
      : 'No Name';

  String get displayJobTitle => selectedJobTitle.value ?? 'No Job Title';

  String get displayEmail =>
      emailController.text.isNotEmpty ? emailController.text : 'No Email';

  String get displayPhone =>
      phoneController.text.isNotEmpty ? phoneController.text : 'No Phone';

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    employeeIdController.dispose();
    addressController.dispose();
    departmentController.dispose();
    nationalityController.dispose();
    super.onClose();
  }
}
