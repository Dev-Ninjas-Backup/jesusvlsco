import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/common/widgets/custom_date_picker_widget.dart';
import '../routes/scheduling_routes.dart';
import '../models/project_details_model.dart';
import '../services/project_api_service.dart';

/// AccessScheduleController manages the business logic for access schedule operations
/// This includes handling project details, employee schedules, time-off requests, and approved requests
class AccessScheduleController extends GetxController {
  final Logger _logger = Logger();
  final ProjectApiService _projectApiService = ProjectApiService();

  // Observable variables for state management
  var isLoading = false.obs;
  var showApprovedSection = false.obs;
  var selectedDate = DateTime.now().obs;
  
  // Project data variables
  var projectDetails = Rx<ProjectDetailsModel?>(null);
  var projectId = ''.obs;
  var projectName = ''.obs;
  var assignedEmployees = <ProjectUserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    
    // Get project data from navigation arguments
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      projectId.value = arguments['projectId'] ?? '';
      projectName.value = arguments['projectName'] ?? '';
      
      if (projectId.value.isNotEmpty) {
        loadProjectDetails();
      }
    }
  }

  /// Load project details from API including assigned employees
  Future<void> loadProjectDetails() async {
    try {
      isLoading.value = true;
      _logger.i('Loading project details for ID: ${projectId.value}');

      // Call API to fetch project details
      final response = await _projectApiService.getProjectById(
        projectId: projectId.value,
      );

      if (response.isSuccess) {
        final projectResponse = ProjectDetailsResponse.fromJson(response.responseData);
        projectDetails.value = projectResponse.data;
        assignedEmployees.value = projectResponse.data.projectUsers;
        
        // Update project name if available
        if (projectResponse.data.title.isNotEmpty) {
          projectName.value = projectResponse.data.title;
        }
        
        _logger.i('Successfully loaded project details for: ${projectResponse.data.title}');
        _logger.i('Found ${projectResponse.data.projectUsers.length} assigned employees');
      } else {
        _logger.e('Failed to load project details: ${response.errorMessage}');
        EasyLoading.showError(response.errorMessage);
      }

      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      _logger.e('Error loading project details: $error');
      EasyLoading.showError('Failed to load project details. Please try again.');
    }
  }

  /// Load schedule data from API or local storage
  Future<void> loadScheduleData() async {
    try {
      _logger.i('Refreshing schedule data');

      // Reload project details to get latest data
      await loadProjectDetails();
      
      _logger.i('Schedule data refreshed successfully');
    } catch (error) {
      _logger.e('Error loading schedule data: $error');
      EasyLoading.showError('Failed to refresh schedule data');
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

  /// Get project display name
  String get displayProjectName {
    return projectName.value.isNotEmpty ? projectName.value : 'Project Details';
  }

  /// Get assigned employees count
  int get assignedEmployeesCount {
    return assignedEmployees.length;
  }

  /// Get team information
  String get teamName {
    return projectDetails.value?.team.title ?? '';
  }

  /// Get manager information
  String get managerName {
    final manager = projectDetails.value?.manager;
    if (manager != null) {
      return '${manager.email}';
    }
    return '';
  }

  @override
  void onClose() {
    _logger.i('AccessScheduleController disposed');
    super.onClose();
  }
}
