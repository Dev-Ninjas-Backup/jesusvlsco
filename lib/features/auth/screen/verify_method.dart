// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/core/utils/constants/app_texts.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/enums.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/icon_path.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/routes/config/route_constants.dart';

class VerifyMethodScreen extends StatefulWidget {
  const VerifyMethodScreen({super.key});

  @override
  State<VerifyMethodScreen> createState() => _VerifyMethodScreenState();
}

class _VerifyMethodScreenState extends State<VerifyMethodScreen> {
  ResendMethod? _selectedMethod = ResendMethod.sms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(gradient: AppColors.loginGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Sizer.hp(205)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: Sizer.wp(360),
                    height: Sizer.hp(480),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: Sizer.hp(48)),

                        // Title
                        Text(
                          AppText.chooseAnotherWay,
                          style: AppTextStyle.baseTextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ).copyWith(color: AppColors.textSecondary),
                        ),
                        SizedBox(height: Sizer.hp(32)),

                        // Options
                        _buildResendOption(
                          method: ResendMethod.whatsapp,
                          imagePath: IconPath.whatsapp,
                          text: AppText.resendViaWhatsapp,
                        ),
                        SizedBox(height: Sizer.hp(16)),

                        _buildResendOption(
                          method: ResendMethod.sms,
                          imagePath: IconPath.sms,
                          text: AppText.resendViaSMS,
                        ),
                        SizedBox(height: Sizer.hp(16)),

                        _buildResendOption(
                          method: ResendMethod.call,
                          imagePath: IconPath.call,
                          text: AppText.resendViaCall,
                        ),
                        SizedBox(height: Sizer.hp(16)),

                        _buildResendOption(
                          method: ResendMethod.email,
                          imagePath: IconPath.mail,
                          text: AppText.resendViaEmail,
                        ),
                        SizedBox(height: Sizer.hp(32)),

                        // Resend Button
                        SizedBox(
                          width: Sizer.wp(312),
                          height: Sizer.hp(48),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_selectedMethod == ResendMethod.email) {
                                context.pushNamed(RouteNames.loginwithemail);
                              }
                              if (_selectedMethod == ResendMethod.call) {
                                context.pushNamed(RouteNames.loginwithphone);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              AppText.resendCode,
                              style: AppTextStyle.semibold().copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Sizer.hp(48)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Sizer.hp(48)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResendOption({
    required ResendMethod method,
    required String imagePath,
    required String text,
  }) {
    bool isSelected = _selectedMethod == method;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = method;
        });
      },
      child: Container(
        height: Sizer.hp(48),
        width: Sizer.wp(312),
        padding: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.color3, width: 1),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            SizedBox(
              width: Sizer.wp(24),
              height: Sizer.hp(24),
              child: Radio<ResendMethod>(
                value: method,
                groupValue: _selectedMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedMethod = value!;
                  });
                },
                activeColor: AppColors.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            const SizedBox(width: 12),
            Image.asset(
              imagePath,
              width: Sizer.wp(24),
              height: Sizer.hp(24),
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style:
                    AppTextStyle.baseTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ).copyWith(
                      color: isSelected ? AppColors.primary : AppColors.color3,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
