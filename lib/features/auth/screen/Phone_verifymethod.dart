import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';

// Importing app-specific constants and controllers
import 'package:jesusvlsco/core/utils/constants/app_texts.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/auth/controller/phone_controller.dart';
import 'package:jesusvlsco/routes/config/route_constants.dart';

// Phone number verification screen
class Phoneverifymethod extends StatefulWidget {
  const Phoneverifymethod({Key? key}) : super(key: key);

  @override
  State<Phoneverifymethod> createState() => _PhoneverifymethodState();
}

class _PhoneverifymethodState extends State<Phoneverifymethod> {
  // Default selected country code (Bangladesh)
  CountryCode _selectedCountryCode = CountryCode.fromCountryCode('BD');

  // Controller to handle phone number input
  final Numbercontroller _numbercontroller = Get.put(Numbercontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Background gradient for login screen
        decoration: const BoxDecoration(gradient: AppColors.loginGradient),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Main content of the screen
              Expanded(
                child: Padding(
                  padding: Sizer.defaultPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // White card containing login form
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            // Drop shadow for elevation
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
                            // Welcome heading
                            Text(
                              AppText.welcome,
                              style: AppTextStyle.textlarge(),
                            ),
                            const SizedBox(height: 8),

                            // Subtitle below welcome
                            Text(
                              AppText.loginToProfile,
                              style: AppTextStyle.regular().copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Phone number input section
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
                                  // Country code picker dropdown
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
                                        .copyWith(
                                          color: AppColors.textSecondary,
                                        ),
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
                                            // Country code abbreviation (e.g., BD)
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

                                  // Text input for phone number
                                  Expanded(
                                    child: TextField(
                                      controller:
                                          _numbercontroller.phoneController,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [
                                        // Allows digits only, max 15 characters
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(15),
                                      ],
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
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
                            const SizedBox(height: 16),

                            // Instructional info text
                            const Text(
                              AppText.verifyNumberMessage,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.color3,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Verify button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Validate input and navigate to OTP screen
                                  _numbercontroller.validatePhoneNumber();
                                  context.goNamed(RouteNames.loginphoneotp);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.color1,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  AppText.verify,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textWhite,
                                    letterSpacing: 0.5,
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
