import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../utils/constants/sizer.dart';
import '../../utils/constants/colors.dart';
import '../styles/global_text_style.dart';

/// Custom Date Picker Controller
class CustomDatePickerController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var currentMonth = DateTime.now().obs;
  
  /// Format month and year for display
  String get formattedMonthYear {
    return DateFormat('MMMM yyyy').format(currentMonth.value);
  }

  /// Get days in current month
  List<DateTime?> get daysInMonth {
    final firstDayOfMonth = DateTime(currentMonth.value.year, currentMonth.value.month, 1);
    final lastDayOfMonth = DateTime(currentMonth.value.year, currentMonth.value.month + 1, 0);
    final firstWeekday = firstDayOfMonth.weekday;
    
    List<DateTime?> days = [];
    
    // Add previous month's trailing days
    final prevMonth = DateTime(currentMonth.value.year, currentMonth.value.month - 1, 0);
    for (int i = firstWeekday - 1; i > 0; i--) {
      days.add(DateTime(prevMonth.year, prevMonth.month, prevMonth.day - i + 1));
    }
    
    // Add current month's days
    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      days.add(DateTime(currentMonth.value.year, currentMonth.value.month, day));
    }
    
    // Add next month's leading days to complete the grid
    final remainingDays = 42 - days.length; // 6 weeks * 7 days = 42
    for (int day = 1; day <= remainingDays; day++) {
      days.add(DateTime(currentMonth.value.year, currentMonth.value.month + 1, day));
    }
    
    return days;
  }

  /// Navigate to previous month
  void previousMonth() {
    currentMonth.value = DateTime(currentMonth.value.year, currentMonth.value.month - 1);
  }

  /// Navigate to next month
  void nextMonth() {
    currentMonth.value = DateTime(currentMonth.value.year, currentMonth.value.month + 1);
  }

  /// Select a date
  void selectDate(DateTime date) {
    selectedDate.value = date;
    // Close the picker when date is selected
    Get.back(result: date);
  }

  /// Check if date is in current month
  bool isCurrentMonth(DateTime date) {
    return date.month == currentMonth.value.month && date.year == currentMonth.value.year;
  }

  /// Check if date is selected
  bool isSelected(DateTime date) {
    return selectedDate.value.year == date.year &&
           selectedDate.value.month == date.month &&
           selectedDate.value.day == date.day;
  }

  /// Check if date is today
  bool isToday(DateTime date) {
    final today = DateTime.now();
    return today.year == date.year &&
           today.month == date.month &&
           today.day == date.day;
  }
}

/// Custom Date Picker Widget
/// Matches Figma design with full functionality
class CustomDatePickerWidget extends StatelessWidget {
  final DateTime? initialDate;
  final Function(DateTime)? onDateSelected;

  const CustomDatePickerWidget({
    super.key,
    this.initialDate,
    this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomDatePickerController());
    
    // Set initial date if provided
    if (initialDate != null) {
      controller.selectedDate.value = initialDate!;
      controller.currentMonth.value = initialDate!;
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
      ),
      child: Container(
        width: Sizer.wp(360),
        height: Sizer.hp(367),
        padding: EdgeInsets.all(Sizer.wp(24)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          children: [
            // Header with month/year and navigation
            _buildHeader(controller),
            
            SizedBox(height: Sizer.hp(24)),
            
            // Week days header
            _buildWeekDaysHeader(),
            
            SizedBox(height: Sizer.hp(16)),
            
            // Calendar grid
            Expanded(child: _buildCalendarGrid(controller)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(CustomDatePickerController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Month and Year
        Obx(() => Text(
          controller.formattedMonthYear,
          style: AppTextStyle.f16W600().copyWith(
            color: const Color(0xFF484848),
            height: 1.5,
          ),
        )),
        
        // Navigation arrows
        Row(
          children: [
            GestureDetector(
              onTap: controller.previousMonth,
              child: Container(
                padding: EdgeInsets.all(Sizer.wp(8)),
                child: Icon(
                  Icons.chevron_left,
                  size: Sizer.wp(20),
                  color: const Color(0xFF484848),
                ),
              ),
            ),
            SizedBox(width: Sizer.wp(8)),
            GestureDetector(
              onTap: controller.nextMonth,
              child: Container(
                padding: EdgeInsets.all(Sizer.wp(8)),
                child: Icon(
                  Icons.chevron_right,
                  size: Sizer.wp(20),
                  color: const Color(0xFF484848),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeekDaysHeader() {
    const weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    return Row(
      children: weekDays.map((day) {
        return Expanded(
          child: Center(
            child: Text(
              day,
              style: AppTextStyle.f14W400().copyWith(
                color: const Color(0xFF484848),
                height: 1.45,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCalendarGrid(CustomDatePickerController controller) {
    return Obx(() {
      final days = controller.daysInMonth;
      
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1.0,
        ),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final date = days[index];
          if (date == null) return const SizedBox();
          
          final isCurrentMonth = controller.isCurrentMonth(date);
          final isSelected = controller.isSelected(date);
          final isToday = controller.isToday(date);
          
          return GestureDetector(
            onTap: () => controller.selectDate(date),
            child: Container(
              margin: EdgeInsets.all(Sizer.wp(2)),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: isToday && !isSelected 
                    ? Border.all(color: AppColors.primary, width: 1)
                    : null,
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: AppTextStyle.f14W400().copyWith(
                    color: isSelected
                        ? Colors.white
                        : isCurrentMonth
                            ? const Color(0xFF484848)
                            : const Color(0xFF949494),
                    height: 1.45,
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

/// Static method to show date picker
class CustomDatePicker {
  /// Show date picker dialog and return selected date
  static Future<DateTime?> show({
    required BuildContext context,
    DateTime? initialDate,
  }) async {
    return await showDialog<DateTime>(
      context: context,
      barrierDismissible: true,
      builder: (context) => CustomDatePickerWidget(
        initialDate: initialDate,
      ),
    );
  }
}
