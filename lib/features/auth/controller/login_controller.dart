import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';
import 'package:jesusvlsco/features/auth/screen/email_otpverfication.dart';

class LoginController extends GetxController {
  // 📱 Reactive variables
  var isLoading = false.obs;
  var isemail_loading = false.obs;
  var isLoggedIn = false.obs;
  

  // 📝 Form controller
  final emailController = TextEditingController();

  // 🌐 API endpoint
  static const _apiUrl =
      '$baseurl/auth/login/email';

  static const loginendpoint = '/auth/login';

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  // ✅ Email validation
  bool _isValidEmail(String email) =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

  // 🚨 Show error message
  void _showError(String message) => Get.snackbar(
    '❌ Error',
    message,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
  );

  // ✨ Show success message
  void _showSuccess(String message) => Get.snackbar(
    '✅ Success',
    message,
    backgroundColor: Colors.green,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
  );

  // 🔑 Main login function
  Future<void> login_email() async {
    final email = emailController.text.trim();

    // 📋 Validate input
    if (email.isEmpty) return _showError('Please enter your email');
    if (!_isValidEmail(email)) return _showError('Invalid email format');

    isemail_loading.value = true;

    try {
      // 🌐 Make API call
      final request = http.Request('POST', Uri.parse(_apiUrl));
      request.headers['Content-Type'] = 'application/json';
      request.body = json.encode({"email": email});

      final response = await request.send();

      if (response.statusCode == 201 || response.statusCode == 200) {
        // 🎉 Success
        final responseBody = await response.stream.bytesToString();
        isLoggedIn.value = true;

        _showSuccess('Login successful');
        print('📱 Response: $responseBody');

        // 🏠 Navigate to home (uncomment when ready)
        Get.to(EmailOtpverfication());
      } else {
        // 💥 API error
        _showError('Login failed: ${response.reasonPhrase ?? 'Unknown error'}');
      }
    } catch (e) {
      // 🌐 Network error
      _showError('Network error. Please try again.');
      print('🚨 Error: $e');
    } finally {
      isemail_loading.value = false;
    }
  }



  // 🚪 Logout
  void logout() {
    isLoggedIn.value = false;
    emailController.clear();
    _showSuccess('Logged out successfully! 👋');

    // 🔄 Navigate to login (uncomment when ready)
    // Get.offAllNamed('/login');
  }

  void login() {
    isLoading = true.obs;
    update();
  }
}
