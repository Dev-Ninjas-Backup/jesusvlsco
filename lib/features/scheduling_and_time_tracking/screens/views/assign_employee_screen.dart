import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/assign_employee_controller.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/time_sheet_appbar.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/employee_card_widget.dart';

class AssignEmployeeScreen extends StatelessWidget {
  const AssignEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AssignEmployeeController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const TimeSheetAppBar(title: "Assigne Employee"),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: Sizer.hp(24)),
            // Project title and publish button
            _buildProjectHeader(controller),

            SizedBox(height: Sizer.hp(16)),

            // Filter and action buttons
            _buildActionButtons(controller, context),

            SizedBox(height: Sizer.hp(24)),

            // Employee availability section
            _buildEmployeeAvailabilityHeader(controller),

            SizedBox(height: Sizer.hp(16)),

            // Search bar
            _buildSearchBar(controller),

            SizedBox(height: Sizer.hp(16)),

            // Employee list
            Expanded(child: _buildEmployeeList(controller)),
          ],
        ),
      ),
    );
  }

  /// Build project header with title and publish button
  Widget _buildProjectHeader(AssignEmployeeController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Shift Scheduling Project 1',
              style: AppTextStyle.f18W600().copyWith(
                color: AppColors.primary,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(width: Sizer.wp(16)),
          GestureDetector(
            onTap: controller.onPublishPressed,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Sizer.wp(12),
                vertical: Sizer.hp(8),
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.notifications_active,
                    size: Sizer.wp(20),
                    color: Colors.white,
                  ),
                  SizedBox(width: Sizer.wp(8)),
                  Text(
                    'Publish',
                    style: AppTextStyle.f16W500().copyWith(
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds action buttons row (filter, date, export, more)
  Widget _buildActionButtons(
    AssignEmployeeController controller,
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
      child: Row(
        children: [
          // Filter button
          GestureDetector(
            onTap: () => controller.onFilterPressed(context),
            child: Container(
              height: Sizer.hp(40),
              padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Icon(
                  Icons.filter_list,
                  size: Sizer.wp(20),
                  color: AppColors.primary,
                ),
              ),
            ),
          ),

          SizedBox(width: Sizer.wp(16)),

          // Date button
          Expanded(
            child: GestureDetector(
              onTap: controller.onDatePressed,
              child: Container(
                height: Sizer.hp(40),
                padding: EdgeInsets.symmetric(horizontal: Sizer.wp(6)),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: Sizer.wp(20),
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
                          height: 1.45,
                        ),
                      ),
                    ),
                    SizedBox(width: Sizer.wp(8)),
                    Icon(
                      Icons.arrow_drop_down,
                      size: Sizer.wp(20),
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(width: Sizer.wp(16)),

          // Export button
          GestureDetector(
            onTap: controller.onExportPressed,
            child: Container(
              height: Sizer.hp(40),
              padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_download_outlined,
                    size: Sizer.wp(20),
                    color: AppColors.primary,
                  ),
                  SizedBox(width: Sizer.wp(8)),
                  Text(
                    'Export',
                    style: AppTextStyle.f14W400().copyWith(
                      color: AppColors.primary,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: Sizer.wp(16)),

          // More button
          GestureDetector(
            onTap: controller.onMorePressed,
            child: Container(
              height: Sizer.hp(40),
              width: Sizer.hp(40),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Icon(
                  Icons.more_vert,
                  size: Sizer.wp(20),
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build employee availability header
  Widget _buildEmployeeAvailabilityHeader(AssignEmployeeController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Employee Availability',
            style: AppTextStyle.f16W600().copyWith(
              color: AppColors.primary,
              height: 1.5,
            ),
          ),
          Obx(
            () => Container(
              padding: EdgeInsets.symmetric(
                horizontal: Sizer.wp(12),
                vertical: Sizer.hp(6),
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFD9F0E4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '${controller.activeEmployeesCount.value} active',
                style: AppTextStyle.f14W400().copyWith(
                  color: const Color(0xFF003317),
                  height: 1.45,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build search bar
  Widget _buildSearchBar(AssignEmployeeController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
      child: Container(
        height: Sizer.hp(48),
        padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFC8CAE7)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: controller.updateSearchText,
                style: AppTextStyle.f14W400().copyWith(
                  color: AppColors.text,
                  height: 1.45,
                ),
                decoration: InputDecoration(
                  hintText: 'Search Employee',
                  hintStyle: AppTextStyle.f14W400().copyWith(
                    color: const Color(0xFF949494),
                    height: 1.45,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            Icon(
              Icons.search,
              size: Sizer.wp(20),
              color: const Color(0xFF949494),
            ),
          ],
        ),
      ),
    );
  }

  /// Build employee list
  Widget _buildEmployeeList(AssignEmployeeController controller) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        );
      }

      final employees = controller.filteredEmployees;

      if (employees.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_off_outlined,
                size: Sizer.wp(64),
                color: const Color(0xFF949494),
              ),
              SizedBox(height: Sizer.hp(16)),
              Text(
                'No employees found',
                style: AppTextStyle.f16W500().copyWith(
                  color: const Color(0xFF949494),
                  height: 1.5,
                ),
              ),
            ],
          ),
        );
      }

      return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
        itemCount: employees.length,
        separatorBuilder: (context, index) => Container(
          height: 1,
          margin: EdgeInsets.symmetric(vertical: Sizer.hp(16)),
          color: const Color(0xFFE5E5E5),
        ),
        itemBuilder: (context, index) {
          final employee = employees[index];
          return EmployeeCardWidget(
            employee: employee,
            onSchedulePressed: (scheduleIndex) =>
                controller.onSchedulePressed(employee, scheduleIndex, context),
          );
        },
      );
    });
  }
}
