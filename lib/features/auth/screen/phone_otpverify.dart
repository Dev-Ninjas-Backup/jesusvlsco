// ignore_for_file: camel_case_types, deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';
import 'package:jesusvlsco/core/utils/constants/app_texts.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/routes/routing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/user_loginresponse.dart';
import '../../bottom_navigation/screen/admin_bottom_navigation_scaffold.dart';
import '../../bottom_navigation/screen/user_bottom_navigation_scaffold.dart';

class Phoneotpverify extends StatefulWidget {
  final String phoneNumber; // Dynamic phone number
  const Phoneotpverify({super.key, required this.phoneNumber});

  @override
  State<Phoneotpverify> createState() => _PhoneotpverifyState();
}

class _PhoneotpverifyState extends State<Phoneotpverify> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  // Collect OTP digits
  String _getOtpCode() {
    return _controllers.map((controller) => controller.text).join();
  }

  // HTTPS API call
  Future<void> _verifyOtp() async {
    final otpCode = _getOtpCode();
    if (otpCode.length != 6 || otpCode.contains(' ')) {
      _showSnackBar('Please enter a valid 6-digit OTP');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      const String apiUrl = '${ApiConstants.baseurl}/auth/verify/phone';
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phoneNumber': widget.phoneNumber, 'otp': otpCode}),
      );

      if (kDebugMode) {
        print('res: ${response.body}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = json.decode(response.body);
        final loginResponse = LoginResponse.fromJson(decoded);

        // 🔥 Save user data to SharedPreferences
        await _saveUserData(loginResponse);
        if (kDebugMode) {
          print('userrole: ${loginResponse.data!.user.role}');
        }

        if (mounted) {
          _showSnackbar(
            '✅ Success',
            'Phone verified successfully!',
            isError: false,
          );

          // Navigate based on user role instead of verification complete
          navigateBasedOnRole(loginResponse.data!.user.role);
        }
      } else {
        final errorMessage =
            jsonDecode(response.body)['message'] ?? 'OTP verification failed';
        _showSnackBar(errorMessage);
      }
    } catch (e) {
      _showSnackBar('An error occurred: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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

      if (kDebugMode) {
        print('✅ User data saved to SharedPreferences successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('🚨 Error saving user data: $e');
      }
      throw Exception('Failed to save user data');
    }
  }

  // Show SnackBar for errors
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: AppColors.loginGradient),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: Sizer.wp(16), right: Sizer.wp(16)),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizer.wp(24),
                  vertical: Sizer.hp(48),
                ),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppText.enterDigitCode,
                      style: AppTextStyle.semibold().copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: Sizer.hp(8)),
                    Text(
                      "${AppText.sentTo}${widget.phoneNumber}", // Display dynamic phone number
                      textAlign: TextAlign.center,
                      style: AppTextStyle.regular().copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: Sizer.hp(24)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        6,
                        (index) => _buildOTPField(index),
                      ),
                    ),
                    SizedBox(height: Sizer.hp(24)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppText.didntGet,
                          style: AppTextStyle.semiregular().copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(RouteNames.verifyMethod);
                          },
                          child: Text(
                            AppText.moreOptions,
                            style: AppTextStyle.regular().copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Sizer.hp(24)),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _verifyOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: AppColors.textWhite,
                              )
                            : Text(
                                AppText.verify,
                                style: AppTextStyle.textbold().copyWith(
                                  color: AppColors.textWhite,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: Sizer.hp(24)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPField(int index) {
    return Container(
      width: Sizer.wp(36),
      height: Sizer.hp(36),
      margin: EdgeInsets.symmetric(horizontal: Sizer.wp(7)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.color2, width: 1),
        borderRadius: BorderRadius.circular(8),
        color: AppColors.backgroundLight,
      ),
      child: TextFormField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: AppTextStyle.textlarge().copyWith(
          fontSize: Sizer.wp(16),
          color: Colors.black87,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          counterText: '',
          contentPadding: EdgeInsets.zero,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) => _handleOTPInput(index, value),
        onTap: () => _controllers[index].selection = TextSelection.fromPosition(
          TextPosition(offset: _controllers[index].text.length),
        ),
      ),
    );
  }

  void _handleOTPInput(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }
}
