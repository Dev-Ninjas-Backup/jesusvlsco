import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/common/widgets/custom_date_picker_widget.dart';
import '../routes/scheduling_routes.dart';

/// AccessScheduleController manages the business logic for access schedule operations
/// This includes handling employee schedules, time-off requests, and approved requests
class AccessScheduleController extends GetxController {
  final Logger _logger = Logger();

  // Observable variables for state management
  var isLoading = false.obs;
  var showApprovedSection = false.obs;
  var selectedProject = Rx<String?>(null);
  var selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    loadScheduleData();
  }

  /// Load schedule data from API or local storage
  Future<void> loadScheduleData() async {
    try {
      isLoading.value = true;
      _logger.i('Loading access schedule data');

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 800));

      // In real implementation, load data from API
      // Example: await _apiService.getAccessSchedule();

      isLoading.value = false;
      _logger.i('Access schedule data loaded successfully');
    } catch (error) {
      isLoading.value = false;
      _logger.e('Error loading schedule data: $error');
      EasyLoading.showError('Failed to load schedule data');
    }
  }

  /// Toggle the approved requests section visibility
  void toggleApprovedSection() {
    showApprovedSection.value = !showApprovedSection.value;
    _logger.i('Approved section toggled: ${showApprovedSection.value}');
  }

  /// Handle approve button press for time-off requests
  void onApprovePressed() {
    _logger.i('Approve button pressed');
    toggleApprovedSection();
    EasyLoading.showSuccess('Request approved successfully');
  }

  /// Handle decline button press for time-off requests
  void onDeclinePressed() {
    _logger.i('Decline button pressed');
    EasyLoading.showInfo('Request declined');
  }

  /// Handle assign button press
  void onAssignPressed(BuildContext context) {
    _logger.i('Assign button pressed');
    // Navigate to assign employee screen using GetX routes
    SchedulingRoutes.toAssignEmployee();
  }

  /// Handle date picker button press
  Future<void> onDatePressed() async {
    try {
      _logger.i('Date picker button pressed');

      final DateTime? pickedDate = await CustomDatePicker.show(
        context: Get.context!,
        initialDate: selectedDate.value,
      );

      if (pickedDate != null) {
        selectedDate.value = pickedDate;
        _logger.i(
          'Date selected: ${DateFormat('yyyy-MM-dd').format(pickedDate)}',
        );
        EasyLoading.showSuccess(
          'Date selected: ${DateFormat('MMM dd, yyyy').format(pickedDate)}',
        );
        // Reload schedule data for selected date
        await loadScheduleData();
      }
    } catch (error) {
      _logger.e('Error showing date picker: $error');
      EasyLoading.showError('Failed to show date picker');
    }
  }

  /// Handle refresh button press
  Future<void> onRefreshPressed() async {
    _logger.i('Refresh button pressed');
    await loadScheduleData();
    EasyLoading.showSuccess('Data refreshed successfully');
  }

  /// Navigate back to previous screen
  void navigateBack() {
    _logger.i('Navigating back from access schedule');
    SchedulingRoutes.back();
  }

  /// Handle menu button press
  void onMenuPressed() {
    _logger.i('Menu button pressed');
    EasyLoading.showInfo('Menu functionality not implemented yet');
  }

  /// Set selected project for context
  void setSelectedProject(String projectId) {
    selectedProject.value = projectId;
    _logger.i('Selected project set: $projectId');
  }

  @override
  void onClose() {
    _logger.i('AccessScheduleController disposed');
    super.onClose();
  }
}
