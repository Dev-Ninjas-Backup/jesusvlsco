// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/taskmanagement/controller/celendercontroller.dart';
import 'package:jesusvlsco/features/taskmanagement/screens/weekly_calender.dart';
import 'package:jesusvlsco/features/taskmanagement/widgets/wide_list.dart';

class Datewisetasks extends StatelessWidget {
  const Datewisetasks({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarController calendarController = Get.put(CalendarController());
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

            SizedBox(height: Sizer.hp(8)),

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

            //weekly calender
            // Weekly Calendar View
            Obx(() {
              final weekDates = calendarController.getWeekDates(
                calendarController.currentWeekStart.value,
              );
              return Padding(
                padding: EdgeInsets.all(Sizer.wp(16)),
                child: SizedBox(
                  height: Sizer.hp(400),
                  child: WeeklyCalendarView(
                    weekDates: weekDates,
                    selectedDate: calendarController.selectedDate.value,
                    onDateTap: calendarController.updateSelectedDate,
                  ),
                ),
              );
            }),
            SizedBox(height: Sizer.hp(24)),
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


class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.4)
      ..strokeWidth = 1;

    const dashWidth = 4.0;
    const dashSpace = 3.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
