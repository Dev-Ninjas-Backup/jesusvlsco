import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/common/widgets/common_divider.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/core/utils/helpers/spacing_helper.dart';
import 'package:jesusvlsco/features/assign_employee/views/user_assign_employee_screen.dart';
import 'package:jesusvlsco/features/bottom_navigation/controller/bottom_navigation_scaffold_controller.dart';
import 'package:jesusvlsco/features/dashboard/admin_dashboard/controllers/user_dashboard_controller.dart';
import 'package:jesusvlsco/features/dashboard/admin_dashboard/widgets/team_avatar.dart';
import 'package:jesusvlsco/features/user_time_clock/screen/user_time_clock.dart';
import '../../../userpanel/features/user_taskmanagement/screens/taskmanagement_dashboard.dart';

class UserDashboardScreen extends StatelessWidget {
  UserDashboardScreen({super.key});

  final UserDashboardController controller = Get.put(UserDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.all(Sizer.wp(16)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            children: [
              SizedBox(height: 24),
              _buildProfileContainer(),
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
    );
  }

  Widget _buildProfileContainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white24,
        border: Border.all(width: 1, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(controller.userProfileController.displayFirsName),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            "${controller.userProfileController.timeBasedGreeting}, ${controller.userProfileController.displayName}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(UserTimeClock());
                },
                child: SizedBox(
                  child: Column(
                    children: [
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.green.shade100,
                        ),
                        onPressed: () {
                          Get.to(UserTimeClock());
                        },
                        icon: Icon(
                          Icons.watch_later_rounded,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        "Time Clock",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //schedule action work here
                  Get.to(AssignEmployeeScreen());
                },
                child: SizedBox(
                  child: Column(
                    children: [
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.blue.shade100,
                        ),
                        onPressed: () {
                          Get.to(AssignEmployeeScreen());
                        },
                        icon: Icon(Icons.calendar_today, color: Colors.blue),
                      ),
                      Text(
                        "Schedule",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //project or third index route here
                  Get.find<BottomNavigationController>().changeIndex(4);
                },
                child: SizedBox(
                  child: Column(
                    children: [
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.teal.shade100,
                        ),
                        onPressed: () {
                          Get.find<BottomNavigationController>().changeIndex(4);
                        },
                        icon: Icon(Icons.folder_rounded, color: Colors.teal),
                      ),
                      Text(
                        "Project",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
        color: AppColors.recognitionColor.withValues(alpha: 0.1),
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
            color: AppColors.primary.withValues(alpha: 0.1),
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
            Get.to(UserTaskmanagementDashboard());
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
                  : AppColors.primary.withValues(alpha: 0.4),
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
      // leading: IconButton(
      //   onPressed: () {},
      //   icon: Icon(Icons.notifications, color: AppColors.primary),
      // ),
      title: Text(
        'Dashboard',
        style: AppTextStyle.f18W600().copyWith(color: AppColors.primary),
      ),
      centerTitle: true,
      // actions: [
      //   IconButton(
      //     icon: Icon(Icons.menu, color: AppColors.textBlackShade),
      //     onPressed: () => Get.to(UserDrawer()),
      //   ),
      // ],
    );
  }
}
