import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/icon_path.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/bottom_navigation/controller/admin_bottom_navigation_scaffold_controller.dart';
import 'package:jesusvlsco/features/dashboard/admin_dashboard/screens/admin_dashboard_screen.dart';
import 'package:jesusvlsco/features/communication/screens/communication_dashboard.dart';
import 'package:jesusvlsco/features/user/screen/employee_list_screen.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/views/shift_scheduling_screen.dart';
import 'package:jesusvlsco/features/taskmanagement/screens/taskmanagement_dashboard.dart';

class AdminBottomNavigationScaffold extends StatelessWidget {
  AdminBottomNavigationScaffold({super.key});

  final controller = Get.put(AdminBottomNavigationController());

  final List<AdminBottomNavItem> bottomNavItems = const [
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

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return AdminDashboardScreen();
      case 1:
        return const CommunicationDashboard();
      case 2:
        return EmployeeListScreen();
      case 3:
        return TimeSheetScreen();
      case 4:
        return const TaskmanagementDashboard();
      default:
        return AdminDashboardScreen();
    }
  }

  Duration get animationDuration => const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _getPage(controller.currentIndex.value)),
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
                    context,
                    index,
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

  Widget _buildNavItem(BuildContext context, int index, bool isActive) {
    final item = bottomNavItems[index];

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
