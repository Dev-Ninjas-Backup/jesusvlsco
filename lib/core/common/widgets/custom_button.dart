import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String? imagePath;
  final Color? decorationColor;
  final Color? borderColor;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextStyle? fontFamily;
  final double? borderRadius;
  final double? horizontalPadding;
  final double? verticalPadding;
  final bool isExpanded; // ✅ new param

  const CustomButton({
    super.key,
    required this.onPressed,
    this.imagePath,
    required this.text,
    this.decorationColor,
    this.borderColor,
    this.fontSize,
    this.textColor,
    this.fontWeight,
    this.fontFamily,
    this.borderRadius,
    this.horizontalPadding,
    this.verticalPadding,
    this.isExpanded = false, // ✅ default false (so old screens won't break)
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = (fontFamily ?? GoogleFonts.inter()).copyWith(
      fontSize: fontSize ?? Sizer.wp(14),
      color: textColor ?? Colors.black,
      fontWeight: fontWeight ?? FontWeight.w400,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadius != null
            ? BorderRadius.circular(borderRadius!)
            : null,
        child: Container(
          width: isExpanded ? double.infinity : null, // ✅ full width if needed
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? Sizer.wp(16),
            vertical: verticalPadding ?? Sizer.hp(12),
          ),
          decoration: BoxDecoration(
            color: decorationColor,
            border: borderColor != null
                ? Border.all(color: borderColor!)
                : null,
            borderRadius: borderRadius != null
                ? BorderRadius.circular(borderRadius!)
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imagePath != null) ...[
                Image.asset(
                  imagePath!,
                  width: Sizer.wp(28),
                  height: Sizer.hp(28),
                ),
                SizedBox(width: Sizer.wp(8)),
              ],
              Text(text, style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}
