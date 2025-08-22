import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddShiftController extends GetxController {
  final projects = <String>[
    'Metro Shopping Center',
    'City Mall',
    'Central Park',
  ].obs;
  final selectedProject = 'Metro Shopping Center'.obs;

  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().add(const Duration(hours: 8)).obs;
  final startTime = TimeOfDay(hour: 9, minute: 0).obs;
  final endTime = TimeOfDay(hour: 17, minute: 0).obs;

  final noteController = TextEditingController();

  RxString totalHours = '08:00'.obs;

  @override
  void onInit() {
    super.onInit();
    _recalculateTotal();
  }

  void selectProject(String value) {
    selectedProject.value = value;
  }

  Future<void> pickStartDate() async {
    final ctx = Get.context;
    if (ctx == null) return;
    final picked = await showDatePicker(
      context: ctx,
      initialDate: startDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      startDate.value = picked;
      _recalculateTotal();
    }
  }

  Future<void> pickEndDate() async {
    final ctx = Get.context;
    if (ctx == null) return;
    final picked = await showDatePicker(
      context: ctx,
      initialDate: endDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      endDate.value = picked;
      _recalculateTotal();
    }
  }

  Future<void> pickStartTime() async {
    final ctx = Get.context;
    if (ctx == null) return;
    final picked = await showTimePicker(
      context: ctx,
      initialTime: startTime.value,
    );
    if (picked != null) {
      startTime.value = picked;
      _recalculateTotal();
    }
  }

  Future<void> pickEndTime() async {
    final ctx = Get.context;
    if (ctx == null) return;
    final picked = await showTimePicker(
      context: ctx,
      initialTime: endTime.value,
    );
    if (picked != null) {
      endTime.value = picked;
      _recalculateTotal();
    }
  }

  void _recalculateTotal() {
    try {
      final s = DateTime(
        startDate.value.year,
        startDate.value.month,
        startDate.value.day,
        startTime.value.hour,
        startTime.value.minute,
      );
      var e = DateTime(
        endDate.value.year,
        endDate.value.month,
        endDate.value.day,
        endTime.value.hour,
        endTime.value.minute,
      );
      // If end is before start, assume next day
      if (e.isBefore(s)) {
        e = e.add(const Duration(days: 1));
      }
      final diff = e.difference(s);
      final hours = diff.inHours;
      final minutes = diff.inMinutes.remainder(60);
      totalHours.value =
          '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
    } catch (_) {
      totalHours.value = '00:00';
    }
  }

  Future<void> sendForApproval() async {
    // Minimal placeholder behavior: validate and show snackbar
    if (selectedProject.value.isEmpty) {
      Get.snackbar('Validation', 'Please select a project');
      return;
    }

    // Simulate save
    Get.snackbar('Success', 'Shift sent for approval');
  }

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }
}
