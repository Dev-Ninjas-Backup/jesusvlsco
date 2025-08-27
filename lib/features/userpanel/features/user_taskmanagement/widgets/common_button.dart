import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class CustomButton1 extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onPressed;
  final double width;

  const CustomButton1({
    super.key,
    required this.color,
    required this.text,
    required this.onPressed,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: Sizer.hp(48),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
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
}