import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/taskmanagement/widgets/assigned_employee_list.dart';
import 'package:jesusvlsco/features/taskmanagement/widgets/time_off_requests_section.dart';
import 'package:jesusvlsco/features/taskmanagement/widgets/approved_requests_list.dart';

class AccessScheduleScreen extends StatefulWidget {
  const AccessScheduleScreen({super.key});

  @override
  State<AccessScheduleScreen> createState() => _AccessScheduleScreenState();
}

class _AccessScheduleScreenState extends State<AccessScheduleScreen> {
  bool showApprovedSection = false;

  /// Toggle the approved requests section visibility
  void _toggleApprovedSection() {
    setState(() {
      showApprovedSection = !showApprovedSection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header with navigation
            _buildHeader(),

            // Main content area
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Sizer.hp(24)),

                    // Project overview and controls
                    _buildProjectOverview(),

                    SizedBox(height: Sizer.hp(24)),

                    // Assigned Employee Section
                    const AssignedEmployeeList(),

                    SizedBox(height: Sizer.hp(24)),

                    // Time-Off Requests Section
                    TimeOffRequestsSection(
                      onApprovePressed: _toggleApprovedSection,
                    ),

                    // Conditional Approved Requests Section
                    if (showApprovedSection) ...[
                      SizedBox(height: Sizer.hp(24)),
                      const ApprovedRequestsList(),
                    ],

                    SizedBox(height: Sizer.hp(100)), // Bottom padding
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build the header with back button, title and menu
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Sizer.wp(16),
        vertical: Sizer.hp(12),
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(169, 183, 221, 0.08),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: Sizer.wp(24),
              height: Sizer.wp(24),
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Icon(
                Icons.arrow_back_ios,
                size: Sizer.wp(16),
                color: AppColors.primary,
              ),
            ),
          ),

          // Title
          Expanded(
            child: Text(
              'Access Schedule',
              textAlign: TextAlign.center,
              style: AppTextStyle.f20W700().copyWith(color: AppColors.primary),
            ),
          ),

          // Menu button
          GestureDetector(
            onTap: () {
              // Handle menu action
            },
            child: Container(
              width: Sizer.wp(24),
              height: Sizer.wp(24),
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Icon(
                Icons.menu,
                size: Sizer.wp(20),
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build project overview section with controls
  Widget _buildProjectOverview() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project title
          Text(
            'Overview Project 1',
            style: AppTextStyle.f18W600().copyWith(color: AppColors.primary),
          ),

          SizedBox(height: Sizer.hp(24)),

          // Control buttons row
          Row(
            children: [
              // Assign button
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizer.wp(24),
                  vertical: Sizer.hp(12),
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

              SizedBox(width: Sizer.wp(12)),

              // Date button
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizer.wp(16),
                    vertical: Sizer.hp(8),
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
                      SizedBox(width: Sizer.wp(8)),
                      Text(
                        'Date',
                        style: AppTextStyle.f14W400().copyWith(
                          color: AppColors.primary,
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

              SizedBox(width: Sizer.wp(12)),

              // Refresh button
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizer.wp(20),
                    vertical: Sizer.hp(8),
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
            ],
          ),
        ],
      ),
    );
  }
}
