// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Widget CustomSurveyButton({
    final Icon? iconData,
    final String? textTitle,
    final Color? bgColor,
    final Color? fgColor,
    final Color? borderColor,
    final MainAxisAlignment? mainAxisAlignment,
    final VoidCallback? onPressedAction,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor ?? Colors.white,
        foregroundColor: fgColor ?? Color(0XFF484848),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: borderColor?? Colors.grey.shade300),
        ),
      ),
      onPressed: onPressedAction,
      child: Row(
        spacing: 8,
        mainAxisAlignment:mainAxisAlignment?? MainAxisAlignment.start,
        children: [
          if (iconData != null) iconData,
          Text(textTitle ?? "Description",),
        ],
      ),
    );
  }