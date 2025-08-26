// controllers/schedule_controller.dart
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jesusvlsco/core/common/widgets/custom_date_picker_widget.dart';
import 'package:jesusvlsco/features/assign_employee/service/project_service.dart';
import 'package:logger/logger.dart';

import '../models/project_model.dart';

class ScheduleController extends GetxController {
  final Logger _logger = Logger();
  final ProjectService _projectService = ProjectService();

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
    fetchProjects();
  }

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }

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

      _logger.i(
        'Fetching projects - Page: ${currentPage.value}, Limit: $pageLimit',
      ); // Added pageLimit logging

      final response = await _projectService.getAllProjects(
        page: currentPage.value,
        limit: pageLimit, // Make sure this is 5
      );

      _logger.i(
        'API Response - Success: ${response.success}, Data length: ${response.data.length}',
      );
      _logger.i(
        'Metadata - Page: ${response.metadata.page}, Limit: ${response.metadata.limit}, Total: ${response.metadata.total}, TotalPages: ${response.metadata.totalPage}',
      );

      if (response.success) {
        if (currentPage.value == 1) {
          projects.value = response.data;
        } else {
          projects.addAll(response.data);
        }

        totalProjects.value = response.metadata.total;
        totalPages.value = response.metadata.totalPage;

        // Check if there are more pages
        hasMoreProjects.value = currentPage.value < response.metadata.totalPage;

        _logger.i('Projects loaded: ${response.data.length}');
        _logger.i('Total projects in list: ${projects.length}');
        _logger.i('Has more: ${hasMoreProjects.value}');
      } else {
        EasyLoading.showError('Failed to load projects: ${response.message}');
      }
    } catch (e) {
      _logger.e('Error fetching projects: $e');
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

  void selectProject(ProjectModel project) {
    selectedProject.value = project;
    _logger.i('Selected project: ${project.title}');
    _logger.i('Selected id: ${project.id}');
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
}
