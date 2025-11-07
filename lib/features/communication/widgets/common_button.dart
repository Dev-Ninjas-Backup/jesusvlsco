import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

Widget customButton({
  required Color bgcolor,
  required Color brcolor,
  required String text,
  required VoidCallback onPressed,
  required double width, required Color textcolor,
}) {
  return SizedBox(
    width: width,
    height: Sizer.hp(40),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgcolor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: brcolor),
          borderRadius: BorderRadius.circular(Sizer.wp(8)),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTextStyle.regular().copyWith(
          fontSize: Sizer.wp(16),
          color: AppColors.textWhite,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}