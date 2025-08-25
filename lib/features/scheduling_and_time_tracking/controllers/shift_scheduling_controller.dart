import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/project_options_dialog.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/edit_project_dialog.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/delete_project_dialog.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/models/project_model.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/services/project_api_service.dart';
import '../routes/scheduling_routes.dart';

/// TimeSheetController manages the business logic for time sheet operations
/// This includes handling project management and API calls
class TimeSheetController extends GetxController {
  final Logger _logger = Logger();
  final ProjectApiService _projectApiService = ProjectApiService();

  // Observable variables for state management
  var isLoading = false.obs;
  var searchText = ''.obs;
  var projects = <ProjectModel>[].obs;
  var editingProject = Rx<ProjectModel?>(null);
  
  // Pagination variables
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var isLoadingMore = false.obs;
  var hasMoreData = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadProjects();
  }

  /// Load all projects from API
  Future<void> loadProjects({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        currentPage.value = 1;
        hasMoreData.value = true;
      }
      
      isLoading.value = true;
      _logger.i('Loading projects from API - Page: ${currentPage.value}');

      // Call API to fetch projects
      final response = await _projectApiService.getAllAdminProjects(
        page: currentPage.value,
        limit: 10,
        token: 'Bearer your_token_here', // TODO: Get token from storage
      );

      if (response.isSuccess) {
        final projectResponse = ProjectApiResponse.fromJson(response.responseData);
        
        if (isRefresh) {
          projects.value = projectResponse.data.projects;
        } else {
          projects.addAll(projectResponse.data.projects);
        }
        
        // Update pagination info
        totalPages.value = projectResponse.data.meta.pages;
        hasMoreData.value = currentPage.value < totalPages.value;
        
        _logger.i('Successfully loaded ${projectResponse.data.projects.length} projects');
      } else {
        _logger.e('Failed to load projects: ${response.errorMessage}');
        EasyLoading.showError(response.errorMessage);
      }

      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      _logger.e('Error loading projects: $error');
      EasyLoading.showError('Failed to load projects. Please try again.');
    }
  }

  /// Load more projects for pagination
  Future<void> loadMoreProjects() async {
    if (isLoadingMore.value || !hasMoreData.value) return;
    
    try {
      isLoadingMore.value = true;
      currentPage.value++;
      
      _logger.i('Loading more projects - Page: ${currentPage.value}');

      final response = await _projectApiService.getAllAdminProjects(
        page: currentPage.value,
        limit: 10,
        token: 'Bearer your_token_here', // TODO: Get token from storage
      );

      if (response.isSuccess) {
        final projectResponse = ProjectApiResponse.fromJson(response.responseData);
        projects.addAll(projectResponse.data.projects);
        
        hasMoreData.value = currentPage.value < projectResponse.data.meta.pages;
        _logger.i('Successfully loaded ${projectResponse.data.projects.length} more projects');
      } else {
        currentPage.value--; // Revert page increment on failure
        _logger.e('Failed to load more projects: ${response.errorMessage}');
        EasyLoading.showError(response.errorMessage);
      }

      isLoadingMore.value = false;
    } catch (error) {
      isLoadingMore.value = false;
      currentPage.value--; // Revert page increment on failure
      _logger.e('Error loading more projects: $error');
      EasyLoading.showError('Failed to load more projects. Please try again.');
    }
  }

  /// Refresh projects list
  Future<void> refreshProjects() async {
    await loadProjects(isRefresh: true);
  }

  /// Handle search functionality
  void updateSearchText(String text) {
    searchText.value = text;
  }

  /// Get filtered projects based on search text
  List<ProjectModel> get filteredProjects {
    if (searchText.value.isEmpty) {
      return projects;
    }
    return projects
        .where(
          (project) =>
              project.title.toLowerCase().contains(
                searchText.value.toLowerCase(),
              ) ||
              project.projectLocation.toLowerCase().contains(
                searchText.value.toLowerCase(),
              ) ||
              project.team.title.toLowerCase().contains(
                searchText.value.toLowerCase(),
              ),
        )
        .toList();
  }

  /// Show options dialog for project actions
  void showProjectOptions(ProjectModel project) {
    editingProject.value = project;
    Get.dialog(const ProjectOptionsDialog(), barrierDismissible: true);
  }

  /// Show edit dialog for project
  void showEditDialog() {
    Get.dialog(const EditProjectDialog(), barrierDismissible: false);
  }

  /// Show delete confirmation dialog
  void showDeleteDialog() {
    Get.dialog(const DeleteProjectDialog(), barrierDismissible: false);
  }

  /// Update project title using API
  Future<void> updateProjectTitle(String newTitle) async {
    try {
      if (editingProject.value == null) return;
      
      EasyLoading.show(status: 'Updating...');

      final response = await _projectApiService.updateProjectTitle(
        projectId: editingProject.value!.id,
        newTitle: newTitle,
        token: 'Bearer your_token_here', // TODO: Get token from storage
      );

      if (response.isSuccess) {
        // Update local project data
        final index = projects.indexWhere(
          (p) => p.id == editingProject.value!.id,
        );
        if (index != -1) {
          projects[index] = projects[index].copyWith(title: newTitle);
          projects.refresh();
        }
        
        EasyLoading.showSuccess('Project updated successfully');
        SchedulingRoutes.back(); // Close edit dialog
        SchedulingRoutes.back(); // Close options dialog
      } else {
        EasyLoading.showError(response.errorMessage);
      }
    } catch (error) {
      _logger.e('Error updating project: $error');
      EasyLoading.showError('Failed to update project. Please try again.');
    }
  }

  /// Delete project using API
  Future<void> deleteProject() async {
    try {
      if (editingProject.value == null) return;
      
      EasyLoading.show(status: 'Deleting...');

      final response = await _projectApiService.deleteProjectById(
        projectId: editingProject.value!.id,
        token: 'Bearer your_token_here', // TODO: Get token from storage
      );

      if (response.isSuccess) {
        // Remove project from local list
        projects.removeWhere((p) => p.id == editingProject.value!.id);
        projects.refresh();
        
        EasyLoading.showSuccess('Project deleted successfully');
        SchedulingRoutes.back(); // Close delete dialog
        SchedulingRoutes.back(); // Close options dialog
      } else {
        EasyLoading.showError(response.errorMessage);
      }
    } catch (error) {
      _logger.e('Error deleting project: $error');
      EasyLoading.showError('Failed to delete project. Please try again.');
    }
  }

  /// Navigate to project schedule
  void accessSchedule(ProjectModel project, BuildContext context) {
    _logger.i('Accessing schedule for project: ${project.title}');
    // Navigate to access schedule screen using GetX routes
    SchedulingRoutes.toAccessSchedule(arguments: {
      'projectId': project.id,
      'projectName': project.title,
    });
  }

  /// Add new project - Navigate to Add Project Screen
  void addNewProject(BuildContext context) {
    _logger.i('Navigating to Add Project screen');
    // Use GetX routes for navigation
    SchedulingRoutes.toAddProject();
  }
}

