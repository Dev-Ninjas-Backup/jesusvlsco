import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/core/utils/helpers/spacing_helper.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? searchIcon;
  final String? notificationIcon;
  final String? menuIcon;
  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onMenuTap;

  const DashboardAppBar({
    super.key,
    this.searchIcon,
    this.notificationIcon,
    this.menuIcon,
    this.onSearchTap,
    this.onNotificationTap,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryBackground,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: Sizer.wp(16)),
        child: Text(
          'Dashboard',
          style: AppTextStyle.f18W600().copyWith(color: AppColors.primary),
        ),
      ),
      leadingWidth: Sizer.wp(120),
      actions: [
        GestureDetector(
          onTap: onSearchTap ?? () {},
          child: Image.asset(
            'assets/icons/search.png',
            width: Sizer.wp(24),
            height: Sizer.hp(24),
          ),
        ),

        SpacingHelper.w12(),
        GestureDetector(
          onTap: onNotificationTap ?? () {},
          child: Image.asset(
            'assets/icons/notification.png',
            width: Sizer.wp(24),
            height: Sizer.hp(24),
          ),
        ),
        SpacingHelper.w12(),
        GestureDetector(
          onTap: onMenuTap ?? () {},
          child: Image.asset(
            'assets/icons/menu.png',
            width: Sizer.wp(24),
            height: Sizer.hp(24),
          ),
        ),
        SpacingHelper.w16(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
