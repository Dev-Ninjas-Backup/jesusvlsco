import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

/// BottomNavigationWidget creates a custom bottom navigation bar
/// Following the Figma design with 5 navigation items
class BottomNavigationWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const BottomNavigationWidget({
    super.key,
    this.currentIndex = 3, // Schedule is selected by default
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Sizer.wp(12)),
          topRight: Radius.circular(Sizer.wp(12)),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA9B7DD).withValues(alpha: 0.08),
            offset: const Offset(0, -4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizer.wp(12),
              vertical: Sizer.hp(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: 'Home',
                ),
                _buildNavItem(
                  index: 1,
                  icon: Icons.chat_bubble_outline,
                  activeIcon: Icons.chat_bubble,
                  label: 'Chat',
                ),
                _buildNavItem(
                  index: 2,
                  icon: Icons.people_outline,
                  activeIcon: Icons.people,
                  label: 'Users',
                ),
                _buildNavItem(
                  index: 3,
                  icon: Icons.calendar_today_outlined,
                  activeIcon: Icons.calendar_today,
                  label: 'Schedule',
                  isActive: true,
                ),
                _buildNavItem(
                  index: 4,
                  icon: Icons.folder_open_outlined,
                  activeIcon: Icons.folder_open,
                  label: 'Projects',
                ),
              ],
            ),
          ),
          // Bottom slider indicator
          Container(
            height: Sizer.hp(16),
            alignment: Alignment.center,
            child: Container(
              width: Sizer.wp(120),
              height: Sizer.hp(4),
              decoration: BoxDecoration(
                color: AppColors.quill,
                borderRadius: BorderRadius.circular(Sizer.wp(99)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build individual navigation item
  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    bool isActive = false,
  }) {
    final bool selected = isActive || currentIndex == index;

    return GestureDetector(
      onTap: () => onTap?.call(index),
      child: Container(
        padding: EdgeInsets.all(Sizer.wp(8)),
        decoration: BoxDecoration(
          color: selected ? AppColors.quill : Colors.transparent,
          borderRadius: BorderRadius.circular(Sizer.wp(12)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? activeIcon : icon,
              size: Sizer.wp(24),
              color: selected ? AppColors.primary : AppColors.textfield,
            ),
            SizedBox(height: Sizer.hp(4)),
            Text(
              label,
              style: AppTextStyle.f14W400().copyWith(
                color: selected ? AppColors.primary : AppColors.textfield,
                height: 1.5,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
