import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

/// DatePickerContainer widget for selecting date ranges
/// Provides a clickable container that shows date selection dialog
class DatePickerContainer extends StatefulWidget {
  const DatePickerContainer({super.key});

  @override
  State<DatePickerContainer> createState() => _DatePickerContainerState();
}

class _DatePickerContainerState extends State<DatePickerContainer> {
  DateTimeRange? selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Sizer.wp(12),
        vertical: Sizer.hp(8),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizer.wp(8)),
        border: Border.all(color: AppColors.textfield),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: _showDatePicker,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_today,
              size: Sizer.wp(16),
              color: AppColors.textfield,
            ),
            SizedBox(width: Sizer.wp(8)),
            Text(
              _getDisplayText(),
              style: AppTextStyle.f14W400().copyWith(color: AppColors.text),
            ),
          ],
        ),
      ),
    );
  }

  /// Get display text for the date picker
  String _getDisplayText() {
    if (selectedDateRange == null) {
      return 'Select Date';
    }

    final start = selectedDateRange!.start;
    final end = selectedDateRange!.end;

    return '${start.day}/${start.month}/${start.year} - ${end.day}/${end.month}/${end.year}';
  }

  /// Show date range picker dialog
  Future<void> _showDatePicker() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange:
          selectedDateRange ??
          DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(const Duration(days: 7)),
          ),
    );

    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }
}
