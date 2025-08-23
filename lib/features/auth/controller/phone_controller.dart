import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:country_code_picker/country_code_picker.dart';
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';

class PhoneController extends GetxController {
  // UI State
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var isValidPhone = true.obs;

  // Phone number controller
  final phoneController = TextEditingController();

  // Country code management
  var selectedCountryCode = CountryCode.fromCountryCode('US').obs;

  // API endpoint
  static const _phoneLoginUrl = '$baseurl/auth/login/phone';

  @override
  void onInit() {
    super.onInit();
    // Add a listener to validate the phone number in real-time
    phoneController.addListener(validatePhoneNumber);
  }

  @override
  void onClose() {
    phoneController.removeListener(validatePhoneNumber);
    phoneController.dispose();
    super.onClose();
  }

  // Show snackbar message
  void _showSnackbar(String title, String message, {bool isError = true}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Validate phone number
  bool _isValidPhone(String phone) {
    String cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');
    return cleanPhone.length >= 7 && cleanPhone.length <= 15;
  }

  // Update country code
  void updateCountryCode(CountryCode countryCode) {
    selectedCountryCode.value = countryCode;
  }

  // Get full phone number with country code
  String get fullPhoneNumber {
    String countryCode = selectedCountryCode.value.dialCode ?? '+1';
    String phone = phoneController.text.trim().replaceFirst(RegExp(r'^0+'), '');
    return '$countryCode$phone';
  }

  // Phone login function
  Future<void> loginWithPhone() async {
    final phone = phoneController.text.trim();

    if (phone.isEmpty) {
      _showSnackbar('❌ Error', 'Please enter your phone number.');
      return;
    }

    if (!_isValidPhone(phone)) {
      _showSnackbar('❌ Error', 'Please enter a valid phone number.');
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(_phoneLoginUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"phoneNumber": fullPhoneNumber}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoggedIn.value = true;
        _showSnackbar(
          '✅ Success',
          'OTP sent to your phone! 📱',
          isError: false,
        );

        // Get.toNamed('/phone-otp-verification', arguments: fullPhoneNumber);
      } else {
        final responseBody = json.decode(response.body);
        final errorMessage =
            responseBody['message'] ?? 'Login failed. Please try again.';
        _showSnackbar('❌ Error', errorMessage);
      }
    } catch (e) {
      _showSnackbar('❌ Error', 'Network error. Please check your connection.');
    } finally {
      isLoading.value = false;
    }
  }

  // Validate phone number in real-time
  void validatePhoneNumber() {
    final phone = phoneController.text.trim();
    isValidPhone.value = _isValidPhone(phone);
  }

  // Clear phone number
  void clearPhone() {
    phoneController.clear();
  }
}
