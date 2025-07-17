// ignore_for_file: sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class TaskmanagementDashboard extends StatelessWidget {
  const TaskmanagementDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.textWhite,
        backgroundColor: Colors.white,
        elevation: 4,
        leading: Icon(
          CupertinoIcons.arrow_left,
          color: AppColors.backgroundDark,
          size: Sizer.wp(24),
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
      body: Column(
        children: [
          _buildSearchTextField(),
          Padding(
            padding: EdgeInsets.only(left: Sizer.wp(16.0)),
            child: Row(
              children: [
                _customButton(
                  width: Sizer.wp(155),
                  color: AppColors.button1,
                  text: "Overdue tasks",
                  onPressed: () {},
                ),
                SizedBox(width: Sizer.wp(8)),
                _customButton1(
                  width: Sizer.wp(120),
                  color: AppColors.primary,
                  text: "Add Task",
                  onPressed: () {},
                ),
                SizedBox(width: Sizer.wp(8)),
                _customButton1(
                  width: Sizer.wp(100),
                  color: AppColors.primary,
                  text: "Activity",
                  onPressed: () {},
                ),
              ],
            ),
          ),
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
              Text(
                'Dates',
                style: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(16),
                  color: AppColors.backgroundDark,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
         Expanded(
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 10,
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizer.wp(16.0),
          vertical: Sizer.hp(8.0),
        ),
        child: Container(
          width: Sizer.wp(300), // Fixed width instead of double.infinity
          height: Sizer.hp(72),
          decoration: BoxDecoration(
            color: AppColors.textWhite,
            border: Border(
              bottom: BorderSide(color: AppColors.border),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(Sizer.wp(16)),
            child: ListTile(
              leading: Checkbox(value: true, onChanged: (value) {}),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Task ${index + 1}',
                      style: AppTextStyle.regular().copyWith(
                        fontSize: Sizer.wp(16),
                        color: AppColors.backgroundDark,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.message_sharp,
                    color: AppColors.backgroundDark,
                    size: Sizer.wp(24),
                  ),
                  SizedBox(width: Sizer.wp(16)),
                  Container(
                    width:45 ,
                    padding: EdgeInsets.all(34.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.button1,
                    ),
                    child: Text(
                      'done',
                      style: AppTextStyle.regular().copyWith(
                        fontSize: Sizer.wp(25),
                        color: AppColors.backgroundDark,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  ),
),
        ],
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
            color: AppColors.textSecondary.withOpacity(0.1),
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
            color: AppColors.textSecondary.withOpacity(0.6),
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
  required double width,
}) {
  return Stack(
    alignment: AlignmentDirectional.centerStart,
    children: [
      SizedBox(
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
              color: AppColors.error,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: Sizer.wp(5)),
        child: CircleAvatar(
          radius: Sizer.wp(10),
          backgroundColor: AppColors.error,
          child: Text(
            '1',
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(12),
              color: AppColors.textWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ],
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