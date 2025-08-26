import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/access_schedule_controller.dart';
import 'package:intl/intl.dart';

class AssignedEmployeeList extends StatefulWidget {
  const AssignedEmployeeList({super.key});

  @override
  State<AssignedEmployeeList> createState() => _AssignedEmployeeListState();
}

class _AssignedEmployeeListState extends State<AssignedEmployeeList> {
  final ScrollController _scrollController = ScrollController();
  double _sliderValue = 0.0;
  double _maxScrollExtent = 0.0;

  @override
  void initState() {
    super.initState();
    // Listen to scroll changes to update slider
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        setState(() {
          _sliderValue = _scrollController.offset;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Update the maximum scroll extent after build
  void _updateMaxScrollExtent() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        setState(() {
          _maxScrollExtent = _scrollController.position.maxScrollExtent;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccessScheduleController>();

    // Update max scroll extent after build
    _updateMaxScrollExtent();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(14)),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section title
            Padding(
              padding: EdgeInsets.only(top: Sizer.wp(16)),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Assigned Employee',
                      style: AppTextStyle.f18W600().copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Divider
            Container(height: 1, color: const Color(0xFFE4E5F3)),
            SizedBox(height: Sizer.hp(16)),

            // Content based on API data
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

  /// Build loading state
  Widget _buildLoadingState() {
    return SizedBox(
      height: Sizer.hp(460),
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );
  }

  /// Build empty state when no shift found
  Widget _buildEmptyState() {
    return SizedBox(
      height: Sizer.hp(460),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: Sizer.wp(64),
              color: AppColors.textfield,
            ),
            SizedBox(height: Sizer.hp(16)),
            Text(
              'No shift found',
              style: AppTextStyle.f16W500().copyWith(
                color: AppColors.textfield,
              ),
            ),
            SizedBox(height: Sizer.hp(8)),
            Text(
              'No employees are assigned to this project',
              style: AppTextStyle.f14W400().copyWith(
                color: AppColors.textSecondaryGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Build employee table with original design
  Widget _buildEmployeeTable(AccessScheduleController controller) {
    return Column(
      children: [
        // Scrollable table content with your original design
        SizedBox(
          height: Sizer.hp(460),
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: Sizer.wp(824),
              child: Column(
                children: [
                  // Header row
                  _buildHeaderRow(),

                  // Employee rows
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.assignedEmployees.length,
                      itemBuilder: (context, index) {
                        final employeeData =
                            controller.assignedEmployees[index];
                        final user = employeeData.user;
                        return _buildEmployeeRow(user);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Horizontal slider for scrolling (your original design)
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizer.wp(16),
            vertical: Sizer.hp(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: FlutterSlider(
                  handlerHeight: Sizer.hp(24),
                  handlerWidth: Sizer.wp(40),
                  touchSize: 20,
                  values: [_sliderValue],
                  max: _maxScrollExtent > 0 ? _maxScrollExtent : 100,
                  min: 0,
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    _scrollController.animateTo(
                      lowerValue,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                    );
                  },
                  trackBar: FlutterSliderTrackBar(
                    activeTrackBarHeight: 12,
                    inactiveTrackBarHeight: 12,
                    activeTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.color4,
                    ),
                    inactiveTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.color4,
                    ),
                  ),
                  handler: FlutterSliderHandler(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const SizedBox.shrink(),
                  ),
                  tooltip: FlutterSliderTooltip(disabled: true),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build the header row for the table (your original design)
  Widget _buildHeaderRow() {
    return Container(
      height: Sizer.hp(52),
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(20)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _buildHeaderCell('Employee', Sizer.wp(236)),
          _buildHeaderCell('Project Name', Sizer.wp(270)),
          _buildHeaderCell('Shift', Sizer.wp(140)),
          _buildHeaderCell('Date', null), // Flexible width
        ],
      ),
    );
  }

  /// Build a header cell (your original design)
  Widget _buildHeaderCell(String title, double? width) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(12)),
      child: Text(
        title,
        style: AppTextStyle.f16W600().copyWith(color: AppColors.primary),
      ),
    );
  }

  /// Build an employee row with API data (your original design structure)
  Widget _buildEmployeeRow(dynamic user) {
    final controller = Get.find<AccessScheduleController>();

    // Get project name from API
    final projectName =
        controller.projectDetails.value?.title ?? 'Unknown Project';

    // Handle shift data - check if user has any shifts
    String shiftType = 'No Shift';
    String shiftTime = 'N/A';
    String shiftDate = 'N/A';

    if (user.shift != null && user.shift.isNotEmpty) {
      final latestShift = user.shift.first;
      shiftType = latestShift.shiftType.replaceAll('_', ' ');

      // Format time from shift
      final startTime = DateFormat('h:mma').format(latestShift.startTime);
      final endTime = DateFormat('h:mma').format(latestShift.endTime);
      shiftTime = '$startTime - $endTime';

      // Format date
      shiftDate = DateFormat('dd/MM/yyyy').format(latestShift.date);
    }

    // Get avatar URL or use fallback
    String avatarUrl =
        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80';
    if (user.profile?.profileUrl != null &&
        user.profile!.profileUrl!.isNotEmpty) {
      avatarUrl = user.profile!.profileUrl!;
    }

    return Container(
      height: Sizer.hp(80),
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(20)),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFC8CAE7), width: 1)),
      ),
      child: Row(
        children: [
          // Employee info (name and role with avatar)
          Container(
            width: Sizer.wp(236),
            padding: EdgeInsets.symmetric(horizontal: Sizer.wp(12)),
            child: Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: Sizer.wp(20),
                  backgroundImage: NetworkImage(avatarUrl),
                  onBackgroundImageError: (exception, stackTrace) {
                    // Fallback to default image on error
                  },
                ),
                SizedBox(width: Sizer.wp(16)),

                // Name and role
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user.fullName,
                        style: AppTextStyle.f16W600().copyWith(
                          color: AppColors.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        user.profile?.jobTitle?.replaceAll('_', ' ') ??
                            user.role,
                        style: AppTextStyle.f14W400().copyWith(
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

          // Project name
          Container(
            width: Sizer.wp(270),
            padding: EdgeInsets.symmetric(horizontal: Sizer.wp(12)),
            child: Text(
              projectName,
              style: AppTextStyle.f14W400().copyWith(color: AppColors.text),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Shift and time
          Container(
            width: Sizer.wp(140),
            padding: EdgeInsets.symmetric(horizontal: Sizer.wp(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  shiftType,
                  style: AppTextStyle.f14W400().copyWith(color: AppColors.text),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Sizer.hp(4)),
                Text(
                  shiftTime,
                  style: AppTextStyle.f12W400().copyWith(color: AppColors.text),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Date
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizer.wp(12)),
              child: Text(
                shiftDate,
                style: AppTextStyle.f14W400().copyWith(color: AppColors.text),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
