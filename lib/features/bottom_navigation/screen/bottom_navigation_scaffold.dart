// Bottom Navigation Scaffold
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/icon_path.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/bottom_navigation/controller/bottom_navigation_scaffold_controller.dart';

class BottomNavigationScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNavigationScaffold({super.key, required this.navigationShell});

  final List<BottomNavItem> bottomNavItems = const [
    BottomNavItem(
      activeIcon: IconPath.homeActive,
      inactiveIcon: IconPath.homeInactive,
      label: 'Home',
    ),
    BottomNavItem(
      activeIcon: IconPath.chatActive,
      inactiveIcon: IconPath.chatInactive,
      label: 'Chat',
    ),
    BottomNavItem(
      activeIcon: IconPath.usersActive,
      inactiveIcon: IconPath.usersInactive,
      label: 'Users',
    ),
    BottomNavItem(
      activeIcon: IconPath.scheduleActive,
      inactiveIcon: IconPath.scheduleInactive,
      label: 'Schedule',
    ),
    BottomNavItem(
      activeIcon: IconPath.projectsActive,
      inactiveIcon: IconPath.projectsInactive,
      label: 'Projects',
    ),
  ];

  Duration get animationDuration => const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BottomNavigationScaffoldController>();

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
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
              horizontal: Sizer.wp(16),
              vertical: Sizer.hp(8),
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

        width: Sizer.wp(60),
        height: Sizer.hp(60),
        padding: EdgeInsets.symmetric(
          horizontal: Sizer.wp(8),
          vertical: Sizer.hp(6),
        ),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(Sizer.wp(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIocnsView(isActive, item),
            SizedBox(height: Sizer.hp(4)),
            AnimatedDefaultTextStyle(
              duration: animationDuration,
              curve: Curves.easeInOut,
              style: isActive
                  ? AppTextStyle.f14W600()
                  : AppTextStyle.f14W400().copyWith(
                      color: AppColors.textSecondary,
                    ),
              child: Text(
                item.label,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer _buildIocnsView(bool isActive, BottomNavItem item) {
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
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class BottomNavItem {
  final String activeIcon;
  final String inactiveIcon;
  final String label;

  const BottomNavItem({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
  });
}
