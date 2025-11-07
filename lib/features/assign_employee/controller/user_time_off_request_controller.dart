// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jesusvlsco/features/assign_employee/models/user_time_off_request_model.dart';
import 'package:jesusvlsco/features/assign_employee/repository/user_time_off_repository.dart';
import 'package:jesusvlsco/features/splasho_screen/controller/splasho_controller.dart';
import 'package:logger/logger.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

enum TimeOffRequestType { UNPAID, SICK_LEAVE, CASUAL_LEAVE, TIME_OFF }

class TimeOffController extends GetxController {
  final Logger _logger = Logger();

  late TimeOffRepository repository;
  final SplashController splashController = Get.find();

  // Observables
  var isFullDayOff = false.obs;
  var selectedStartDate = DateTime.now().obs;
  var selectedEndDate = DateTime.now().obs;
  var totalDaysOff = 0.obs;
  var selectedType = TimeOffRequestType.SICK_LEAVE.obs;
  TextEditingController reasonController = TextEditingController();

  var isSubmitting = false.obs;
  var lastRequest = Rx<TimeOffRequestModel?>(null);

  @override
  void onInit() {
    super.onInit();
    _initRepository();
  }

  Future<void> _initRepository() async {
    final token = await splashController.getAuthToken();
    repository = TimeOffRepository(token: token!);
    _logger.i("Repository initialized with token");
  }

  void setStartDate(DateTime date) {
    selectedStartDate.value = date;
    _recalculateDays();
  }

  void setEndDate(DateTime date) {
    selectedEndDate.value = date;
    _recalculateDays();
  }

  void _recalculateDays() {
    if (selectedEndDate.value.isBefore(selectedStartDate.value)) {
      totalDaysOff.value = 0;
      return;
    }
    totalDaysOff.value =
        selectedEndDate.value.difference(selectedStartDate.value).inDays + 1;
    _logger.i("Total days off calculated: ${totalDaysOff.value}");
  }

  Future<void> submitTimeOffRequest() async {
    if (reasonController.text.trim().isEmpty) {
      EasyLoading.showError("Reason is required");
      return;
    }
    if (totalDaysOff.value <= 0) {
      EasyLoading.showError("Invalid date range");
      return;
    }

    try {
      isSubmitting.value = true;
      EasyLoading.show(status: "Submitting...");

      final model = await repository.createTimeOffRequest(
        startDate: DateFormat("yyyy-MM-dd").format(selectedStartDate.value),
        endDate: DateFormat("yyyy-MM-dd").format(selectedEndDate.value),
        reason: reasonController.text.trim(),
        type: selectedType.value.name,
        isFullDayOff: isFullDayOff.value,
        totalDaysOff: totalDaysOff.value,
      );

      lastRequest.value = model;
      EasyLoading.showSuccess("Request created successfully!");
      _logger.i("Time off request created: ${lastRequest.value!.id}");
      Get.back();
    } catch (e) {
      _logger.e("Error submitting time off request: $e");
      EasyLoading.showError(e.toString());
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    reasonController.dispose();
    super.onClose();
  }
}
