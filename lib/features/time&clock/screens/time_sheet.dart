import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/communication/widgets/common_button.dart';

class TimeSheet extends StatelessWidget {
  const TimeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom_appbar(title: "Time Sheet"),

body: Column(
  children: [
  Row(
    children: [
       customButton(
        text: 'Add Time',
        onPressed: () {},
        bgcolor: AppColors.primary,
        brcolor: AppColors.primary,
        textcolor: AppColors.textWhite,
        width: double.infinity,
      ),
      SizedBox(width: Sizer.wp(16)),
        customButton(
        text: 'Add Time',
        onPressed: () {},
        bgcolor: AppColors.primary,
        brcolor: AppColors.primary,
        textcolor: AppColors.textWhite,
        width: double.infinity,
      ),
    ],
  ),
  ],
)
    );
  }
}
