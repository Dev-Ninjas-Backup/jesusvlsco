import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/utils/constants/app_texts.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/enums.dart';

class VerifyMethodScreen extends StatefulWidget {
  const VerifyMethodScreen({super.key});

  @override
  State<VerifyMethodScreen> createState() => _VerifyMethodScreenState();
}

class _VerifyMethodScreenState extends State<VerifyMethodScreen> {
  ResendMethod? _selectedMethod = ResendMethod.sms; // Default to SMS

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.loginGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Main content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Resend Code Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            const Text(
                              AppText.chooseAnotherWay,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
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

                            // Resend code button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_selectedMethod == ResendMethod.email) {
                                    // Get.toNamed(AppRoute.getemailotpverify());
                                  }
                                  if (_selectedMethod == ResendMethod.call) {
                                    // Get.toNamed(AppRoute.getphoneverifymethod());
                                  }
                                  // Handle phone number login
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.color1,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  AppText.resendCode,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
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
                  color: isSelected ? AppColors.color1 : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF6B5B95),
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
              color: isSelected ? AppColors.color1 : Colors.grey.shade600,
            ),
            const SizedBox(width: 12),

            // Text
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? AppColors.color1 : AppColors.color3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
