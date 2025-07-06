import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/app_texts.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/routes/config/route_constants.dart';

class EmailOtpverfication extends StatefulWidget {
  const EmailOtpverfication({super.key});

  @override
  State<EmailOtpverfication> createState() => _EmailOtpverficationState();
}

class _EmailOtpverficationState extends State<EmailOtpverfication> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenUtilInit(
      
        child: Container(
          // width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(gradient: AppColors.loginGradient),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizer.wp(16),
                      vertical: Sizer.hp(16),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Container(
                        width: Sizer.wp(360),
                        height: Sizer.wp(316),
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Sizer.wp(16),
                            vertical: Sizer.hp(24),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: Sizer.hp(8)),
                                
                              /// Title
                              Text(
                                AppText.check,
                                style: AppTextStyle.semibold().copyWith(
                                  color: AppColors.color3,
                                ),
                              ),
                              SizedBox(height: Sizer.hp(12)),
                                
                              /// Subtitle
                              Text(
                                AppText.toconfirm,
                                textAlign: TextAlign.center,
                                style: AppTextStyle.semiregular().copyWith(
                                  color: AppColors.color3,
                                ),
                              ),
                              SizedBox(height: Sizer.hp(24)),
                                
                              /// OTP Fields
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  4,
                                  (index) => _buildOTPField(index),
                                ),
                              ),
                              SizedBox(height: Sizer.hp(24)),
                                
                              /// Verify Button
                              SizedBox(
                                width: Sizer.wp(312),
                                height: Sizer.wp(48),
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.pushNamed(RouteNames.verifycomplete);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.color1,
                                    foregroundColor: AppColors.backgroundLight,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    AppText.verify,
                                    style: AppTextStyle.semibold().copyWith(
                                      color: AppColors.textWhite,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: Sizer.hp(8)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// OTP Field Builder
  Widget _buildOTPField(int index) {
    return Container(
      width: Sizer.wp(48),
      height: Sizer.hp(48),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.color2, width: 1),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: AppTextStyle.semibold().copyWith(color: Colors.black87),
        decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          counterText: '',
          contentPadding: EdgeInsets.zero,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) => _handleOTPInput(index, value),
        onTap: () {
          _controllers[index].selection = TextSelection.fromPosition(
            TextPosition(offset: _controllers[index].text.length),
          );
        },
      ),
    );
  }

  void _handleOTPInput(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }
}
