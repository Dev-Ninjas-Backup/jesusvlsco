// ignore_for_file: public_member_api_docs, sort_constructors_first
// Admin Bottom Navigation Scaffold
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/icon_path.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/bottom_navigation/controller/admin_bottom_navigation_scaffold_controller.dart';

class AdminBottomNavigationScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  AdminBottomNavigationScaffold({super.key, required this.navigationShell});

  final List<AdminBottomNavItem> bottomNavItems = [
    AdminBottomNavItem(
      activeIcon: IconPath.homeActive,
      inactiveIcon: IconPath.homeInactive,
      label: 'Home',
    ),
    AdminBottomNavItem(
      activeIcon: IconPath.chatActive,
      inactiveIcon: IconPath.chatInactive,
      label: 'Chat',
    ),
    AdminBottomNavItem(
      activeIcon: IconPath.usersActive,
      inactiveIcon: IconPath.usersInactive,
      label: 'Users',
    ),
    AdminBottomNavItem(
      activeIcon: IconPath.scheduleActive,
      inactiveIcon: IconPath.scheduleInactive,
      label: 'Schedule',
    ),
    AdminBottomNavItem(
      activeIcon: IconPath.projectsActive,
      inactiveIcon: IconPath.projectsInactive,
      label: 'Projects',
    ),
  ];

  Duration get animationDuration => const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    Get.find<AdminBottomNavigationScaffoldController>();

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Sizer.wp(12)),
            topRight: Radius.circular(Sizer.wp(12)),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.textSecondary.withOpacity(0.1),
              blurRadius: Sizer.wp(10),
              offset: Offset(0, -Sizer.hp(2)),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizer.wp(12),
              vertical: Sizer.hp(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                bottomNavItems.length,
                (index) => _buildNavItem(
                  context,
                  index,
                  navigationShell.currentIndex == index,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, bool isActive) {
    final item = bottomNavItems[index];

    return GestureDetector(
      onTap: () => _onTap(context, index),
      child: AnimatedContainer(
        duration: animationDuration,
        curve: Curves.easeInOut,
        width: Sizer.wp(73),
        height: Sizer.hp(65),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(Sizer.wp(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIconsView(isActive, item),
            SizedBox(height: Sizer.hp(4)),
            AnimatedDefaultTextStyle(
              duration: animationDuration,
              curve: Curves.easeInOut,
              style: isActive
                  ? AppTextStyle.f14W700()
                  : AppTextStyle.f14W400().copyWith(
                      color: AppColors.textSecondary,
                    ),
              child: Text(item.label),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer _buildIconsView(bool isActive, AdminBottomNavItem item) {
    return AnimatedContainer(
      duration: animationDuration,
      curve: Curves.easeInOut,
      child: Image.asset(
        isActive ? item.activeIcon : item.inactiveIcon,
        width: Sizer.wp(24),
        height: Sizer.hp(24),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    // Don't navigate if already on the same tab
    if (index == navigationShell.currentIndex) {
      return; // Just return, don't do anything
    }

    navigationShell.goBranch(index, initialLocation: false);
  }
}

class AdminBottomNavItem {
  final String activeIcon;
  final String inactiveIcon;
  final String label;

  const AdminBottomNavItem({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
  });
}
