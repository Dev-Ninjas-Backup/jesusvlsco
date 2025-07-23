import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class CommonDivider extends StatelessWidget {
  final Color? color;
  final double? thickness;
  final double? height;

  const CommonDivider({super.key, this.color, this.thickness, this.height});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? AppColors.dividerColor,
      thickness: thickness ?? 1,
      height: height ?? Sizer.hp(16),
    );
  }
}
