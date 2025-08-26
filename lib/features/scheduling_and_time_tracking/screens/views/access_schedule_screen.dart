import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/access_schedule_controller.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/assigned_employee_list.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/time_off_requests_section.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/time_sheet_appbar.dart';

class AccessScheduleScreen extends StatelessWidget {
  const AccessScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccessScheduleController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const TimeSheetAppBar(title: "Access Schedule"),
      body: SafeArea(
        child: Column(
          children: [
            // Main content area
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: Sizer.hp(24)),

                      // Project overview and controls
                      _buildProjectOverview(controller, context),

                      SizedBox(height: Sizer.hp(24)),

                      // Assigned Employee Section
                      const AssignedEmployeeList(),

                      SizedBox(height: Sizer.hp(24)),

                      // Time-Off Requests Section
                      TimeOffRequestsSection(
                        onApprovePressed: controller.onApprovePressed,
                      ),

                      // Conditional Approved Requests Section (hidden by default)
                      // Note: This section will be implemented in future when user clicks approve
                      // For now, the section is hidden as requested
                      /*
                      Obx(() {
                        if (controller.showApprovedSection.value) {
                          return Column(
                            children: [
                              SizedBox(height: Sizer.hp(24)),
                              const ApprovedRequestsList(),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      }),
                      */
                      SizedBox(height: Sizer.hp(100)), // Bottom padding
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Build project overview section with controls
  Widget _buildProjectOverview(
    AccessScheduleController controller,
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project title
          Obx(
            () => Text(
              controller.displayProjectName,
              style: AppTextStyle.f18W600().copyWith(color: AppColors.primary),
            ),
          ),

          SizedBox(height: Sizer.hp(24)),

          // Control buttons row
          Row(
            children: [
              // Assign button
              GestureDetector(
                onTap: () => controller.onAssignPressed(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizer.wp(18),
                    vertical: Sizer.hp(10),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.control_point_duplicate,
                        size: Sizer.wp(16),
                        color: Colors.white,
                      ),
                      SizedBox(width: Sizer.wp(8)),
                      Text(
                        'Assign',
                        style: AppTextStyle.f16W500().copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: Sizer.wp(12)),

              // Date button
              Expanded(
                child: GestureDetector(
                  onTap: controller.onDatePressed,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizer.wp(10),
                      vertical: Sizer.hp(10),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: Sizer.wp(16),
                          color: AppColors.primary,
                        ),
                        SizedBox(width: Sizer.wp(4)),
                        Obx(
                          () => Text(
                            DateFormat(
                              'MMM dd',
                            ).format(controller.selectedDate.value),
                            style: AppTextStyle.f14W400().copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        SizedBox(width: Sizer.wp(8)),
                        Icon(
                          Icons.arrow_drop_down,
                          size: Sizer.wp(16),
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(width: Sizer.wp(12)),

              // Refresh button
              Expanded(
                child: GestureDetector(
                  onTap: controller.onRefreshPressed,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizer.wp(20),
                      vertical: Sizer.hp(7),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Refresh',
                        style: AppTextStyle.f16W500().copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
