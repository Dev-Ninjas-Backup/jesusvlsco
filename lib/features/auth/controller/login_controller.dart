import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';
import 'package:jesusvlsco/features/auth/screen/email_otpverfication.dart';
import 'package:jesusvlsco/model/user_loginresponse.dart';

class LoginController extends GetxController {
  // 📱 Reactive variables
  var isLoading = false.obs;
  var isEmailLoading = false.obs;
  var isLoggedIn = false.obs;

  // 📝 Form controller
  final emailController = TextEditingController();

  // 🌐 API endpoint
  static const _apiUrl = '${ApiConstants.baseurl}/auth/login/email';

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
Future<void> loginEmail() async {
  final email = emailController.text.trim();

  if (email.isEmpty) return _showError('Please enter your email');
  if (!_isValidEmail(email)) return _showError('Invalid email format');

  isEmailLoading.value = true;

  try {
    final request = http.Request('POST', Uri.parse(_apiUrl));
    request.headers['Content-Type'] = 'application/json';
    request.body = json.encode({"email": email});

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decoded = json.decode(responseBody);

      if (decoded != null && decoded is Map<String, dynamic>) {
        // Check if `data` exists
        if (decoded['data'] != null && decoded['data'] is Map<String, dynamic>) {
          final loginResponse = LoginResponse.fromJson(decoded);

          if (loginResponse.success && loginResponse.data!.user.isVerified) {
            isLoggedIn.value = true;
            if (kDebugMode) {
              print('👤 User Email: ${loginResponse.data!.user.email}');
            }
            if (kDebugMode) {
              print('🔑 Token: ${loginResponse.data!.token}');
            }
            if (kDebugMode) {
              print('📝 Role: ${loginResponse.data!.user.role}');
            }

            _showSuccess('Login successful');
          } else {
            _showSuccess('OTP sent to your email');
          }
        } else {
          // data is null → probably just OTP sent
          _showSuccess('OTP sent to your email');
        }

        // Navigate to OTP verification in both cases
        Get.to(() => EmailOtpverfication());
      } else {
        _showError('Invalid response format from server');
      }
    } else {
      _showError('Login failed: ${response.reasonPhrase ?? 'Unknown error'}');
    }
  } catch (e) {
    _showError('Network error. Please try again.');
    if (kDebugMode) {
      print('🚨 Error: $e');
    }
  } finally {
    isEmailLoading.value = false;
  }
}



  // 🚪 Logout
  void logout() {
    isLoggedIn.value = false;
    emailController.clear();
    _showSuccess('Logged out successfully! 👋');

    // 🔄 Navigate to login screen if needed
    // Get.offAllNamed('/login');
  }

  void login() {
    isLoading.value = true;
    update();
  }
}
