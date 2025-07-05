import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
// Import for AppTextStyle

class VerificationComplete extends StatelessWidget {
  const VerificationComplete({super.key});

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
                            // ✅ Title using textlarge
                            Text(
                              "Verification Complete",
                              style: AppTextStyle.textbold().copyWith(
                                fontSize: Sizer.wp(20),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF6B5B95),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // ✅ Button using semibold and color from AppColors
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: CupertinoButton(
                                onPressed: () {
                                
                                },
                                color: AppColors.color1,
                                child: Text(
                                  "Lets Go !",
                                  style: AppTextStyle.semiregular().copyWith(
                                    color: AppColors.backgroundLight,
                                  ),
                                ),
                              ),
                            ),
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
