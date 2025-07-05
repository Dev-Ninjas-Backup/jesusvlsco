// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/app_texts.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

import 'package:jesusvlsco/core/utils/device/device_utility.dart';
import 'package:jesusvlsco/routes/routing.dart';

class Phoneotpverify extends StatefulWidget {
  const Phoneotpverify({Key? key}) : super(key: key);

  @override
  State<Phoneotpverify> createState() => _PhoneotpverifyState();
}

class _PhoneotpverifyState extends State<Phoneotpverify> {
  // Controllers for OTP input fields
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());

  // Focus nodes for OTP input navigation
  final List<FocusNode> _focusNodes =
      List.generate(4, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    // Automatically focus the first OTP input on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = AppDeviceUtility.getScreenWidth(context);

    return Scaffold(
      body: Container(
        // Gradient background
        decoration: const BoxDecoration(
          gradient: AppColors.loginGradient,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Main content container
              Padding(
                padding: Sizer.defaultPadding,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Title text
                      Text(
                        AppText.enterDigitCode,
                        style: AppTextStyle.semibold().copyWith(
                          color: AppColors.textPrimary
                        ), // Bold large title
                      ),
                      const SizedBox(height: 8),

                      // Subtext with phone number
                      Text(
                        "${AppText.sentTo}+91 1234567890",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.regular().copyWith(color: AppColors.textSecondary), // Regular subtext
                      ),
                      const SizedBox(height: 40),

                      // OTP input fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          4,
                          (index) => _buildOTPField(index),
                        ),
                      ),
                      const SizedBox(height: 22),

                      // Resend section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppText.didntGet,
                            style: AppTextStyle.semiregular().copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            AppText.moreOptions,
                            style: AppTextStyle.regular().copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),

                      // Verify button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            context.goNamed(RouteNames.verifycomplete);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide.none,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            AppText.verify,
                            style: AppTextStyle.textbold().copyWith(
                              color: AppColors.textWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Builds individual OTP input field
  Widget _buildOTPField(int index) {
    return Container(
      width: Sizer.wp(48),
      height: Sizer.hp(48),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.color2, width: 1),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: AppTextStyle.textlarge().copyWith(
          fontSize: 20, // Override for OTP field size
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
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) => _handleOTPInput(index, value),
        onTap: () => _controllers[index].selection = TextSelection.fromPosition(
          TextPosition(offset: _controllers[index].text.length),
        ),
      ),
    );
  }

  // Handles moving focus between OTP fields
  void _handleOTPInput(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 3) {
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
