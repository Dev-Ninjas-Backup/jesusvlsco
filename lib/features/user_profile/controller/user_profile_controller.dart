import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/splasho_screen/controller/splasho_controller.dart';
import 'package:jesusvlsco/features/user_profile/models/user_model.dart';
import 'package:jesusvlsco/features/user_profile/repository/user_repository.dart';

class UserProfileController extends GetxController {
  final splashController = Get.find<SplashController>();
  final isEditing = false.obs; // default: read-only

  void toggleEdit() => isEditing.value = !isEditing.value;

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

  void _setControllers(UserData data) {
    firstNameController.text = data.profile.firstName;
    lastNameController.text = data.profile.lastName;
    phoneController.text = data.phone;
    emailController.text = data.email;
    employeeIdController.text = data.employeeID
        .toString(); // convert int to String
    addressController.text = data.profile.address;

    selectedDateOfBirth.value = data.profile.dob;
    selectedGender.value = data.profile.gender;
    selectedJobTitle.value = data.profile.jobTitle;
    selectedCity.value = data.profile.city;
    selectedState.value = data.profile.state;
    profileImageUrl.value = data.profile.profileUrl;
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    employeeIdController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
