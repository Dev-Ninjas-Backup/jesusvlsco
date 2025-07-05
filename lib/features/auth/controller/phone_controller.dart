import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Numbercontroller extends GetxController {
  // Controller to handle the phone number text input
  final TextEditingController _phoneController = TextEditingController();

  // Getter to access the phone controller outside of this class
  TextEditingController get phoneController => _phoneController;

  // Optional: Reactive state for validation or other uses (for example, valid phone number)
  var isValidPhone = true.obs;  // Reactive state to track phone number validity

  @override
  void dispose() {
    _phoneController.dispose();  // Properly dispose the controller when not in use
    super.dispose();
  }

  // Optional: A method to validate the phone number (just an example)
  void validatePhoneNumber() {
    // Simple phone number validation (this can be expanded as needed)
    if (_phoneController.text.length == 10) {
      isValidPhone.value = true;
        // Get.toNamed(AppRoute.getphoneotpverifymethod());
        // Get.snackbar("Success", "Phone number is valid");
    } else {
      isValidPhone.value = false;
       Get.snackbar("Failed", "Phone number isnot valid");
    }
  }
}
