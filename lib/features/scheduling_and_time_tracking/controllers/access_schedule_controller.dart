import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/common/widgets/custom_date_picker_widget.dart';
import '../routes/scheduling_routes.dart';
import '../models/project_details_model.dart';
import '../services/project_api_service.dart';
import '../../../model/time_off_request_model.dart';

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

  // Time-off requests data variables
  var timeOffRequests = <TimeOffRequestData>[].obs;
  var timeOffCurrentPage = 1.obs;
  var timeOffTotalPages = 1.obs;
  var timeOffTotalItems = 0.obs;
  var isLoadingTimeOffRequests = false.obs;

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

    // Load time-off requests when controller initializes
    loadTimeOffRequests();
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
        final projectResponse = ProjectDetailsResponse.fromJson(
          response.responseData,
        );
        projectDetails.value = projectResponse.data;
        assignedEmployees.value = projectResponse.data.projectUsers;

        // Update project name if available
        if (projectResponse.data.title.isNotEmpty) {
          projectName.value = projectResponse.data.title;
        }

        _logger.i(
          'Successfully loaded project details for: ${projectResponse.data.title}',
        );
        _logger.i(
          'Found ${projectResponse.data.projectUsers.length} assigned employees',
        );
      } else {
        _logger.e('Failed to load project details: ${response.errorMessage}');
        EasyLoading.showError(response.errorMessage);
      }

      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      _logger.e('Error loading project details: $error');
      EasyLoading.showError(
        'Failed to load project details. Please try again.',
      );
    }
  }

  /// Load schedule data from API or local storage
  Future<void> loadScheduleData() async {
    try {
      _logger.i('Refreshing schedule data');

      // Reload project details to get latest data
      await loadProjectDetails();

      // Reload time-off requests
      await loadTimeOffRequests();

      _logger.i('Schedule data refreshed successfully');
    } catch (error) {
      _logger.e('Error loading schedule data: $error');
      EasyLoading.showError('Failed to refresh schedule data');
    }
  }

  /// Load time-off requests with pagination
  /// [page] - Page number to load (default: 1)
  /// [refresh] - Whether to refresh data from first page (default: false)
  Future<void> loadTimeOffRequests({int page = 1, bool refresh = false}) async {
    try {
      if (refresh) {
        timeOffCurrentPage.value = 1;
        timeOffRequests.clear();
      }

      isLoadingTimeOffRequests.value = true;
      _logger.i('Loading time-off requests: Page $page');

      // Call API to fetch time-off requests
      final response = await _projectApiService.getAllTimeOffRequests(
        page: page,
        limit: 15, // 15 items per page as requested
      );

      _logger.i('Time-off requests API response: ${response.isSuccess}');
      _logger.i('Response data: ${response.responseData}');

      if (response.isSuccess) {
        final timeOffResponse = TimeOffRequestModel.fromJson(
          response.responseData,
        );

        if (refresh || page == 1) {
          // Replace all data for refresh or first page
          timeOffRequests.value = timeOffResponse.data;
        } else {
          // Append data for pagination
          timeOffRequests.addAll(timeOffResponse.data);
        }

        // Update pagination metadata
        timeOffCurrentPage.value = timeOffResponse.metadata.page;
        timeOffTotalPages.value = timeOffResponse.metadata.totalPage;
        timeOffTotalItems.value = timeOffResponse.metadata.total;

        _logger.i(
          'Successfully loaded ${timeOffResponse.data.length} time-off requests',
        );
        _logger.i(
          'Total requests: ${timeOffResponse.metadata.total}, Page: ${timeOffResponse.metadata.page}/${timeOffResponse.metadata.totalPage}',
        );
        _logger.i('Current timeOffRequests count: ${timeOffRequests.length}');
      } else {
        _logger.e('Failed to load time-off requests: ${response.errorMessage}');
        EasyLoading.showError(response.errorMessage);
      }

      isLoadingTimeOffRequests.value = false;
    } catch (error) {
      isLoadingTimeOffRequests.value = false;
      _logger.e('Error loading time-off requests: $error');
      EasyLoading.showError(
        'Failed to load time-off requests. Please try again.',
      );
    }
  }

  /// Load next page of time-off requests
  Future<void> loadMoreTimeOffRequests() async {
    if (timeOffCurrentPage.value < timeOffTotalPages.value &&
        !isLoadingTimeOffRequests.value) {
      await loadTimeOffRequests(page: timeOffCurrentPage.value + 1);
    }
  }

  /// Approve a time-off request
  /// [requestId] - ID of the request to approve
  /// [adminNote] - Optional admin note
  Future<void> approveTimeOffRequest({
    required String requestId,
    String? adminNote,
  }) async {
    try {
      EasyLoading.show(status: 'Approving request...');
      _logger.i('Approving time-off request: $requestId');

      // Call API to approve request
      final response = await _projectApiService.updateTimeOffRequestStatus(
        requestId: requestId,
        status: TimeOffRequestStatus.APPROVED.apiValue,
        adminNote: adminNote,
      );

      EasyLoading.dismiss();

      if (response.isSuccess) {
        _logger.i('Successfully approved time-off request: $requestId');
        EasyLoading.showSuccess('Request approved successfully');

        // Update local data
        final requestIndex = timeOffRequests.indexWhere(
          (req) => req.id == requestId,
        );
        if (requestIndex != -1) {
          final updatedRequest = timeOffRequests[requestIndex];
          // Create a new object with updated status
          timeOffRequests[requestIndex] = TimeOffRequestData(
            id: updatedRequest.id,
            userId: updatedRequest.userId,
            startDate: updatedRequest.startDate,
            endDate: updatedRequest.endDate,
            reason: updatedRequest.reason,
            type: updatedRequest.type,
            isFullDayOff: updatedRequest.isFullDayOff,
            totalDaysOff: updatedRequest.totalDaysOff,
            status: TimeOffRequestStatus.APPROVED,
            adminNote: adminNote,
            createdAt: updatedRequest.createdAt,
            updatedAt: DateTime.now(),
            user: updatedRequest.user,
          );
          timeOffRequests.refresh();
        }

        // Show approved section when request is approved
        showApprovedSection.value = true;
      } else {
        _logger.e(
          'Failed to approve time-off request: ${response.errorMessage}',
        );
        EasyLoading.showError(response.errorMessage);
      }
    } catch (error) {
      EasyLoading.dismiss();
      _logger.e('Error approving time-off request: $error');
      EasyLoading.showError('Failed to approve request. Please try again.');
    }
  }

  /// Reject a time-off request
  /// [requestId] - ID of the request to reject
  /// [adminNote] - Optional admin note explaining rejection
  Future<void> rejectTimeOffRequest({
    required String requestId,
    String? adminNote,
  }) async {
    try {
      EasyLoading.show(status: 'Rejecting request...');
      _logger.i('Rejecting time-off request: $requestId');

      // Call API to reject request
      final response = await _projectApiService.updateTimeOffRequestStatus(
        requestId: requestId,
        status: TimeOffRequestStatus.REJECTED.apiValue,
        adminNote: adminNote,
      );

      EasyLoading.dismiss();

      if (response.isSuccess) {
        _logger.i('Successfully rejected time-off request: $requestId');
        EasyLoading.showSuccess('Request rejected');

        // Update local data
        final requestIndex = timeOffRequests.indexWhere(
          (req) => req.id == requestId,
        );
        if (requestIndex != -1) {
          final updatedRequest = timeOffRequests[requestIndex];
          // Create a new object with updated status
          timeOffRequests[requestIndex] = TimeOffRequestData(
            id: updatedRequest.id,
            userId: updatedRequest.userId,
            startDate: updatedRequest.startDate,
            endDate: updatedRequest.endDate,
            reason: updatedRequest.reason,
            type: updatedRequest.type,
            isFullDayOff: updatedRequest.isFullDayOff,
            totalDaysOff: updatedRequest.totalDaysOff,
            status: TimeOffRequestStatus.REJECTED,
            adminNote: adminNote,
            createdAt: updatedRequest.createdAt,
            updatedAt: DateTime.now(),
            user: updatedRequest.user,
          );
          timeOffRequests.refresh();
        }
      } else {
        _logger.e(
          'Failed to reject time-off request: ${response.errorMessage}',
        );
        EasyLoading.showError(response.errorMessage);
      }
    } catch (error) {
      EasyLoading.dismiss();
      _logger.e('Error rejecting time-off request: $error');
      EasyLoading.showError('Failed to reject request. Please try again.');
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
    // Note: In future, this will show approved requests list
    // For now, we just toggle the section visibility
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
      return manager.email;
    }
    return '';
  }

  /// Get pending time-off requests count
  int get pendingTimeOffRequestsCount {
    return timeOffRequests
        .where((req) => req.status == TimeOffRequestStatus.PENDING)
        .length;
  }

  /// Get approved time-off requests count
  int get approvedTimeOffRequestsCount {
    return timeOffRequests
        .where((req) => req.status == TimeOffRequestStatus.APPROVED)
        .length;
  }

  /// Get rejected time-off requests count
  int get rejectedTimeOffRequestsCount {
    return timeOffRequests
        .where((req) => req.status == TimeOffRequestStatus.REJECTED)
        .length;
  }

  /// Check if has more time-off requests to load
  bool get hasMoreTimeOffRequests {
    return timeOffCurrentPage.value < timeOffTotalPages.value;
  }

  @override
  void onClose() {
    _logger.i('AccessScheduleController disposed');
    super.onClose();
  }
}
