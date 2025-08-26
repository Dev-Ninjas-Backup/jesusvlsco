import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/common/widgets/common_divider.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/core/utils/helpers/spacing_helper.dart';
import 'package:jesusvlsco/features/dashboard/admin_dashboard/controllers/user_dashboard_controller.dart';
import 'package:jesusvlsco/features/dashboard/admin_dashboard/widgets/team_avatar.dart';
import 'package:jesusvlsco/features/dashboard/admin_dashboard/widgets/user_drawer.dart';
import 'package:jesusvlsco/features/user_survey_poll/user_survey/screen/user_survey_screen.dart';

class UserDashboardScreen extends StatelessWidget {
  UserDashboardScreen({super.key});

  final UserDashboardController controller = Get.put(UserDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.all(Sizer.wp(16)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            children: [
              _buildAlertView(),
              SpacingHelper.h16(),
              _buildShiftCard(),
              SpacingHelper.h16(),
              _buildUpcomingTasksCard(),
              SpacingHelper.h16(),
              _buildUpcomingShiftAndTasksCard(),
              SpacingHelper.h16(),
              _buildCompanyUpdatesCard(),
              SpacingHelper.h16(),
              _buildRecognitionEngagementCard(),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add, // Main FAB icon
        activeIcon: Icons.close, // Icon when FAB is open
        backgroundColor: AppColors.color1,
        foregroundColor: Colors.white,
        activeBackgroundColor: Colors.red,
        activeForegroundColor: Colors.white,
        buttonSize: const Size(56, 56),
        childrenButtonSize: const Size(48, 48),
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        spacing: 8,
        spaceBetweenChildren: 8,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.login, size: 20),
            backgroundColor: AppColors.color2,
            foregroundColor: Colors.white,
            label: 'Check In',
            labelStyle: const TextStyle(fontSize: 14, color: Colors.black),
            labelBackgroundColor: Colors.white,
            onTap: () async {
              Get.snackbar(
                'Info',
                'Processing Check In...',
                snackPosition: SnackPosition.TOP,
              );
              try {
                bool serviceEnabled =
                    await Geolocator.isLocationServiceEnabled();
                if (!serviceEnabled) {
                  Get.snackbar(
                    'Location',
                    'Please enable location services',
                    snackPosition: SnackPosition.TOP,
                  );
                  await controller.clockIn(lat: 0.0, lng: 0.0);
                  return;
                }

                LocationPermission permission =
                    await Geolocator.checkPermission();
                if (permission == LocationPermission.denied) {
                  permission = await Geolocator.requestPermission();
                }
                if (permission == LocationPermission.denied ||
                    permission == LocationPermission.deniedForever) {
                  Get.snackbar(
                    'Location',
                    'Location permission denied',
                    snackPosition: SnackPosition.TOP,
                  );
                  await controller.clockIn(lat: 0.0, lng: 0.0);
                  return;
                }

                final pos = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high,
                );
                await controller.clockIn(lat: pos.latitude, lng: pos.longitude);
              } catch (e) {
                Get.snackbar(
                  'Error',
                  'Failed to get location: $e',
                  snackPosition: SnackPosition.TOP,
                );
                await controller.clockIn(lat: 0.0, lng: 0.0);
              }
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.logout, size: 20),
            backgroundColor: AppColors.color2,
            foregroundColor: Colors.white,
            label: 'Check Out',
            labelStyle: const TextStyle(fontSize: 14, color: Colors.black),
            labelBackgroundColor: Colors.white,
            onTap: () async {
              Get.snackbar(
                'Info',
                'Processing Check Out...',
                snackPosition: SnackPosition.TOP,
              );
              try {
                bool serviceEnabled =
                    await Geolocator.isLocationServiceEnabled();
                if (!serviceEnabled) {
                  Get.snackbar(
                    'Location',
                    'Please enable location services',
                    snackPosition: SnackPosition.TOP,
                  );
                  await controller.clockOut(lat: 0.0, lng: 0.0);
                  return;
                }

                LocationPermission permission =
                    await Geolocator.checkPermission();
                if (permission == LocationPermission.denied) {
                  permission = await Geolocator.requestPermission();
                }
                if (permission == LocationPermission.denied ||
                    permission == LocationPermission.deniedForever) {
                  Get.snackbar(
                    'Location',
                    'Location permission denied',
                    snackPosition: SnackPosition.TOP,
                  );
                  await controller.clockOut(lat: 0.0, lng: 0.0);
                  return;
                }

                final pos = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high,
                );
                await controller.clockOut(
                  lat: pos.latitude,
                  lng: pos.longitude,
                );
              } catch (e) {
                Get.snackbar(
                  'Error',
                  'Failed to get location: $e',
                  snackPosition: SnackPosition.TOP,
                );
                await controller.clockOut(lat: 0.0, lng: 0.0);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecognitionEngagementCard() {
    return Container(
      padding: EdgeInsets.all(Sizer.wp(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizer.wp(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRecognitionEngagementHeader(),
          const CommonDivider(height: 20, color: Color(0xFFC5C5C5)),
          SpacingHelper.h16(),
          _buildRecognitionEngagementContent(),
        ],
      ),
    );
  }

  Widget _buildRecognitionEngagementContent() {
    return Obx(
      () => SizedBox(
        height: Sizer.hp(300),
        child: controller.recognitionEngagement.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.emoji_events,
                      size: Sizer.wp(36),
                      color: AppColors.recognitionColor,
                    ),
                    SpacingHelper.h8(),
                    Text(
                      'No recognitions yet',
                      style: AppTextStyle.f16W600().copyWith(
                        color: AppColors.recognitionColor,
                      ),
                    ),
                    SpacingHelper.h4(),
                    Text(
                      'There are no recognitions for you right now.',
                      style: AppTextStyle.f14W400().copyWith(
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.recognitionEngagement.length > 3
                    ? 3
                    : controller.recognitionEngagement.length,
                itemBuilder: (context, index) {
                  final item = controller.recognitionEngagement[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: Sizer.wp(8)),
                    child: _buildRecognitionItemWithIcon(
                      item['title']!,
                      item['description']!,
                      item['imagePath']!,
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildRecognitionItemWithIcon(
    String title,
    String description,
    String imagePath,
  ) {
    return Container(
      padding: EdgeInsets.all(Sizer.wp(12)),
      decoration: BoxDecoration(
        color: AppColors.recognitionColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(Sizer.wp(12)),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: Sizer.wp(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(imagePath, width: Sizer.wp(40), height: Sizer.hp(40)),
            SpacingHelper.w8(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.f14W400().copyWith(
                      color: AppColors.recognitionColor,
                    ),
                  ),
                  SpacingHelper.h4(),
                  Text(
                    description,
                    style: AppTextStyle.f14W400().copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecognitionEngagementHeader() {
    return Row(
      children: [
        Image.asset(
          'assets/icons/license.png',
          height: Sizer.hp(29),
          width: Sizer.wp(29),
        ),
        SpacingHelper.w8(),
        Text(
          'Recognition & Engagement',
          style: AppTextStyle.f18W600().copyWith(
            color: AppColors.textBlackShade,
          ),
        ),
        SpacingHelper.w8(),
      ],
    );
  }

  Widget _buildCompanyUpdatesCard() {
    return Container(
      padding: EdgeInsets.all(Sizer.wp(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizer.wp(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCompanyUpdatesHeader(),
          const CommonDivider(height: 20, color: Color(0xFFC5C5C5)),
          SpacingHelper.h16(),
          _buildListOfCompanyUpdates(),
        ],
      ),
    );
  }

  Widget _buildListOfCompanyUpdates() {
    return Obx(
      () => SizedBox(
        height: Sizer.hp(380),
        child: controller.companyUpdates.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.announcement_outlined,
                      size: Sizer.wp(36),
                      color: AppColors.primary,
                    ),
                    SpacingHelper.h8(),
                    Text(
                      'No company updates',
                      style: AppTextStyle.f16W600().copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    SpacingHelper.h4(),
                    Text(
                      'You have no recent announcements.',
                      style: AppTextStyle.f14W400().copyWith(
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.companyUpdates.length > 3
                    ? 3
                    : controller.companyUpdates.length,
                itemBuilder: (context, index) {
                  final update = controller.companyUpdates[index];
                  return _buildUpdateItem(update);
                },
              ),
      ),
    );
  }

  Widget _buildUpdateItem(Map<String, String> update) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(Sizer.wp(8)),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(Sizer.wp(8)),
          ),
          child: Text(
            update['department']!,
            style: AppTextStyle.f14W400().copyWith(color: AppColors.primary),
          ),
        ),
        SpacingHelper.h8(),
        Text(
          update['departmentName']!,
          style: AppTextStyle.f16W600().copyWith(
            color: AppColors.textBlackShade,
          ),
        ),
        SpacingHelper.h4(),
        Text(
          update['message']!,
          style: AppTextStyle.f14W400().copyWith(
            color: AppColors.textBlackShade,
          ),
        ),
        SpacingHelper.h4(),
        Text(
          update['timeAgo']!,
          style: AppTextStyle.f12W400().copyWith(color: Colors.grey.shade600),
        ),
        SpacingHelper.h16(),
      ],
    );
  }

  Widget _buildCompanyUpdatesHeader() {
    return Row(
      children: [
        Image.asset(
          'assets/icons/space_dashboard.png',
          height: Sizer.hp(29),
          width: Sizer.wp(29),
        ),
        SpacingHelper.w8(),
        Text(
          'Company Updates',
          style: AppTextStyle.f18W600().copyWith(
            color: AppColors.textBlackShade,
          ),
        ),
        SpacingHelper.w8(),
      ],
    );
  }

  Widget _buildUpcomingShiftAndTasksCard() {
    return Container(
      padding: EdgeInsets.all(Sizer.wp(20)),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(Sizer.wp(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUpcomingShiftsTasksHeader(),
          const CommonDivider(height: 20, color: Color(0xFFC5C5C5)),
          SpacingHelper.h16(),
          _buildNextShiftSection(),
          const CommonDivider(height: 20, color: Color(0xFFC5C5C5)),
          SpacingHelper.h20(),
          _buildUpcomingTasksSection(),
        ],
      ),
    );
  }

  Widget _buildUpcomingShiftsTasksHeader() {
    return Row(
      children: [
        Image.asset(
          'assets/icons/upcoming.png',
          height: Sizer.hp(29),
          width: Sizer.wp(29),
        ),
        SpacingHelper.w8(),
        Text(
          'Upcoming Shifts & Tasks',
          style: AppTextStyle.f18W600().copyWith(
            color: AppColors.textBlackShade,
          ),
        ),
        SpacingHelper.w8(),
      ],
    );
  }

  Widget _buildNextShiftSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Next Shift :',
          style: AppTextStyle.f16W600().copyWith(
            color: AppColors.textBlackShade,
          ),
        ),
        SpacingHelper.h8(),
        Obx(() {
          if (controller.upcomingShifts.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(left: Sizer.wp(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: Sizer.wp(4),
                          right: Sizer.wp(2),
                        ),
                        child: Image.asset(
                          'assets/icons/calendar_today.png',
                          height: Sizer.hp(20),
                          width: Sizer.wp(20),
                        ),
                      ),
                      SpacingHelper.w8(),
                      Text(
                        'No upcoming shifts',
                        style: AppTextStyle.f16W600().copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  SpacingHelper.h8(),
                  Text(
                    'You have no scheduled shifts coming up.',
                    style: AppTextStyle.f14W400().copyWith(
                      color: AppColors.textBlackShade,
                    ),
                  ),
                ],
              ),
            );
          }

          final s = controller.upcomingShifts.first;
          return Padding(
            padding: EdgeInsets.only(left: Sizer.wp(8)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: Sizer.wp(4),
                    right: Sizer.wp(2),
                  ),
                  child: Image.asset(
                    'assets/icons/calendar_today.png',
                    height: Sizer.hp(20),
                    width: Sizer.wp(20),
                  ),
                ),
                SpacingHelper.w8(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s['time'] ?? '',
                      style: AppTextStyle.f16W600().copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    SpacingHelper.h4(),
                    Text(
                      s['location'] ?? '',
                      style: AppTextStyle.f14W400().copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      s['team'] ?? '',
                      style: AppTextStyle.f14W400().copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildUpcomingTasksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Upcoming Tasks :',
              style: AppTextStyle.f16W600().copyWith(
                color: AppColors.textBlackShade,
              ),
            ),
          ],
        ),
        SpacingHelper.h8(),
        Obx(() {
          if (controller.upcomingTasks.isEmpty) {
            return Column(
              children: [
                Icon(
                  Icons.assignment,
                  size: Sizer.wp(36),
                  color: AppColors.primary,
                ),
                SpacingHelper.h8(),
                Text(
                  'No upcoming tasks',
                  style: AppTextStyle.f16W600().copyWith(
                    color: AppColors.primary,
                  ),
                ),
                SpacingHelper.h4(),
                Text(
                  'You have no assigned tasks at the moment.',
                  style: AppTextStyle.f14W400().copyWith(
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          }

          final count = controller.upcomingTasks.length > 3
              ? 3
              : controller.upcomingTasks.length;
          return Column(
            children: List.generate(count, (index) {
              final task = controller.upcomingTasks[index];
              return Column(
                children: [_buildTaskItem(task), SpacingHelper.h8()],
              );
            }),
          );
        }),
      ],
    );
  }

  Widget _buildUpcomingTasksCard() {
    return Container(
      padding: EdgeInsets.all(Sizer.wp(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizer.wp(16)),
        border: Border.all(color: AppColors.dividerColor, width: 1.0),
      ),
      child: Column(
        children: [
          SpacingHelper.h20(),
          _buildUpcomingTasksHeader(),
          SpacingHelper.h16(),
          _buildUpcomingTasksList(),
        ],
      ),
    );
  }

  // ...existing task item widget is used instead: _buildTaskItem

  Widget _buildUpcomingTasksHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Upcoming Tasks',
          style: AppTextStyle.f16W600().copyWith(
            color: AppColors.textBlackShade,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(UserSurveyScreen());
          },
          child: Row(
            children: [
              Text(
                'View All',
                style: AppTextStyle.f14W400().copyWith(
                  color: AppColors.primary,
                ),
              ),
              SpacingHelper.w16(),
              Icon(
                Icons.arrow_forward_ios,
                size: Sizer.wp(16),
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingTasksList() {
    return Obx(
      () => SizedBox(
        height: Sizer.hp(290),
        child: controller.upcomingTasks.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assignment,
                      size: Sizer.wp(36),
                      color: AppColors.primary,
                    ),
                    SpacingHelper.h8(),
                    Text(
                      'No upcoming tasks',
                      style: AppTextStyle.f16W600().copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    SpacingHelper.h4(),
                    Text(
                      'You have no assigned tasks for now.',
                      style: AppTextStyle.f14W400().copyWith(
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.upcomingTasks.length > 3
                    ? 3
                    : controller.upcomingTasks.length,
                itemBuilder: (context, index) {
                  final task = controller.upcomingTasks[index];
                  return _buildTaskItem(task);
                },
              ),
      ),
    );
  }

  Widget _buildTaskItem(Map<String, dynamic> task) {
    return Container(
      margin: EdgeInsets.only(bottom: Sizer.wp(12)),
      padding: EdgeInsets.all(Sizer.wp(12)),
      decoration: BoxDecoration(
        color: AppColors.shiftCardColor,
        borderRadius: BorderRadius.circular(Sizer.wp(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              task['title']!,
              style: AppTextStyle.f14W400().copyWith(
                color: AppColors.textBlackShade,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Sizer.wp(12),
              vertical: Sizer.wp(6),
            ),
            decoration: BoxDecoration(
              color: task['isToday']
                  ? AppColors.taskCard
                  : AppColors.primary.withOpacity(0.4),
              borderRadius: BorderRadius.circular(Sizer.wp(20)),
            ),
            child: Text(
              task['dueDate']!,
              style: AppTextStyle.f14W400().copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertView() {
    return Obx(
      () => controller.showAlert.value
          ? Container(
              padding: EdgeInsets.all(Sizer.wp(12)),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                border: Border.all(color: Colors.red.shade200),
                borderRadius: BorderRadius.circular(Sizer.wp(12)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    color: Colors.red,
                    size: Sizer.wp(25),
                  ),
                  SpacingHelper.w8(),
                  Expanded(
                    child: Text(
                      controller.alertMessage.value,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.f14W400().copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ),
                  _buildDismissButton(),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildDismissButton() {
    return GestureDetector(
      onTap: controller.dismissAlert,
      child: Text(
        "Dismiss",
        style: AppTextStyle.f16W500().copyWith(color: AppColors.error),
      ),
    );
  }

  Widget _buildShiftCard() {
    return Container(
      padding: EdgeInsets.all(Sizer.wp(16)),
      decoration: BoxDecoration(
        color: AppColors.shiftCardColor,
        borderRadius: BorderRadius.circular(Sizer.wp(16)),
      ),
      child: Column(
        children: [
          _buildShiftCardHeader(),
          SpacingHelper.h16(),
          _buildShiftDetails(),
        ],
      ),
    );
  }

  Widget _buildShiftCardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.alarm, size: Sizer.wp(24), color: AppColors.textBlackShade),
        const Spacer(),
        Text(
          "View Schedule",
          style: AppTextStyle.f12W400().copyWith(
            color: AppColors.textBlackShade,
          ),
        ),
      ],
    );
  }

  Widget _buildShiftDetails() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          controller.hasActiveShift.value
              ? Column(
                  children: [
                    _buildShiftTime(),
                    SpacingHelper.h8(),
                    _buildShiftDate(),
                    SpacingHelper.h8(),
                    _buildShiftLocation(),
                    SpacingHelper.h8(),
                    _buildTeamSection(),
                  ],
                )
              : Column(
                  children: [
                    Text(
                      'No active shift',
                      style: AppTextStyle.f16W600().copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    SpacingHelper.h8(),
                    Text(
                      'You currently have no active shift. Please check in to start.',
                      style: AppTextStyle.f14W400().copyWith(
                        color: AppColors.textBlackShade,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SpacingHelper.h8(),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildShiftTime() {
    return Text(
      controller.shiftTime.value,
      style: AppTextStyle.f16W600().copyWith(color: AppColors.primary),
    );
  }

  Widget _buildShiftDate() {
    return Text(
      controller.shiftDate.value,
      style: AppTextStyle.f12W400().copyWith(color: AppColors.textBlackShade),
    );
  }

  Widget _buildShiftLocation() {
    return Text(
      controller.shiftLocation.value,
      style: AppTextStyle.f16W600().copyWith(color: AppColors.primary),
    );
  }

  Widget _buildTeamSection() {
    return Column(
      children: [
        Text(
          "Your Team",
          style: AppTextStyle.f14W400().copyWith(
            color: AppColors.textBlackShade,
          ),
        ),
        SpacingHelper.h8(),
        _buildTeamAvatars(),
      ],
    );
  }

  Widget _buildTeamAvatars() {
    return Obx(
      () => Center(
        child: SizedBox(
          height: Sizer.hp(60),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: controller.teamMembers.length,
            itemBuilder: (context, index) {
              final member = controller.teamMembers[index];
              return Container(
                margin: EdgeInsets.only(right: Sizer.wp(8)),
                child: TeamAvatar(initial: member['initial']!),
              );
            },
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Dashboard',
        style: AppTextStyle.f18W600().copyWith(color: AppColors.primary),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.menu, color: AppColors.textBlackShade),
          onPressed: () => Get.to(UserDrawer()),
        ),
      ],
    );
  }
}
