import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

/// TimeSheetAppBar creates a custom app bar for the time sheet screen
/// Following the Figma design with back button, title, and menu button
class TimeSheetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TimeSheetAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Container(
          height: preferredSize.height,
          padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFA9B7DD).withValues(alpha: 0.08),
                offset: const Offset(0, 4),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_buildBackButton(), _buildTitle(), _buildMenuButton()],
          ),
        ),
      ),
    );
  }

  /// Build back arrow button
  Widget _buildBackButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Get.back(),
        borderRadius: BorderRadius.circular(Sizer.wp(12)),
        child: Container(
          width: Sizer.wp(24),
          height: Sizer.wp(24),
          padding: EdgeInsets.all(Sizer.wp(2)),
          child: Icon(
            CupertinoIcons.arrow_left,
            size: Sizer.wp(20),
            color: AppColors.text,
          ),
        ),
      ),
    );
  }

  /// Build title text
  Widget _buildTitle() {
    return Text(
      title,
      style: AppTextStyle.f20W700().copyWith(
        color: AppColors.primary,
        height: 1.4,
      ),
    );
  }

  /// Build menu button
  Widget _buildMenuButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
        },
        borderRadius: BorderRadius.circular(Sizer.wp(12)),
        child: Container(
          width: Sizer.wp(24),
          height: Sizer.wp(24),
          padding: EdgeInsets.all(Sizer.wp(2)),
          child: Icon(
            CupertinoIcons.bars,
            size: Sizer.wp(20),
            color: AppColors.text,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Sizer.hp(48));
}
