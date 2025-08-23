import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String? imagePath;

  final Widget? leadingIcon;
  final Widget? trailingIcon;

  final Color? decorationColor;
  final Color? borderColor;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextStyle? fontFamily;
  final double? borderRadius;
  final double? horizontalPadding;
  final double? verticalPadding;
  final bool isExpanded;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.imagePath,
    this.leadingIcon,
    this.trailingIcon,
    this.decorationColor,
    this.borderColor,
    this.fontSize,
    this.textColor,
    this.fontWeight,
    this.fontFamily,
    this.borderRadius,
    this.horizontalPadding,
    this.verticalPadding,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = (fontFamily ?? const TextStyle()).copyWith(
      fontSize: fontSize ?? 16,
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
          width: isExpanded ? double.infinity : null,
          height: 48,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 12,
            vertical: verticalPadding ?? 8,
          ),
          decoration: BoxDecoration(
            color: decorationColor ?? Colors.white,
            border: Border.all(color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingIcon != null) ...[
                leadingIcon!,
                const SizedBox(width: 6),
              ],
              Text(text, style: textStyle),
              if (trailingIcon != null) ...[
                const SizedBox(width: 6),
                trailingIcon!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
