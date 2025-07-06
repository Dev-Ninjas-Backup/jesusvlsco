// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/app_texts.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/auth/controller/phone_controller.dart';
import 'package:jesusvlsco/routes/config/route_constants.dart';

class Phoneverifymethod extends StatefulWidget {
  const Phoneverifymethod({super.key});

  @override
  State<Phoneverifymethod> createState() => _PhoneverifymethodState();
}

class _PhoneverifymethodState extends State<Phoneverifymethod> {
  CountryCode _selectedCountryCode = CountryCode.fromCountryCode('BD');
  final Numbercontroller _numbercontroller = Get.put(Numbercontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Allows scroll on keyboard open
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(gradient: AppColors.loginGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Use Flexible to avoid overflow
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: Sizer.wp(16),right: Sizer.wp(16)),
                  child: Container(
                    // width: Sizer.wp(360),
                    // height: 361,
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 48,
                      bottom: 48,
                    ),
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
                        Text(
                          AppText.welcome,
                          style: AppTextStyle.textlarge(),
                        ),
                        SizedBox(height: Sizer.hp(8)),
                  
                        Text(
                          AppText.loginToProfile,
                          style: AppTextStyle.regular().copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: Sizer.hp(24)),
                  
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.textSecondary,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              CountryCodePicker(
                                onChanged: (CountryCode code) {
                                  setState(() {
                                    _selectedCountryCode = code;
                                  });
                                },
                                initialSelection: 'BD',
                                favorite: const ['+880', 'BD'],
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: true,
                                alignLeft: false,
                                showDropDownButton: true,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                textStyle: AppTextStyle.regular().copyWith(
                                  color: AppColors.textSecondary,
                                ),
                                dialogTextStyle: AppTextStyle.regular()
                                    .copyWith(color: AppColors.textSecondary),
                                searchStyle: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.color3,
                                ),
                                searchDecoration: const InputDecoration(
                                  hintText: 'Search country',
                                  border: OutlineInputBorder(),
                                ),
                                dialogSize: Size(
                                  MediaQuery.of(context).size.width * 0.8,
                                  MediaQuery.of(context).size.height * 0.6,
                                ),
                                builder: (CountryCode? countryCode) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 16,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          countryCode?.code ?? 'BD',
                                          style: AppTextStyle.textlarge()
                                              .copyWith(
                                                fontSize: Sizer.wp(14),
                                                color:
                                                    AppColors.textSecondary,
                                              ),
                                        ),
                                        const SizedBox(width: 4),
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          color: AppColors.color3,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              Expanded(
                                child: TextField(
                                  
                                  controller:
                                      _numbercontroller.phoneController,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(15),
                                  ],
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hintText:
                                        _selectedCountryCode.dialCode ??
                                        '+880',
                                    hintStyle: const TextStyle(
                                      color: AppColors.color3,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(
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
                        SizedBox(height: Sizer.hp(8)),
                  
                        const Text(
                          AppText.verifyNumberMessage,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.color3,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: Sizer.hp(20)),
                  
                        SizedBox(
                          width: Sizer.wp(312),
                          height: Sizer.hp(48),
                          child: ElevatedButton(
                            onPressed: () {
                              _numbercontroller.validatePhoneNumber();
                              context.pushNamed(RouteNames.loginphoneotp);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.color1,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              AppText.verify,
                              style: AppTextStyle.semibold(
                               
                              ).copyWith(
                                fontSize: Sizer.wp(16),
                                 color: AppColors.backgroundLight,
                            ),
                          ),
                        ),
                    )],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
