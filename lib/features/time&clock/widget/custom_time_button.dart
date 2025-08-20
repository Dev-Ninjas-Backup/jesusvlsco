import 'package:flutter/material.dart';

class CustomTimeButton extends StatelessWidget {
  final IconData? icon;
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: brColor ?? Colors.transparent, width: 2),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Icon(icon, size: size),
            if (icon != null && text != null) SizedBox(width: 4),
            if (text != null) Text(text!, style: TextStyle(color: textcolor)),
          ],
        ),
      ),
    );
  }
}
