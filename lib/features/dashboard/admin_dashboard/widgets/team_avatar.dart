import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class TeamAvatar extends StatelessWidget {
  final String initial;

  const TeamAvatar({super.key, required this.initial});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizer.hp(54),
      width: Sizer.wp(55),
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withValues(alpha: 0.4),
      ),
      child: Text(
        initial,
        style: AppTextStyle.f16W600().copyWith(color: AppColors.textBlackShade),
      ),
    );
  }
}
