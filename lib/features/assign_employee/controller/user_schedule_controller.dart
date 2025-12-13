import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jesusvlsco/core/common/widgets/custom_date_picker_widget.dart';
import 'package:jesusvlsco/features/assign_employee/models/assign_user_response_model.dart';
import 'package:jesusvlsco/features/assign_employee/service/assigned_users_service.dart';
import 'package:jesusvlsco/features/assign_employee/service/project_service.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/models/project_model.dart';
import 'package:jesusvlsco/features/splasho_screen/controller/splasho_controller.dart';
import 'package:logger/logger.dart';

class ScheduleController extends GetxController {
  final Logger _logger = Logger();
  final ProjectService projectService = ProjectService();
  AssignedUsersService? _assignedUsersService;
  final SplashController _splashController = Get.find();

  var assignedUsers = <AssignedUserData>[].obs;
  var isLoadingAssignedUsers = false.obs;

  // Dropdown values
  var dropdownValue = "Everyone".obs;
  final dropdownItems = ["Everyone", "Only Me"];

  // Project selection
  var selectedProject = Rx<ProjectModel?>(null);
  var projects = <ProjectModel>[].obs;
  var isLoading = false.obs;

  // Pagination variables
  var currentPage = 1.obs;
  var hasMoreProjects = true.obs;
  var isLoadingMoreProjects = false.obs;
  var totalProjects = 0.obs;
  var totalPages = 0.obs;
  final int pageLimit = 5;

  // Date selection
  var selectedStartDate = Rx<DateTime?>(null);
  var selectedEndDate = Rx<DateTime?>(null);
  var selectedDate = DateTime.now().obs;

  // Time selection
  var startTime = TimeOfDay(hour: 9, minute: 0).obs;
  var endTime = TimeOfDay(hour: 17, minute: 0).obs;

  // Notes
  TextEditingController notesController = TextEditingController();

  // Toggle
  var unavailableAllDay = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initRepository();
    fetchProjects();
  }

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }

  Future<void> _initRepository() async {
    await _splashController.getAuthToken();
    _assignedUsersService = AssignedUsersService();
    _logger.i("Repository initialized with token");
  }

  // Inside schedule_controller.dart – replace only this method

  Future<void> fetchProjects({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        currentPage.value = 1;
        projects.clear();
        hasMoreProjects.value = true;
      }

      if (isLoading.value || isLoadingMoreProjects.value) return;

      if (currentPage.value == 1) {
        isLoading.value = true;
      } else {
        isLoadingMoreProjects.value = true;
      }

      _logger.i('Fetching user assigned projects from shift-schedule API');

      final response = await projectService.getUserAssignedProjects();

      if (response.success) {
        final List<ProjectModel> userProjects = response.data.projectWithShifts
            .map((item) {
              final project = item.project;
              return ProjectModel(
                id: project.id,
                title: project.title,
                projectLocation: project.location,
                teamId: '', // required field – safe to leave empty
                // All other fields are now optional – no need to pass them
              );
            })
            .toList();

        if (currentPage.value == 1) {
          projects.value = userProjects;
        } else {
          projects.addAll(userProjects);
        }

        totalProjects.value = userProjects.length;
        totalPages.value = 1;
        hasMoreProjects.value = false;

        _logger.i('Loaded ${projects.length} projects for current user');
      } else {
        EasyLoading.showError('Failed to load projects: ${response.message}');
      }
    } catch (e) {
      _logger.e('Error fetching user projects: $e');
      EasyLoading.showError('Failed to load projects');
    } finally {
      isLoading.value = false;
      isLoadingMoreProjects.value = false;
    }
  }

  Future<void> loadMoreProjects() async {
    if (!hasMoreProjects.value || isLoadingMoreProjects.value) {
      return;
    }

    currentPage.value++;
    await fetchProjects();
  }

  Future<void> refreshProjects() async {
    await fetchProjects(isRefresh: true);
  }

  Future<void> selectProject(ProjectModel project) async {
    selectedProject.value = project;
    _logger.i('Selected project: ${project.title}');
    _logger.i('Selected id: ${project.id}');

    // Fetch assigned users when project is selected
    await fetchAssignedUsers();
  }

  Future<void> fetchAssignedUsers() async {
    if (selectedProject.value == null) {
      _logger.w('No project selected for fetching assigned users');
      return;
    }

    if (_assignedUsersService == null) {
      _logger.w('Assigned users service not initialized');
      return;
    }

    try {
      isLoadingAssignedUsers.value = true;

      final response = await _assignedUsersService!.getAssignedUsers(
        projectId: selectedProject.value!.id,
        startDate: selectedStartDate.value,
        endDate: selectedEndDate.value,
      );

      if (response.success) {
        assignedUsers.value = response.data;
        _logger.i('Assigned users loaded: ${response.data.length}');
      } else {
        _logger.e('Failed to load assigned users: ${response.message}');
        EasyLoading.showError('Failed to load assigned users');
      }
    } catch (e) {
      _logger.e('Error fetching assigned users: $e');
      EasyLoading.showError('Failed to load assigned users');
    } finally {
      isLoadingAssignedUsers.value = false;
    }
  }

  Future<void> onDatePressed() async {
    try {
      _logger.i('Date button pressed');

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
      }
    } catch (error) {
      _logger.e('Error showing date picker: $error');
      EasyLoading.showError('Failed to show date picker');
    }
  }

  Future<void> onDateRangePressed() async {
    try {
      _logger.i('Date range button pressed');

      final DateTimeRange? pickedRange = await showDateRangePicker(
        context: Get.context!,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        initialDateRange:
            (selectedStartDate.value != null && selectedEndDate.value != null)
            ? DateTimeRange(
                start: selectedStartDate.value!,
                end: selectedEndDate.value!,
              )
            : null,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xFF4E53B1), // Your primary color
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedRange != null) {
        selectedStartDate.value = pickedRange.start;
        selectedEndDate.value = pickedRange.end;

        _logger.i(
          'Date range selected: ${DateFormat('yyyy-MM-dd').format(pickedRange.start)} to ${DateFormat('yyyy-MM-dd').format(pickedRange.end)}',
        );

        EasyLoading.showSuccess(
          'Date range: ${DateFormat('MMM dd').format(pickedRange.start)} - ${DateFormat('MMM dd, yyyy').format(pickedRange.end)}',
        );

        // Refresh assigned users with date filter if project is selected
        if (selectedProject.value != null) {
          await fetchAssignedUsers();
        }
      }
    } catch (error) {
      _logger.e('Error showing date range picker: $error');
      EasyLoading.showError('Failed to show date range picker');
    }
  }

  void clearDateRange() {
    selectedStartDate.value = null;
    selectedEndDate.value = null;

    // Refresh assigned users without date filter if project is selected
    if (selectedProject.value != null) {
      fetchAssignedUsers();
    }
  }

  String get dateRangeText {
    if (selectedStartDate.value != null && selectedEndDate.value != null) {
      return '${DateFormat('MMM dd').format(selectedStartDate.value!)} - ${DateFormat('MMM dd').format(selectedEndDate.value!)}';
    }
    return 'Select Date Range';
  }

  bool get hasDateRange {
    return selectedStartDate.value != null && selectedEndDate.value != null;
  }

  void clearSelection() {
    selectedProject.value = null;
  }

  // Mock employee data (keeping your existing data)
  var employees = [
    {
      "name": "Sarah Johnson",
      "role": "Manager",
      "offDay": "Friday",
      "image": "https://randomuser.me/api/portraits/women/44.jpg",
    },
    {
      "name": "Emma Willson",
      "role": "Manager",
      "offDay": "Friday",
      "image": "https://randomuser.me/api/portraits/women/45.jpg",
    },
  ];
}
