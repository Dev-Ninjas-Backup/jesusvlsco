import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/app_texts.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/icon_path.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/core/utils/device/device_utility.dart';
import 'package:jesusvlsco/features/auth/controller/login_controller.dart';
import 'package:jesusvlsco/routes/config/route_constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = AppDeviceUtility.getScreenHeight();

    final loginController = Get.find<LoginController>();
    loginController.login();

    return Scaffold(
      body: ScreenUtilInit(
        child: Container(
          decoration: BoxDecoration(gradient: AppColors.loginGradient),
          child: Center(
            child: Container(
              height: Sizer.hp(328),
              width: Sizer.wp(360),
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizer.wp(24),
                  // vertical: Sizer.hp(48),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppText.welcome,
                      style: AppTextStyle.textlarge(), // ✅ Updated style
                    ),
          
                    SizedBox(height: Sizer.hp(8)),
                    Text(
                      AppText.loginToProfile1,
                      style: AppTextStyle.regular().copyWith(
                        color: AppColors.textPrimary, // ✅ Updated color
                      ),
                    ),
                    SizedBox(
                      height: Sizer.hp(24), // ✅ Updated spacing
                    ), // 5% of screen height for spacing
                    ElevatedButton(
                      onPressed: () {
                        context.pushNamed(RouteNames.loginwithphone);
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
// <<<<<<< mugdho
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            height: Sizer.hp(24),
                            width: Sizer.wp(24),
                            'assets/icons/device.png',
                            color: Colors.white,
// =======
                      SizedBox(
                        height: Sizer.hp(24), // ✅ Updated spacing
                      ), // 5% of screen height for spacing
                      ElevatedButton(
                        onPressed: () {

                          context.goNamed(RouteNames.home);

//                           context.pushNamed(RouteNames.verifyMethod);

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary, // ✅ Updated color
                          minimumSize: Size(
                            double.infinity,
                            screenHeight * 0.065,
// >>>>>>> main
                          ),
                          const SizedBox(width: 10),
                          Text(
                            AppText.loginphone,
                            style: AppTextStyle.semibold(
                              
                            ).copyWith(color: Colors.white), // ✅ Styled text
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Sizer.hp(16)), // ✅ Updated spacing
                    ElevatedButton(
                      onPressed: () {
                        context.pushNamed(RouteNames.loginwithemail);
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
                        Image.asset(
                            height: Sizer.hp(24),
                            width: Sizer.wp(24),
                            IconPath.mailicon,
                            
                          ),
                          SizedBox(width: 10),
                          Text(
                            AppText.loginemail,
                            style:
                                AppTextStyle.semibold(
                                  
                                ).copyWith(
                                  color: AppColors.textSecondary,
                                ), // ✅ Styled text
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
