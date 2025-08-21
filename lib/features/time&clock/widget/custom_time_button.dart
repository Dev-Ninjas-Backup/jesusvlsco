import 'package:flutter/material.dart';

class CustomTimeButton extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final Color? bgColor;
  final Color? textcolor;
  final Color? brColor;
  final String? text;
  final double? height;
  final double? width;
  final double? size;
  final VoidCallback? onTap;

  const CustomTimeButton({
    super.key,
    this.textcolor,
    this.text,
    this.height,
    this.width,
    this.size,
    this.brColor,
    this.icon,
    this.bgColor,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: brColor ?? Colors.transparent, width: 1),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Icon(icon, size: size, color: iconColor),
            if (icon != null && text != null) SizedBox(width: 4),
            if (text != null)
              Text(text!, style: TextStyle(color: textcolor, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
