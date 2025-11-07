// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';
import 'package:jesusvlsco/features/auth/controller/login_controller.dart';
import 'package:jesusvlsco/features/bottom_navigation/screen/admin_bottom_navigation_scaffold.dart';
import 'package:jesusvlsco/features/bottom_navigation/screen/user_bottom_navigation_scaffold.dart';
import 'package:jesusvlsco/model/user_loginresponse.dart';

class OtpController extends GetxController {
  // UI State
  var isLoading = false.obs;
  var isVerified = false.obs;

  // Data
  var email = ''.obs;

  // OTP Field Management
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<TextEditingController> phoneotpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> emailfocusNodes = List.generate(6, (_) => FocusNode());
  final List<FocusNode> phonefocusNodes = List.generate(6, (_) => FocusNode());
  String get otp => otpControllers.map((c) => c.text).join('');

  // API endpoint
  static const _verifyUrl = '${ApiConstants.baseurl}/auth/verify/email';

  @override
  void onInit() {
    super.onInit();
    // Get email from login controller if available
    try {
      final loginController = Get.find<LoginController>();
      email.value = loginController.emailController.text.trim();
    } catch (e) {
      print('🚨 Login controller not found: $e');
      // Fallback or error handling if needed
    }

    // Request focus on the first OTP field when the screen is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (emailfocusNodes.isNotEmpty) {
        emailfocusNodes[0].requestFocus();
      }
    });
  }

  @override
  void onClose() {
    // Clean up controllers and focus nodes
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var controller in phoneotpControllers) {
      controller.dispose();
    }
    for (var node in emailfocusNodes) {
      node.dispose();
    }
    for (var node in phonefocusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  // Handle OTP input and focus change
  void onOtpChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 5) {
        // Fixed: should be 5, not 7 for 6-digit OTP
        emailfocusNodes[index + 1].requestFocus();
      } else {
        emailfocusNodes[index].unfocus();
        // Optionally trigger verification when the last digit is entered
        if (otp.length == 6) {
          verifyOtp();
        }
      }
    } else {
      if (index > 0) {
        emailfocusNodes[index - 1].requestFocus();
      }
    }
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

  // Save user data to SharedPreferences
  Future<void> _saveUserData(LoginResponse loginResponse) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Save authentication token
      await prefs.setString('auth_token', loginResponse.data!.token);

      // Save user role
      await prefs.setString('user_role', loginResponse.data!.user.role);

      // Save user ID
      await prefs.setString('user_id', loginResponse.data!.user.id);

      // Save user email
      await prefs.setString('user_email', loginResponse.data!.user.email);

      // Save employee ID
      await prefs.setInt('employee_id', loginResponse.data!.user.employeeID);

      // Save verification status
      await prefs.setBool('is_verified', loginResponse.data!.user.isVerified);

      // Save login status
      await prefs.setBool('is_logged_in', true);

      // Optionally save user profile data as JSON string
      await prefs.setString(
        'user_profile',
        json.encode(loginResponse.data!.user.profile?.toJson()),
      );

      // Save full user data as JSON for future use
      await prefs.setString(
        'user_data',
        json.encode(loginResponse.data!.user.toJson()),
      );

      print('✅ User data saved to SharedPreferences successfully');
    } catch (e) {
      print('🚨 Error saving user data: $e');
      throw Exception('Failed to save user data');
    }
  }

  // Clear all user data from SharedPreferences (for logout)
  Future<void> clearUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.remove('auth_token');
      await prefs.remove('user_role');
      await prefs.remove('user_id');
      await prefs.remove('user_email');
      await prefs.remove('employee_id');
      await prefs.remove('is_verified');
      await prefs.remove('is_logged_in');
      await prefs.remove('user_profile');
      await prefs.remove('user_data');

      print('✅ User data cleared from SharedPreferences');
    } catch (e) {
      print('🚨 Error clearing user data: $e');
    }
  }

  // Navigate based on user role
  void navigateBasedOnRole(String userRole) {
    // Small delay to ensure UI updates properly
    Future.delayed(const Duration(milliseconds: 500), () {
      if (userRole == 'ADMIN') {
        Get.offAll(() => AdminBottomNavigationScaffold());
      } else {
        Get.offAll(() => const UserBottomNavigationScaffold());
      }
    });
  }

  // Email OTP verification function
  Future<void> verifyOtp() async {
    // ✅ Validate inputs
    if (email.value.isEmpty) {
      _showSnackbar('❌ Error', 'Email is required. Please go back to login.');
      return;
    }

    if (otp.length != 6) {
      _showSnackbar('❌ Error', 'Please enter a valid 6-digit OTP');
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(_verifyUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"email": email.value, "otp": int.parse(otp)}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = json.decode(response.body);

        if (decoded != null && decoded is Map<String, dynamic>) {
          final loginResponse = LoginResponse.fromJson(decoded);

          if (loginResponse.success && loginResponse.data!.user.isVerified) {
            isVerified.value = true;

            // 🔥 Save user data to SharedPreferences
            await _saveUserData(loginResponse);
            print('userrole: ${loginResponse.data!.user.role}');

            _showSnackbar(
              '✅ Success',
              'Email verified successfully!',
              isError: false,
            );

            // Logger().i('📱 Verification Response: ${response.body}');

            // Navigate based on user role instead of verification complete
            navigateBasedOnRole(loginResponse.data!.user.role);
          } else {
            _showSnackbar('❌ Error', 'Verification failed. Please try again.');
          }
        } else {
          _showSnackbar('❌ Error', 'Invalid response format from server.');
        }
      } else {
        final responseBody = json.decode(response.body);
        final errorMessage =
            responseBody['message'] ?? 'Invalid OTP. Please try again.';
        _showSnackbar('❌ Error', errorMessage);
      }
    } catch (e) {
      _showSnackbar('❌ Error', 'Network error. Please check your connection.');
      print('🚨 Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Reset verification state
  void reset() {
    isVerified.value = false;
    isLoading.value = false;
    for (var controller in otpControllers) {
      controller.clear();
    }
    for (var controller in phoneotpControllers) {
      controller.clear();
    }
    if (emailfocusNodes.isNotEmpty) {
      emailfocusNodes[0].requestFocus();
    }
  }
}
