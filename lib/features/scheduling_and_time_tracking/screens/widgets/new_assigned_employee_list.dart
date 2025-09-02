import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/access_schedule_controller.dart';

class AssignedEmployeeList extends StatelessWidget {
  const AssignedEmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccessScheduleController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Padding(
              padding: EdgeInsets.all(Sizer.wp(16)),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Assigned Employees',
                      style: AppTextStyle.f18W600().copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Obx(
                    () => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizer.wp(12),
                        vertical: Sizer.hp(4),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${controller.assignedEmployeesCount}',
                        style: AppTextStyle.f14W600().copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Divider
            Container(
              height: 1,
              color: const Color(0xFFE4E5F3),
              margin: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
            ),

            // Employee list content
            Obx(() {
              if (controller.isLoading.value) {
                return _buildLoadingState();
              }

              if (controller.assignedEmployees.isEmpty) {
                return _buildEmptyState();
              }

              return _buildEmployeeTable(controller);
            }),
          ],
        ),
      ),
    );
  }

  /// Build loading state with shimmer effect
  Widget _buildLoadingState() {
    return Container(
      height: Sizer.hp(300),
      padding: EdgeInsets.all(Sizer.wp(16)),
      child: Column(
        children: [
          // Header shimmer
          Container(
            height: Sizer.hp(40),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(height: Sizer.hp(12)),

          // Employee rows shimmer
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  height: Sizer.hp(60),
                  margin: EdgeInsets.only(bottom: Sizer.hp(8)),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Build empty state
  Widget _buildEmptyState() {
    return Container(
      height: Sizer.hp(200),
      padding: EdgeInsets.all(Sizer.wp(32)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: Sizer.wp(48),
            color: AppColors.textfield,
          ),
          SizedBox(height: Sizer.hp(16)),
          Text(
            'No employees assigned',
            style: AppTextStyle.f16W500().copyWith(color: AppColors.textfield),
          ),
          SizedBox(height: Sizer.hp(8)),
          Text(
            'Assign employees to see them here',
            style: AppTextStyle.f14W400().copyWith(
              color: AppColors.textSecondaryGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Build the employee table with proper scrolling
  Widget _buildEmployeeTable(AccessScheduleController controller) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: Sizer.hp(400), // Set maximum height
      ),
      child: Column(
        children: [
          // Table header
          Container(
            height: Sizer.hp(48),
            padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Employee',
                    style: AppTextStyle.f14W600().copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Role',
                    style: AppTextStyle.f14W600().copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Department',
                    style: AppTextStyle.f14W600().copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Contact',
                    style: AppTextStyle.f14W600().copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Employee list with dynamic height
          Flexible(
            child: ListView.builder(
              shrinkWrap:
                  true, // Important: allows the list to take only needed space
              physics:
                  const AlwaysScrollableScrollPhysics(), // Allow scrolling when needed
              itemCount: controller.assignedEmployees.length,
              itemBuilder: (context, index) {
                final employeeData = controller.assignedEmployees[index];
                final user = employeeData.user;
                return _buildEmployeeRow(user, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Build individual employee row
  Widget _buildEmployeeRow(dynamic user, int index) {
    final isEven = index % 2 == 0;

    return Container(
      height: Sizer.hp(72),
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
      decoration: BoxDecoration(
        color: isEven ? Colors.white : AppColors.background,
        border: Border(
          bottom: BorderSide(color: const Color(0xFFE4E5F3), width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // Employee info (avatar + name)
          Expanded(
            flex: 3,
            child: Row(
              children: [
                // Avatar
                Container(
                  width: Sizer.wp(40),
                  height: Sizer.wp(40),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.1),
                  ),
                  child: user.profile?.profileUrl != null
                      ? ClipOval(
                          child: Image.network(
                            user.profile!.profileUrl!,
                            width: Sizer.wp(40),
                            height: Sizer.wp(40),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildAvatarFallback(user.fullName),
                          ),
                        )
                      : _buildAvatarFallback(user.fullName),
                ),
                SizedBox(width: Sizer.wp(12)),

                // Name and email
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user.fullName,
                        style: AppTextStyle.f14W600().copyWith(
                          color: AppColors.text,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Sizer.hp(2)),
                      Text(
                        user.email,
                        style: AppTextStyle.f12W400().copyWith(
                          color: AppColors.textSecondaryGrey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Role
          Expanded(
            flex: 2,
            child: Text(
              user.role.replaceAll('_', ' '),
              style: AppTextStyle.f14W500().copyWith(color: AppColors.text),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Department
          Expanded(
            flex: 2,
            child: Text(
              user.profile?.department ?? 'N/A',
              style: AppTextStyle.f12W400().copyWith(color: AppColors.text),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Contact
          Expanded(
            flex: 2,
            child: Text(
              user.phone,
              style: AppTextStyle.f12W400().copyWith(color: AppColors.text),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// Build avatar fallback with initials
  Widget _buildAvatarFallback(String name) {
    final initials = _getInitials(name);
    return Container(
      width: Sizer.wp(40),
      height: Sizer.wp(40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary,
      ),
      child: Center(
        child: Text(
          initials,
          style: AppTextStyle.f14W600().copyWith(color: Colors.white),
        ),
      ),
    );
  }

  /// Get initials from full name
  String _getInitials(String name) {
    if (name.isEmpty) return 'U';

    final names = name.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }
}
