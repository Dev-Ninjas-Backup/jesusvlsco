import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/common/widgets/custom_button.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/core/utils/helpers/spacing_helper.dart';
import 'package:jesusvlsco/features/dashboard/admin_dashboard/controllers/dashboard_controller.dart';
import 'package:jesusvlsco/features/dashboard/admin_dashboard/widgets/dashboard_appbar.dart';
import 'package:jesusvlsco/features/dashboard/admin_dashboard/widgets/admin_drawer.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_screen/screen/survey_and_poll_screen.dart';
import 'package:jesusvlsco/features/taskmanagement/screens/add_task.dart';
import 'package:jesusvlsco/features/time_off_request/time_off_request_project_overView_screen/screen/time_off_request_project_overview_screen.dart';
import '../../../announcements/admin_announcement/screens/add_announcement.dart';
import '../../../user/screen/add_user_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  AdminDashboardScreen({super.key});
  final controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      appBar: DashboardAppBar(
        onSearchTap: () {},
        onNotificationTap: () {},
        onMenuTap: () {
          // context.pushNamed(RouteNames.drawer);
          Get.to(AdminDrawer());
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizer.wp(16)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildButtonView(),
              SpacingHelper.h24(),
              _buildSurveyView(),
              SpacingHelper.h24(),
              _buildRecentChatView(),
              SpacingHelper.h24(),
              _buildAssignedEmployeesView(),
              SpacingHelper.h24(),
              _buildTimeOffRequestsListView(),
              SpacingHelper.h24(),
              _buildRecognitionView(),
              SpacingHelper.h24(),
              _buildShiftNotificationView(),
              SpacingHelper.h24(),

              _buildMapLocationView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapLocationView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMapTitleView(),
        Divider(
          color: AppColors.dividerColor,
          thickness: 1,
          height: Sizer.hp(16),
        ),
        SpacingHelper.h16(),
        Container(
          padding: EdgeInsets.all(Sizer.wp(16)),
          decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.circular(Sizer.wp(12)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFA9B7DD).withValues(alpha: 0.08),
                offset: const Offset(0, 4),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Sizer.wp(12)),
                child: SizedBox(
                  height: Sizer.hp(200),
                  width: double.infinity,
                  child: Obx(
                    () => GoogleMap(
                      onMapCreated: controller.onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: controller.initialCameraPosition,
                        zoom: 15,
                      ),
                      // ignore: invalid_use_of_protected_member
                      markers: controller.markers.value,
                      myLocationEnabled: false,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                    ),
                  ),
                ),
              ),
              SpacingHelper.h12(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLegendItem(
                    'assets/icons/map_green_marker.png',
                    'Location 1',
                  ),
                  _buildLegendItem(
                    'assets/icons/map_yellow_marker.png',
                    'Location 2',
                  ),
                  _buildLegendItem(
                    'assets/icons/map_red_marker.png',
                    'Expand Map',
                    () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(
    String assetPath,
    String label, [
    VoidCallback? onTap,
  ]) {
    final content = Row(
      children: [
        Image.asset(assetPath, width: Sizer.wp(20), height: Sizer.wp(20)),
        SpacingHelper.w8(),
        Flexible(
          child: Text(
            label,
            style: AppTextStyle.f14W400().copyWith(
              color: AppColors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );

    return Expanded(
      child: onTap != null
          ? GestureDetector(
              onTap: onTap,
              behavior: HitTestBehavior.opaque,
              child: content,
            )
          : content,
    );
  }

  Widget _buildMapTitleView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Map Location',
          style: AppTextStyle.f18W600().copyWith(color: AppColors.primary),
        ),
        SizedBox(),
      ],
    );
  }

  Widget _buildShiftNotificationView() {
    return Column(
      children: [
        _buildShiftNotificationTitleView(),
        Divider(
          color: AppColors.dividerColor,
          thickness: 1,
          height: Sizer.hp(16),
        ),
        SpacingHelper.h16(),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.shiftNotifications.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                _buildShiftNotificationCard(
                  controller.shiftNotifications[index],
                ),
                if (index < controller.shiftNotifications.length - 1)
                  SpacingHelper.h12(),
              ],
            );
          },
        ),
        SpacingHelper.h16(),
      ],
    );
  }

  Widget _buildShiftNotificationCard(Map<String, String> notification) {
    return Container(
      padding: EdgeInsets.all(Sizer.wp(16)),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.circular(Sizer.wp(12)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFA9B7DD).withValues(alpha: 0.08),
            offset: Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Sizer.wp(40),
            height: Sizer.wp(40),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Sizer.wp(8)),
            ),
            child: Center(
              child: Image.asset(
                notification['icon']!,
                width: Sizer.wp(24),
                height: Sizer.hp(24),
              ),
            ),
          ),

          SpacingHelper.w16(),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  notification['title']!,
                  style: AppTextStyle.f16W600().copyWith(
                    color: AppColors.textBlackShade,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SpacingHelper.h4(),
                Text(
                  notification['subtitle']!,
                  style: AppTextStyle.f14W400().copyWith(
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SpacingHelper.h8(),
                Text(
                  notification['time']!,
                  style: AppTextStyle.f14W400().copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftNotificationTitleView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Shift Notifications',
          style: AppTextStyle.f18W600().copyWith(color: AppColors.primary),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'View all',
            style: AppTextStyle.f14W400().copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildRecognitionView() {
    return Column(
      children: [
        _buildRecognitionTitleView(),
        Divider(
          color: AppColors.dividerColor,
          thickness: 1,
          height: Sizer.hp(16),
        ),
        SpacingHelper.h16(),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.recognitionList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                _buildRecognitionCard(controller.recognitionList[index]),
                if (index < controller.recognitionList.length - 1)
                  SpacingHelper.h12(),
              ],
            );
          },
        ),

        SpacingHelper.h16(),
      ],
    );
  }

  Widget _buildRecognitionCard(Map<String, String> recognition) {
    return Container(
      padding: EdgeInsets.all(Sizer.wp(16)),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.circular(Sizer.wp(12)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFA9B7DD).withValues(alpha: 0.08),
            offset: Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: Sizer.wp(24),
            backgroundImage: AssetImage(recognition['profileImage']!),
            backgroundColor: AppColors.dividerColor,
          ),

          SpacingHelper.w8(),

          Expanded(
            flex: 2,
            child: Text(
              recognition['name']!,
              style: AppTextStyle.f16W600().copyWith(color: AppColors.primary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          SizedBox(
            width: Sizer.wp(134),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  recognition['recognitionIcon']!,
                  width: Sizer.wp(20),
                  height: Sizer.hp(20),
                ),
                SpacingHelper.w4(),
                Flexible(
                  child: Text(
                    recognition['recognition']!,
                    style: AppTextStyle.f14W400().copyWith(
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          SpacingHelper.w8(),

          // Arrow - Fixed width
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.arrow_forward_ios,
              size: Sizer.wp(16),
              color: AppColors.textSecondaryGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecognitionTitleView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recognition',
          style: AppTextStyle.f18W600().copyWith(color: AppColors.primary),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'View all',
            style: AppTextStyle.f14W400().copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeOffRequestsListView() {
    return Column(
      children: [
        _buildTimeOffRequestsTitleView(),
        Divider(
          color: AppColors.dividerColor,
          thickness: 1,
          height: Sizer.hp(16),
        ),
        SpacingHelper.h12(),
        Container(
          padding: EdgeInsets.all(Sizer.wp(16)),
          decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.circular(Sizer.wp(12)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFA9B7DD).withValues(alpha: 0.08),
                offset: Offset(0, 4),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.requestList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  _buildRequestCard(controller.requestList[index]),
                  if (index < controller.requestList.length - 1)
                    SpacingHelper.h12(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request) {
    String status = request['status'];

    return Container(
      padding: EdgeInsets.all(Sizer.wp(16)),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(Sizer.wp(12)),
        border: Border.all(color: AppColors.requestListItemColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                request['name'],
                style: AppTextStyle.f16W600().copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                status,
                style: AppTextStyle.f14W400().copyWith(
                  color: controller.isPending(status)
                      ? AppColors.warning
                      : AppColors.progressIndicatorColor,
                ),
              ),
            ],
          ),

          SpacingHelper.h8(),

          Text(
            '${request['requestType']}  ${request['days']}',
            style: AppTextStyle.f14W400().copyWith(
              color: AppColors.textSecondaryGrey,
            ),
          ),
          SpacingHelper.h4(),
          Text(
            '${request['startDate']} - ${request['endDate']}',
            style: AppTextStyle.f14W400().copyWith(
              color: AppColors.textSecondaryGrey,
            ),
          ),

          controller.isPending(status)
              ? Column(
                  children: [
                    SpacingHelper.h12(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomButton(
                              onPressed: () {},
                              text: 'Approve',
                              decorationColor: AppColors.progressIndicatorColor,
                              textColor: Colors.white,
                              fontSize: Sizer.wp(16),
                              fontWeight: FontWeight.w500,
                              borderRadius: Sizer.wp(8),
                            ),
                            SpacingHelper.w8(),

                            CustomButton(
                              onPressed: () {},
                              text: 'Decline',
                              borderColor: AppColors.error,
                              textColor: AppColors.error,
                              fontSize: Sizer.wp(16),
                              fontWeight: FontWeight.w500,
                              borderRadius: Sizer.wp(8),
                            ),
                          ],
                        ),
                        SizedBox(),
                      ],
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildTimeOffRequestsTitleView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Time-Off Requests',
          style: AppTextStyle.f18W600().copyWith(color: AppColors.primary),
        ),
        GestureDetector(
          onTap: () {
            // Navigate to Time-Off Requests List
            Get.to(TimeOffRequestProjectOverviewScreen());
          },
          child: Text(
            'View all',
            style: AppTextStyle.f14W400().copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildAssignedEmployeesView() {
    return Column(
      children: [
        _buildAssignedEmployeesTitleView(),
        Divider(
          color: AppColors.dividerColor,
          thickness: 1,
          height: Sizer.hp(16),
        ),
        SpacingHelper.h16(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.assignedEmployees.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                _buildEmployeeCard(controller.assignedEmployees[index]),
                if (index < controller.assignedEmployees.length - 1)
                  SpacingHelper.h12(),
              ],
            );
          },
        ),
        SpacingHelper.h16(),
      ],
    );
  }

  Widget _buildEmployeeCard(Map<String, String> employee) {
    return Container(
      padding: EdgeInsets.all(Sizer.wp(16)),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.circular(Sizer.wp(12)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFA9B7DD).withValues(alpha: 0.08),
            offset: Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: Sizer.wp(24),
            backgroundImage: AssetImage(employee['profileImage']!),
            backgroundColor: AppColors.dividerColor,
          ),
          SpacingHelper.w12(),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee['name']!,
                  style: AppTextStyle.f16W600().copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SpacingHelper.h4(),
                Text(
                  '${employee['project']!} • ${employee['shift']!}',
                  style: AppTextStyle.f14W400().copyWith(
                    color: AppColors.textSecondaryGrey,
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.arrow_forward_ios,
              size: Sizer.wp(16),
              color: AppColors.textSecondaryGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignedEmployeesTitleView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Assigned Employees',
          style: AppTextStyle.f18W600().copyWith(color: AppColors.primary),
        ),
        // GestureDetector(
        //   onTap: () {
        //     Get.to(AssignEmployeeScreen());
        //   },
        //   child: Text(
        //     'View all',
        //     style: AppTextStyle.f14W400().copyWith(color: AppColors.primary),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildRecentChatView() {
    return Column(
      children: [
        _buildRecentChatTitleView(),
        Divider(
          color: AppColors.dividerColor,
          thickness: 1,
          height: Sizer.hp(16),
        ),
        SpacingHelper.h16(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.recentChats.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                _buildChatCard(controller.recentChats[index]),
                if (index < controller.recentChats.length - 1)
                  SpacingHelper.h12(),
              ],
            );
          },
        ),

        SpacingHelper.h16(),
      ],
    );
  }

  Widget _buildChatCard(Map<String, String> chat) {
    return Container(
      padding: EdgeInsets.all(Sizer.wp(16)),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.circular(Sizer.wp(12)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFA9B7DD).withValues(alpha: 0.08),
            offset: Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: Sizer.wp(24),
            backgroundImage: AssetImage(chat['profileImage']!),
            backgroundColor: AppColors.dividerColor,
          ),
          SpacingHelper.w12(),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      chat['name']!,
                      style: AppTextStyle.f16W600().copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      chat['time']!,
                      style: AppTextStyle.f14W400().copyWith(
                        color: AppColors.textSecondaryGrey,
                      ),
                    ),
                  ],
                ),
                SpacingHelper.h4(),
                Text(
                  chat['lastMessage']!,
                  style: AppTextStyle.f14W400().copyWith(
                    color: AppColors.textSecondaryGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentChatTitleView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Chats',
          style: AppTextStyle.f18W600().copyWith(color: AppColors.primary),
        ),
        GestureDetector(
          onTap: () {
            //
          },
          child: Text(
            'View all',
            style: AppTextStyle.f14W400().copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildSurveyView() {
    return Column(
      children: [
        _buildSurveyTitleView(),
        Divider(
          color: AppColors.dividerColor,
          thickness: 1,
          height: Sizer.hp(16),
        ),
        SpacingHelper.h16(),
        _buildProgressView(),
      ],
    );
  }

  Widget _buildSurveyTitleView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Survey and Poll',
          style: AppTextStyle.f18W600().copyWith(color: AppColors.primary),
        ),
        GestureDetector(
          onTap: () {
            Get.to(SurveyAndPollScreen());
          },
          child: Text(
            'View all',
            style: AppTextStyle.f14W400().copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressView() {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(Sizer.wp(16)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Employee Satisfaction",
                  style: AppTextStyle.f16W600().copyWith(
                    color: Color(0xFF484848),
                  ),
                ),
                Text(
                  "${controller.daysLeft.value} days left",
                  style: AppTextStyle.f12W400().copyWith(
                    color: AppColors.textSecondaryGrey,
                  ),
                ),
              ],
            ),
            SizedBox(height: Sizer.hp(20)),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: controller.progress,
                minHeight: 10,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.progressIndicatorColor,
                ),
              ),
            ),
            SizedBox(height: Sizer.hp(12)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.percentage,
                  style: AppTextStyle.f12W400().copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  controller.responseText,
                  style: AppTextStyle.f12W400().copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: Sizer.hp(8)),
        Row(
          children: [
            _buildAddUserView(),
            SizedBox(width: Sizer.wp(16)),
            _buildAddTaskView(),
          ],
        ),
        SizedBox(height: Sizer.hp(16)),
        Row(
          children: [
            _buildSendUpdateView(),
            SizedBox(width: Sizer.wp(16)),
            // _buildAssignView(),
          ],
        ),
      ],
    );
  }

  // Widget _buildAssignView() {
  //   return Expanded(
  //     child: CustomButton(
  //       onPressed: () {
  //         Get.to(AssignEmployeeScreen());
  //       },
  //       imagePath: 'assets/icons/assign.png',
  //       text: 'Assign',
  //       fontSize: Sizer.wp(16),

  //       fontWeight: FontWeight.w500,
  //       decorationColor: AppColors.primary,
  //       textColor: AppColors.textWhite,

  //       borderRadius: Sizer.wp(8),
  //     ),
  //   );
  // }

  Widget _buildSendUpdateView() {
    return Expanded(
      child: CustomButton(
        onPressed: () {
          Get.to(AddAnnouncement());
        },
        imagePath: 'assets/icons/space_dashboard.png',
        text: 'Send an update',
        fontSize: Sizer.wp(16),
        horizontalPadding: Sizer.wp(5),

        fontWeight: FontWeight.w500,
        decorationColor: AppColors.secondaryBackground,
        textColor: AppColors.primary,
        borderColor: AppColors.primary,
        borderRadius: Sizer.wp(8),
      ),
    );
  }

  Widget _buildAddTaskView() {
    return Expanded(
      child: CustomButton(
        onPressed: () {
          Get.to(AddTaskPage());
        },
        imagePath: 'assets/icons/add_task.png',
        text: 'Add a task',
        fontSize: Sizer.wp(16),
        fontWeight: FontWeight.w500,
        decorationColor: AppColors.secondaryBackground,
        textColor: AppColors.primary,

        borderColor: AppColors.primary,
        borderRadius: Sizer.wp(8),
      ),
    );
  }

  Widget _buildAddUserView() {
    return Expanded(
      child: CustomButton(
        onPressed: () {
          Get.to(AddUserScreen());
        },
        imagePath: 'assets/icons/user.png',
        text: 'Add users',
        fontSize: Sizer.wp(16),
        fontWeight: FontWeight.w500,
        decorationColor: AppColors.secondaryBackground,
        textColor: AppColors.primary,
        borderColor: AppColors.primary,
        borderRadius: Sizer.wp(8),
      ),
    );
  }
}
