import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/core/utils/constants/app_texts.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/enums.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
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
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.loginGradient),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
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
                            // Title
                            Text(
                              AppText.chooseAnotherWay,
                              style: AppTextStyle.baseTextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ).copyWith(color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 24),

                            // WhatsApp Option
                            _buildResendOption(
                              method: ResendMethod.whatsapp,
                              icon: Icons.chat_bubble_outline,
                              text: AppText.resendViaWhatsapp,
                              isSelected:
                                  _selectedMethod == ResendMethod.whatsapp,
                            ),
                            const SizedBox(height: 16),

                            // SMS Option
                            _buildResendOption(
                              method: ResendMethod.sms,
                              icon: Icons.sms_outlined,
                              text: AppText.resendViaSMS,
                              isSelected: _selectedMethod == ResendMethod.sms,
                            ),
                            const SizedBox(height: 16),

                            // Call Option
                            _buildResendOption(
                              method: ResendMethod.call,
                              icon: Icons.phone_outlined,
                              text: AppText.resendViaCall,
                              isSelected: _selectedMethod == ResendMethod.call,
                            ),
                            const SizedBox(height: 16),

                            // Email Option
                            _buildResendOption(
                              method: ResendMethod.email,
                              icon: Icons.email_outlined,
                              text: AppText.resendViaEmail,
                              isSelected: _selectedMethod == ResendMethod.email,
                            ),
                            const SizedBox(height: 32),

                            // Resend Button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_selectedMethod == ResendMethod.email) {
                                    // context.goNamed(RouteNames.emailotp);
                                  }
                                  if (_selectedMethod == ResendMethod.call) {
                                    context.goNamed(RouteNames.loginwithphone);
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
                                  style: AppTextStyle.baseTextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ).copyWith(color: Colors.white),
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

  Widget _buildResendOption({
    required ResendMethod method,
    required IconData icon,
    required String text,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = method;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.color3, width: 1),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            // Radio button
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),

            // Icon
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.primary : Colors.grey.shade600,
            ),
            const SizedBox(width: 12),

            // Text
            Expanded(
              child: Text(
                text,
                style: AppTextStyle.baseTextStyle(
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
