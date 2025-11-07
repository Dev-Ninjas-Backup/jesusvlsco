// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/app_texts.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/auth/controller/phone_controller.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Phoneverifymethod extends StatelessWidget {
  const Phoneverifymethod({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhoneController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(gradient: AppColors.loginGradient),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 48,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(AppText.welcome, style: AppTextStyle.textlarge()),
                    SizedBox(height: Sizer.hp(8)),
                    Text(
                      AppText.loginToProfile,
                      style: AppTextStyle.regular().copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: Sizer.hp(24)),
                    _buildPhoneNumberInput(controller, context),
                    SizedBox(height: Sizer.hp(8)),
                    const Text(
                      AppText.verifyNumberMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.color3,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: Sizer.hp(20)),
                    Obx(
                      () => controller.isLoading.value
                          ? Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: LoadingIndicator(
                                  indicatorType: Indicator.ballPulseSync,

                                  colors: [AppColors.primary],
                                  strokeWidth: 2,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            )
                          : _buildVerifyButton(controller),
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

  Widget _buildPhoneNumberInput(
    PhoneController controller,
    BuildContext context,
  ) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: controller.isValidPhone.value
                ? AppColors.primary
                : AppColors.textSecondaryGrey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            _buildCountryCodePicker(controller, context),
            Expanded(
              child: TextField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,

                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(15),
                ],
                decoration: const InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: 'Enter phone number',
                  hintStyle: TextStyle(color: AppColors.textSecondaryGrey),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountryCodePicker(
    PhoneController controller,
    BuildContext context,
  ) {
    return CountryCodePicker(
      onChanged: controller.updateCountryCode,
      initialSelection: 'US',
      favorite: const ['+1', 'US', '+44', 'GB'],
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
      alignLeft: false,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      textStyle: AppTextStyle.regular().copyWith(
        color: AppColors.textSecondary,
      ),
      dialogTextStyle: AppTextStyle.regular().copyWith(
        color: AppColors.textSecondary,
      ),
      searchDecoration: const InputDecoration(
        hintText: 'Search country',
        border: OutlineInputBorder(),
      ),
      dialogSize: Size(
        MediaQuery.of(context).size.width * 0.8,
        MediaQuery.of(context).size.height * 0.6,
      ),
    );
  }

  Widget _buildVerifyButton(PhoneController controller) {
    return Obx(
      () => SizedBox(
        width: Sizer.wp(312),
        height: Sizer.hp(48),
        child: ElevatedButton(
          onPressed: controller.isLoading.value
              ? null
              : controller.loginWithPhone,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.color1,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: controller.isLoading.value
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  AppText.verify,
                  style: AppTextStyle.semibold().copyWith(
                    fontSize: Sizer.wp(16),
                    color: AppColors.backgroundLight,
                  ),
                ),
        ),
      ),
    );
  }
}
