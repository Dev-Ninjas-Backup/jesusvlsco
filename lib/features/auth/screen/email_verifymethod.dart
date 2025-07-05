
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/app_texts.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/routes/config/route_constants.dart';



// Text constants class

class EmailotpverifyMethod extends StatefulWidget {
  const EmailotpverifyMethod({Key? key}) : super(key: key);

  @override
  State<EmailotpverifyMethod> createState() => _EmailotpverifyMethodState();
}

class _EmailotpverifyMethodState extends State<EmailotpverifyMethod> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.loginGradient),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Main content
              Expanded(
                child: Padding(
                  padding: Sizer.defaultPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Login Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                            // Welcome title
                            RichText(
                              text: TextSpan(
                                text: AppText.verifyEmail,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF6B5B95),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Subtitle
                            const Text(
                              AppText.enterEmail,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.color3,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            // Verify button
                            ElevatedButton(
                            style: ButtonStyle(
                             backgroundColor: MaterialStateProperty.all<Color>(AppColors.textWhite),
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide(color: AppColors.textSecondary, width: 1),
                                ),
                              )
                            ),
                              onPressed: (){
                                context.goNamed(RouteNames.loginemailotp);
                              }, child:  Text("Email", style: AppTextStyle.semiregular().copyWith(color: AppColors.textSecondary),)),
                            const SizedBox(height: 22),
                            ElevatedButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              )
                            ),
                              onPressed: (){
                                context.goNamed(RouteNames.loginemailotp);
                              }, child: const Text("Verify"))
                            // Verify button
                            // SizedBox(
                            //   width: double.infinity,
                            //   height: 50,
                            //   child: CupertinoButton(
                            //     onPressed: () {
                            //       context.goNamed(RouteNames.loginemailotp);
                            //     },

                            //     color: AppColors.color1,
                            //     child: const Text(
                            //       "Verify",
                            //       style: TextStyle(
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w600,
                            //         color: AppColors.backgroundLight,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
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
}
