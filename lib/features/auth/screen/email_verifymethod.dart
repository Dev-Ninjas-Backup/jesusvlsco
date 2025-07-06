import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/app_texts.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/routes/config/route_constants.dart';

// Text constants class

class EmailotpverifyMethod extends StatefulWidget {
  const EmailotpverifyMethod({super.key});

  @override
  State<EmailotpverifyMethod> createState() => _EmailotpverifyMethodState();
}

class _EmailotpverifyMethodState extends State<EmailotpverifyMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenUtilInit(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(gradient: AppColors.loginGradient),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Main content
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Login Card
                  Padding(
                    padding:  EdgeInsets.only(left: Sizer.wp(24), right: Sizer.wp(24)),
                    child: Container(
                      // width: Sizer.wp(360),
                      // // height: MediaQuery.of(context).size.height * (361/852),
                      // height: Sizer.hp(361),
                    
                      // padding: EdgeInsets.only(
                      //   left: Sizer.wp(24),
                      //   right: Sizer.wp(24),
                      // ),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: Sizer.hp(48)),
                          // Welcome title
                          RichText(
                            text: TextSpan(
                              text: AppText.verifyEmail,
                              style: AppTextStyle.semibold().copyWith(
                                color: AppColors.backgroundDark,
                              ),
                            ),
                          ),
                          SizedBox(height: Sizer.hp(12)),
                    
                          // Subtitle
                          const Text(
                            overflow: TextOverflow.ellipsis,
                            AppText.enterEmail, 
                            style: TextStyle(
                              
                              fontSize: 16,
                              color: AppColors.color3,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // Verify button
                          SizedBox(height: Sizer.hp(24)),
                          Padding(
                            padding: EdgeInsets.only(
                              left: Sizer.wp(24),
                              right: Sizer.wp(24),
                            ),
                            child: TextFormField(
                                  
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                hintText: AppText.emailname,
                                hintStyle: AppTextStyle.semiregular().copyWith(
                                  color: AppColors.textSecondary,
                                ),
                               
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onFieldSubmitted: (value) {
                                context.goNamed(RouteNames.loginemailotp);
                              },
                            ),
                          ),
                          SizedBox(height: Sizer.hp(24)),
                    
                          Padding(
                            padding: EdgeInsets.only(
                              left: Sizer.wp(24),
                              right: Sizer.wp(24),
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape:
                                    WidgetStateProperty.all<
                                      RoundedRectangleBorder
                                    >(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                      ),
                                    ),
                              ),
                              onPressed: () {
                                context.pushNamed(RouteNames.loginemailotp);
                              },
                              child: Text(
                                  AppText.verify,
                                  style: AppTextStyle.semiregular(
                                   
                                  ).copyWith(
                                    fontSize: Sizer.wp(16),
                                     color: AppColors.backgroundLight,
                                ),
                              ),
                            ),
                          ),
                              SizedBox(height: Sizer.hp(48)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
