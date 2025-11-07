// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/userpanel/features/user_taskmanagement/screens/all_task_details.dart';

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