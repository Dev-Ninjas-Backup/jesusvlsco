// ignore_for_file: sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/taskmanagement/screens/activity_log.dart';
import 'package:jesusvlsco/features/taskmanagement/screens/add_task.dart';
import 'package:jesusvlsco/features/taskmanagement/screens/overduetask.dart';
import 'package:jesusvlsco/features/taskmanagement/screens/weekly_calender.dart';
import 'package:jesusvlsco/features/taskmanagement/widgets/wide_list.dart';

class TaskmanagementDashboard extends StatefulWidget {
  const TaskmanagementDashboard({super.key});

  @override
  State<TaskmanagementDashboard> createState() =>
      _TaskmanagementDashboardState();
}

class _TaskmanagementDashboardState extends State<TaskmanagementDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.textWhite,
        backgroundColor: Colors.white,
        elevation: 0.1,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.arrow_left,
            color: AppColors.backgroundDark,
            size: Sizer.wp(24),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Task & Project Management',
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(20),
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.bars,
              color: AppColors.backgroundDark,
              size: Sizer.wp(24),
            ),
            onPressed: () {
              // Handle menu action if needed
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchTextField(),
            Padding(
              padding: EdgeInsets.only(left: Sizer.wp(16.0)),
              child: Row(
                children: [
                  Flexible(
                    child: _customButton(
                      color: AppColors.button1,
                      text: "Due",
                      onPressed: () {
                        Get.to(OverdueTask());
                      },
                    ),
                  ),
                  SizedBox(width: Sizer.wp(8)),
                  Flexible(
                    child: _customButton1(
                      width: Sizer.wp(120),
                      color: AppColors.primary,
                      text: "Add Task",
                      onPressed: () {
                        Get.to(AddTaskPage());
                      },
                    ),
                  ),
                  SizedBox(width: Sizer.wp(8)),
                  _customButton1(
                    width: Sizer.wp(120),
                    color: AppColors.primary,
                    text: "Activity",
                    onPressed: () {
                      Get.to(ActivityFeedScreen());
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: Sizer.hp(16)),

            //List items start
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: Sizer.wp(16.0)),
                  child: Text(
                    'Views by:',
                    style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(16),
                      color: AppColors.backgroundDark,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.menu_open_sharp,
                    color: AppColors.backgroundDark,
                  ),
                ),
                Text(
                  'List',
                  style: AppTextStyle.regular().copyWith(
                    fontSize: Sizer.wp(16),
                    color: AppColors.backgroundDark,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.calendar_today,
                    color: AppColors.backgroundDark,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(WeeklyCalender());
                  },
                  child: Text(
                    'Dates',
                    style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(16),
                      color: AppColors.backgroundDark,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: Sizer.hp(400), child: WideList()),
            SizedBox(height: Sizer.hp(400), child: WideList()),
          ],
        ),
      ),
    );
  }
}

Widget _buildSearchTextField() {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: Sizer.wp(16),
      vertical: Sizer.hp(24),
    ),
    child: Container(
      height: Sizer.hp(48),
      width: Sizer.wp(360),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(Sizer.wp(10)),
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withValues(alpha: 0.1),
            blurRadius: 3,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: 'Search articles',
          hintStyle: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(14),
            color: AppColors.textSecondary.withValues(alpha: 0.6),
          ),
          suffixIcon: Container(
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              'assets/icons/search-normal.svg',
              height: Sizer.hp(20),
              width: Sizer.wp(20),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: Sizer.wp(16),
            vertical: Sizer.hp(12),
          ),
        ),
      ),
    ),
  );
}

Widget _customButton({
  required Color color,
  required String text,
  required VoidCallback onPressed,
  // required double width,
}) {
  return SizedBox(
    height: Sizer.hp(40),
    width: Sizer.wp(170),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.button1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizer.wp(8)),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: Sizer.wp(8),
            backgroundColor: AppColors.error,
            child: Text(
              '1',
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(8),
                color: AppColors.textWhite,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: Sizer.wp(8)),
          Flexible(
            child: Text(
              text,
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(15),
                color: AppColors.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _customButton1({
  required Color color,
  required String text,
  required VoidCallback onPressed,
  required double width,
}) {
  return SizedBox(
    width: width,
    height: Sizer.hp(40),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizer.wp(8)),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTextStyle.regular().copyWith(
          fontSize: Sizer.wp(16),
          color: AppColors.textWhite,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
