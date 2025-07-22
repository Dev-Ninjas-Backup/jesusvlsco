// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class DashboardCard extends StatelessWidget {
  final DashboardItem item;

  const DashboardCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizer.hp(81),
      width: Sizer.wp(81),
      decoration: BoxDecoration(
        color: AppColors.gridcard,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
            Text(
              item.icon,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 8),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style:  AppTextStyle.regular().copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: AppColors.text,
                height: 1.2,
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

  DashboardItem({
    required this.icon,
    required this.title,
    required this.color,
  });
}
