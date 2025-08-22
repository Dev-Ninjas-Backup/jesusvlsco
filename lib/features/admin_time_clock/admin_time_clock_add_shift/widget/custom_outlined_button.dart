import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  final bool? prefixIcon;
  final String? buttonText;
  final bool? isIcon;
  final IconData? iconData;
  final Color? bgColor;
  final Color? fgColor;
  final VoidCallback onPressedAction;
  const CustomOutlinedButton({
    super.key,
    this.buttonText,
    this.isIcon,
    this.iconData, this.bgColor, this.fgColor, required this.onPressedAction, this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressedAction,
      child: Row(
        children: [
          if(prefixIcon == true)...[
            CircleAvatar(
              radius: 16,
              child: Icon(Icons.person),
            ),
            SizedBox(width: 5,)
          ],
          Expanded(
            child: Text(
              buttonText ?? "",
              //"19/06/2025",
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (isIcon == true) ...[Icon(iconData)],
        ],
      ),
    );
  }
}