import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTimeOffController extends GetxController {
  final types = <String>['Sick leave', 'Annual leave', 'Unpaid leave'].obs;
  final selectedType = 'Sick leave'.obs;
  final isAllDay = true.obs;

  final selectedDate = DateTime.now().obs;
  final totalDays = '1.00 work days'.obs;

  final noteController = TextEditingController();

  void selectType(String type) => selectedType.value = type;

  void toggleAllDay(bool value) {
    isAllDay.value = value;
    _recalculateTotal();
  }

  Future<void> pickDate() async {
    final ctx = Get.context;
    if (ctx == null) return;
    final picked = await showDatePicker(
      context: ctx,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      selectedDate.value = picked;
      _recalculateTotal();
    }
  }

  void _recalculateTotal() {
    // Always 1 day for single date selection
    totalDays.value = '1.00 work days';
  }

  void sendForApproval() {
    // Placeholder: show a snackbar. Integrate backend here.
    Get.snackbar(
      'Request sent',
      'Time off request sent for approval',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }
}
