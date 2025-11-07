import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminTimeClockAddShiftController extends GetxController {
  RxString selectedProject = 'Metro Shopping Center'.obs;

  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);

  Rx<TimeOfDay?> startTime = Rx<TimeOfDay?>(null);
  Rx<TimeOfDay?> endTime = Rx<TimeOfDay?>(null);

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  final List<String> projectList = [
    'Metro Shopping Center',
    'Riverside Apartments',
    'City Bridge Renovations',
    'Tech Campus Phase 2',
    'Summit Plaza Offices',
    'Innovation Hub Tower',
    'The Commerce Hub',
  ];

  void selectProject(String projectName) {
    selectedProject.value = projectName;
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'Pick a date';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String formatTime(TimeOfDay? time) {
    if (time == null) return 'Pick time';
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  void pickDate(BuildContext context, {required bool isStart}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? startDate.value ?? DateTime.now()
          : endDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      if (isStart) {
        startDate.value = picked;
        startDateController.text = formatDate(picked);
      } else {
        endDate.value = picked;
        endDateController.text = formatDate(picked);
      }
    }
  }

  void pickTime(BuildContext context, {required bool isStart}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      if (isStart) {
        startTime.value = picked;
      } else {
        endTime.value = picked;
      }
    }
  }

  /// Calculates the duration between start and end datetime
  String get shiftDuration {
    if (startDate.value == null ||
        endDate.value == null ||
        startTime.value == null ||
        endTime.value == null) {
      return '--:--';
    }

    final start = DateTime(
      startDate.value!.year,
      startDate.value!.month,
      startDate.value!.day,
      startTime.value!.hour,
      startTime.value!.minute,
    );

    final end = DateTime(
      endDate.value!.year,
      endDate.value!.month,
      endDate.value!.day,
      endTime.value!.hour,
      endTime.value!.minute,
    );

    final diff = end.difference(start);
    if (diff.isNegative) return 'Invalid';

    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }
}





