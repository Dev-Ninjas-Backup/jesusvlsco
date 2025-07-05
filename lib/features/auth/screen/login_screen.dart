import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/app_texts.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/device/device_utility.dart';
import 'package:jesusvlsco/features/auth/controller/login_controller.dart';
import 'package:jesusvlsco/routes/config/route_constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = AppDeviceUtility.getScreenHeight();
    double screenWidth = AppDeviceUtility.getScreenWidth(context);
    final loginController = Get.find<LoginController>();
    loginController.login();

    return Scaffold(
      body: ScreenUtilInit(
        child: Container(
          decoration: BoxDecoration(gradient: AppColors.loginGradient),
          child: SafeArea(
            child: Center(
              child: Container(
                height: screenHeight * 0.4,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  color: AppColors.primaryBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppText.welcome,
                        style: AppTextStyle.textlarge(), // ✅ Updated style
                      ),

                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        AppText.loginToProfile1,
                        style: AppTextStyle.regular().copyWith(
                          color: AppColors.textPrimary, // ✅ Updated color

                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ), // 5% of screen height for spacing
                    ElevatedButton(
                      onPressed: () {
                        // context.goNamed(RouteNames.verifyMethod);
                        context.goNamed(RouteNames.home);
                        // Navigate to the phone login screen
                        // Get.toNamed(AppRoute.getChooseAnotherWay());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.color1, // Button color
                        minimumSize: Size(
                          double.infinity,
                          screenHeight * 0.065,
                        ), // Full width with dynamic height
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),

                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      ElevatedButton(
                        onPressed: () {
                          context.goNamed(RouteNames.verifyMethod);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary, // ✅ Updated color
                          minimumSize: Size(
                            double.infinity,
                            screenHeight * 0.065,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.phone_android, color: Colors.white),
                            const SizedBox(width: 10),
                            Text(
                              AppText.loginphone,
                              style: AppTextStyle.baseTextStyle(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w500,
                              ).copyWith(color: Colors.white), // ✅ Styled text
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      ElevatedButton(
                        onPressed: () {
                          context.goNamed(RouteNames.loginwithemail);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary, // ✅ Updated
                          minimumSize: Size(
                            double.infinity,
                            screenHeight * 0.065,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.email, color: AppColors.textSecondary),
                            SizedBox(width: 10),
                            Text(
                              AppText.loginemail,
                              style: AppTextStyle.baseTextStyle(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w500,
                              ).copyWith(color: AppColors.textSecondary), // ✅ Styled text
                            ),
                          ],
                        ),
                      ),
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
}
