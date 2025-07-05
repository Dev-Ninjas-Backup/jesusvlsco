import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
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
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.loginGradient),
        child: SafeArea(
          child: Center(
            child: Container(
              height:
                  screenHeight * 0.4, // 40% of screen height for the container
              width: screenWidth * 0.9, // 90% of screen width for the container
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  screenWidth * 0.05,
                ), // 5% padding for content
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppText.welcome,
                      style: TextStyle(
                        fontSize:
                            screenWidth *
                            0.08, // Dynamic font size based on screen width
                        fontWeight: FontWeight.bold,
                        color:
                            AppColors.color1, // Adjust color to match the theme
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ), // 2% of screen height for spacing
                    Text(
                      AppText.loginToProfile1,
                      style: TextStyle(
                        fontSize:
                            screenWidth *
                            0.045, // Smaller font for the subheading
                        color: AppColors.backgroundDark,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ), // 5% of screen height for spacing
                    ElevatedButton(
                      onPressed: () {
                        context.goNamed(RouteNames.verifyMethod);
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone_android),
                          SizedBox(width: 10),
                          Text(
                            AppText.loginphone,
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                            ), // Responsive text size
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01), // 3% height spacing
                    ElevatedButton(
                      onPressed: () {
                        // Get.toNamed(AppRoute.getemailotpverifymethod());
                      },
                      style: ElevatedButton.styleFrom(
                        side: BorderSide.none,
                        backgroundColor: Color.fromARGB(
                          255,
                          223,
                          223,
                          223,
                        ), // Light grey color for the second button
                        minimumSize: Size(
                          double.infinity,
                          screenHeight * 0.065,
                        ), // Full width and dynamic height
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.email, color: AppColors.color3),
                          SizedBox(width: 10),
                          Text(
                            AppText.loginemail,
                            style: TextStyle(
                              color: AppColors.color3,
                              fontSize: screenWidth * 0.04,
                            ), // Responsive text size
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
    );
  }
}
