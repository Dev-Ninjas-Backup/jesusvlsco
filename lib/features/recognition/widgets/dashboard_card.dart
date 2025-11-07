// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/recognition/controllers/badge_controller.dart';

class DashboardCard extends StatelessWidget {
  final DashboardItem item;

  const DashboardCard({
    super.key,
    required this.item,
    required bool isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final BadgeController badgeController = Get.put(BadgeController());
    return Container(
      height: Sizer.hp(81),
      width: Sizer.wp(81),
      decoration: BoxDecoration(
        color: AppColors.gridcard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              badgeController.selectedIndex.value ==
                  badgeController.items.indexOf(item)
              ? AppColors.primary
              : AppColors.border,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              item.icon,
              height: Sizer.hp(24),
              width: Sizer.wp(24),
            ),
            const SizedBox(height: 8),
            FittedBox(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: AppTextStyle.regular().copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primary,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardItem {
  final String icon;
  final String title;
  final Color color;

  DashboardItem({required this.icon, required this.title, required this.color});
}
