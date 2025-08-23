import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';
import 'package:jesusvlsco/features/auth/controller/login_controller.dart';
import 'package:jesusvlsco/features/auth/screen/verification_complete.dart';
import 'package:logger/web.dart';

class OtpController extends GetxController {
  // UI State
  var isLoading = false.obs;
  var isVerified = false.obs;
  
  // Data
  var email = ''.obs;
  
  // OTP Field Management
  final List<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController());
    final List<TextEditingController> phoneotpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> emailfocusNodes = List.generate(6, (_) => FocusNode());
  final List<FocusNode> phonefocusNodes = List.generate(6, (_) => FocusNode());
  String get otp => otpControllers.map((c) => c.text).join('');

  // API endpoint
  static const _verifyUrl = '$baseurl/auth/verify/email';

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
    for (var node in emailfocusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  // Handle OTP input and focus change
  void onOtpChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 7) {
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

  // Email OTP verification function
  Future<void> verifyOtp() async {
    // Validate inputs
    if (email.value.isEmpty) {
      _showSnackbar('❌ Error', 'Email is required. Please go back to login.');
      return;
    }
    
    if (otp.length != 6) {
      _showSnackbar('❌ Error', 'Please enter a valid 4-digit OTP');
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
        isVerified.value = true;
        _showSnackbar('✅ Success', 'Email verified successfully!', isError: false);
    
        Logger().i('📱 Verification Response: ${response.body}');
        Get.to(VerificationComplete());
      } else {
        final responseBody = json.decode(response.body);
        final errorMessage = responseBody['message'] ?? 'Invalid OTP. Please try again.';
        _showSnackbar('❌ Error', errorMessage);
      
      }
    } catch (e) {
      _showSnackbar('❌ Error', 'Network error. Please check your connection.');
     
    } finally {
      isLoading.value = false;
    }
  }
  
  // // Resend OTP function
  // Future<void> resendOtp() async {
  //   if (email.value.isEmpty) {
  //     _showSnackbar('❌ Error', 'Email is required. Please go back to login.');
  //     return;
  //   }
    
  //   isLoading.value = true;
    
  //   try {
  //     final response = await http.post(
  //       Uri.parse(_resendUrl),
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode({"email": email.value}),
  //     );
      
  //     if (response.statusCode == 200) {
  //       _showSnackbar('✅ Success', 'OTP resent to your email! 📧', isError: false);
  //     } else {
  //       _showSnackbar('❌ Error', 'Failed to resend OTP. Please try again.');
  //     }
  //   } catch (e) {
  //     _showSnackbar('❌ Error', 'Network error. Please try again.');
  //     print('🚨 Resend OTP Error: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  
  // Reset verification state
  void reset() {
    isVerified.value = false;
    isLoading.value = false;
    for (var controller in otpControllers) {
      controller.clear();
    }
    if (emailfocusNodes.isNotEmpty) {
      emailfocusNodes[0].requestFocus();
    }
  }
}
