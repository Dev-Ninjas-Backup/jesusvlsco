// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/app_texts.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/auth/controller/otp_verification_controller.dart';
import 'package:loading_indicator/loading_indicator.dart';

class EmailOtpverfication extends StatelessWidget {
  const EmailOtpverfication({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize OTP controller
    final controller = Get.put(OtpController());

    return Scaffold(
      body: ScreenUtilInit(
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(gradient: AppColors.loginGradient),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizer.wp(16),
                  vertical: Sizer.hp(16),
                ),
                child: Container(
                  width: Sizer.wp(360),
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizer.wp(16),
                    vertical: Sizer.hp(24),
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
                      SizedBox(height: Sizer.hp(8)),

                      /// Title
                      Text(
                        AppText.check,
                        style: AppTextStyle.semibold().copyWith(
                          color: AppColors.color3,
                        ),
                      ),
                      SizedBox(height: Sizer.hp(12)),

                      /// Subtitle
                      Text(
                        AppText.toconfirm,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semiregular().copyWith(
                          color: AppColors.color3,
                        ),
                      ),
                      SizedBox(height: Sizer.hp(24)),

                      /// OTP Fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          6,
                          (index) => _buildOTPField(controller, index),
                        ),
                      ),
                      SizedBox(height: Sizer.hp(24)),

                      /// Verify Button
                      Obx(
                        () => SizedBox(
                          width: Sizer.wp(312),
                          height: Sizer.wp(48),
                          child: ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : controller.verifyOtp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.color1,
                              foregroundColor: AppColors.backgroundLight,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: controller.isLoading.value
                                ? Center(
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: LoadingIndicator(
                                        indicatorType: Indicator.ballPulseSync,

                                        colors: [AppColors.primary],
                                        strokeWidth: 2,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                  )
                                : Text(
                                    AppText.verify,
                                    style: AppTextStyle.semibold().copyWith(
                                      color: AppColors.textWhite,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: Sizer.hp(8)),

                      // /// Resend OTP Button
                      // Obx(() => TextButton(
                      //   onPressed: controller.isLoading.value
                      //     ? null
                      //     : controller.resendOtp,
                      //   child: Text(
                      //     '📧 Resend OTP',
                      //     style: AppTextStyle.semiregular().copyWith(
                      //       color: controller.isLoading.value
                      //         ? AppColors.color3.withValues(alpha: 0.5)
                      //         : AppColors.color1,
                      //     ),
                      //   ),
                      // )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// OTP Field Builder
  Widget _buildOTPField(OtpController controller, int index) {
    return Container(
      width: Sizer.wp(40),
      height: Sizer.hp(40),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.color2, width: 1),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: controller.otpControllers[index],
        focusNode: controller.emailfocusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: AppTextStyle.semibold().copyWith(color: Colors.black87),
        decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          counterText: '',
          contentPadding: EdgeInsets.zero,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) => controller.onOtpChanged(index, value),
        onTap: () {
          // Ensure cursor is at the end of the text
          final controller_ = controller.otpControllers[index];
          controller_.selection = TextSelection.fromPosition(
            TextPosition(offset: controller_.text.length),
          );
        },
      ),
    );
  }
}
