import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/taskmanagement/controller/celendercontroller.dart';
import 'package:jesusvlsco/features/taskmanagement/widgets/wide_list.dart';

class WeeklyCalender extends StatelessWidget {
  const WeeklyCalender({super.key});

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
            Padding(
              padding: EdgeInsets.only(
                left: Sizer.wp(16.0),
                right: Sizer.wp(16.0),
              ),
              child: Row(
                children: [
                  Flexible(
                    child: _customButton(
                      // width: Sizer.wp(155),
                      color: AppColors.button1,
                      text: "Overdue\ntasks",
                      onPressed: () {},
                    ),
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

Widget _customButton({
  required Color color,
  required String text,
  required VoidCallback onPressed,
  // required double width,
}) {
  return SizedBox(
    width: Sizer.wp(170),
    height: Sizer.hp(40),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.centerLeft,
        backgroundColor: AppColors.button1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizer.wp(8)),
        ),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          CircleAvatar(
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
          Text(
            text,
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(14),
              color: AppColors.error,
              fontWeight: FontWeight.w500,
            ),
          ),

          // SizedBox(width: Sizer.wp(8)),
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

class WeeklyCalendarView extends StatelessWidget {
  final List<DateTime> weekDates;
  final DateTime selectedDate;
  final Function(DateTime) onDateTap;

  const WeeklyCalendarView({
    super.key,
    required this.weekDates,
    required this.selectedDate,
    required this.onDateTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: weekDates.length,
        itemBuilder: (context, index) {
          DateTime date = weekDates[index];
          return _buildDateRow(date);
        },
      ),
    );
  }

  Widget _buildDateRow(DateTime date) {
    final isToday = _isSameDay(date, DateTime.now());
    final isSelected = _isSameDay(
      date,
      selectedDate,
    ); // Check if this date is selected
    final dayName = DateFormat('E').format(date);
    final dayNumber = date.day;
    final monthName = DateFormat('MMM').format(date);

    return GestureDetector(
      onTap: () => onDateTap(date), // Call the callback when tapped
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue[50]
              : Colors.transparent, // Highlight the selected date
        ),
        child: Row(
          children: [
            // Date section
            SizedBox(
              width: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dayNumber.toString(),
                    style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(18),
                      fontWeight: FontWeight.w600,
                      color: isToday
                          ? AppColors.primary
                          : AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    monthName,
                    style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(16),
                      fontWeight: FontWeight.w400,
                      color: isToday
                          ? AppColors.primary
                          : AppColors.textPrimary,
                    ),
                  ),

                  // Dotted Divider
                ],
              ),
            ),
            const SizedBox(width: 16),

            // Day name
            SizedBox(
              child: Text(
                dayName,
                style: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(18),
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomPaint(
                size: const Size(double.infinity, 1),
                painter: DottedLinePainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
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
