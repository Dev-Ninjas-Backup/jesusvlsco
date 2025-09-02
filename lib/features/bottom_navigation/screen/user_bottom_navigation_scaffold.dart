// Bottom Navigation Scaffold
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/icon_path.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/assign_employee/views/user_assign_employee_screen.dart';
import 'package:jesusvlsco/features/bottom_navigation/controller/bottom_navigation_scaffold_controller.dart';
import 'package:jesusvlsco/features/dashboard/admin_dashboard/screens/user_dashboard_screen.dart';
import 'package:jesusvlsco/features/user_profile/views/user_profile_screen.dart';
import 'package:jesusvlsco/features/userpanel/features/user_taskmanagement/screens/taskmanagement_dashboard.dart';
import '../../user/screen/user_communication_screen.dart';

class UserBottomNavigationScaffold extends StatelessWidget {
  const UserBottomNavigationScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavigationController());

    Widget getPage(int index) {
      switch (index) {
        case 0:
          return UserDashboardScreen();
        case 1:
          return UserCommunicationScreen();
        case 2:
          return UserProfileScreen();
        case 3:
          // return TimeSheetScreen();
          return AssignEmployeeScreen();
        case 4:
          return UserTaskmanagementDashboard();
        default:
          return Container(color: Colors.purpleAccent);
      }
    }

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

    return Scaffold(
      body: Obx(() => getPage(controller.currentIndex.value)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Sizer.wp(12)),
            topRight: Radius.circular(Sizer.wp(12)),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.textSecondary.withValues(alpha: 0.1),
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
                (index) => Obx(
                  () => _buildNavItem(
                    controller,
                    index,
                    bottomNavItems[index],
                    controller.currentIndex.value == index,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BottomNavigationController controller,
    int index,
    BottomNavItem item,
    bool isActive,
  ) {
    const Duration animationDuration = Duration(milliseconds: 200);

    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: AnimatedContainer(
        duration: animationDuration,
        curve: Curves.easeInOut,
        width: Sizer.wp(73),
        height: Sizer.hp(65),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(Sizer.wp(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: animationDuration,
              curve: Curves.easeInOut,
              child: Image.asset(
                isActive ? item.activeIcon : item.inactiveIcon,
                width: Sizer.wp(24),
                height: Sizer.hp(24),
              ),
            ),
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
