import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

Widget customButton({
  required Color bgcolor,
  required Color brcolor,
  required String text,
  Color? textcolor,
  required VoidCallback onPressed,
  required double width,
}) {
  return SizedBox(
    width: width,

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
          color: textcolor,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}