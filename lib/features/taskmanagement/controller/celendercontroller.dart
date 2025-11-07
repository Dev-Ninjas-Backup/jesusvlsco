import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  // Observable variables
  var selectedDate = DateTime.now().obs;
  Rx<DateTime> currentWeekStart = DateTime.now().obs;

  // Function to get the current week's dates
  List<DateTime> getWeekDates(DateTime startDate) {
    return List.generate(7, (index) => startDate.add(Duration(days: index)));
  }

  // Function to update the selected date
  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    // Update the start of the week based on the selected date
    currentWeekStart.value = DateTime(
      date.year,
      date.month,
      date.day,
    ).subtract(Duration(days: date.weekday % 7));
  }

  // Function to open the date picker and update the selected date
  Future<void> openDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (pickedDate != selectedDate.value) {
      updateSelectedDate(pickedDate!);
    }
  }
}
