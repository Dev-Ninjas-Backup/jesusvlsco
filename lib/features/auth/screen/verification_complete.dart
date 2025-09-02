// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/app_texts.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/icon_path.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/routes/config/route_constants.dart';

class VerificationComplete extends StatelessWidget {
  const VerificationComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.loginGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: Sizer.defaultPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: Sizer.wp(360),
                        height: Sizer.hp(280),
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizer.wp(20),
                          vertical: Sizer.hp(24),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                            SizedBox(height: Sizer.hp(16)),
                            Image.asset(
                              IconPath.success,
                              width: Sizer.wp(60),
                              height: Sizer.hp(60),
                            ),
                            SizedBox(height: Sizer.hp(24)),
                            Text(
                              AppText.verificationComplete,
                              style: AppTextStyle.semibold().copyWith(
                                fontSize: Sizer.wp(20),
                                fontWeight: FontWeight.w800,
                                color: AppColors.color1,
                              ),
                            ),
                            SizedBox(height: Sizer.hp(16)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Sizer.wp(12),
                              ),
                              child: SizedBox(
                                width: Sizer.wp(312),
                                height: Sizer.hp(48),
                                child: CupertinoButton(
                                  onPressed: () {
                                    context.pushNamed(RouteNames.adminHome);
                                  },
                                  color: AppColors.color1,
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    AppText.checkMessage,
                                    style: AppTextStyle.semiregular().copyWith(
                                      fontSize: Sizer.wp(14),
                                      color: AppColors.backgroundLight,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Sizer.hp(16)),
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
