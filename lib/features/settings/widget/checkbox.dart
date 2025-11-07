// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? checkColor;
  final double size;
  final BorderRadius? borderRadius;

  const CustomCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.checkColor,
    this.size = 24.0,
    this.borderRadius,
  });

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = widget.activeColor ?? theme.primaryColor;
    final checkColor = widget.checkColor ?? Colors.white;
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(4.0);

    return GestureDetector(
      onTap: () {
        if (widget.onChanged != null) {
          widget.onChanged!(!widget.value);
        }
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.value ? activeColor : Colors.transparent,
          borderRadius: borderRadius,
          border: Border.all(
            color: widget.value ? activeColor : Colors.grey,
            width: 2.0,
          ),
        ),
        child: widget.value
            ? Icon(Icons.check, size: widget.size * 0.7, color: checkColor)
            : null,
      ),
    );
  }
}
