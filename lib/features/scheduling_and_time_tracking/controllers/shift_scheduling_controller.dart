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

  // Search variables
  var isSearching = false.obs;
  var searchCurrentPage = 1.obs;
  var searchTotalPages = 1.obs;
  var searchHasMoreData = true.obs;

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
      );

      if (response.isSuccess) {
        final projectResponse = ProjectApiResponse.fromJson(
          response.responseData,
        );

        if (isRefresh) {
          projects.value = projectResponse.data.projects;
        } else {
          projects.addAll(projectResponse.data.projects);
        }

        // Update pagination info
        totalPages.value = projectResponse.data.meta.pages;
        hasMoreData.value = currentPage.value < totalPages.value;

        _logger.i(
          'Successfully loaded ${projectResponse.data.projects.length} projects',
        );
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
    // If searching, load more search results
    if (isSearching.value) {
      return loadMoreSearchResults();
    }

    // Otherwise load more normal projects
    if (isLoadingMore.value || !hasMoreData.value) return;

    try {
      isLoadingMore.value = true;
      currentPage.value++;

      _logger.i('Loading more projects - Page: ${currentPage.value}');

      final response = await _projectApiService.getAllAdminProjects(
        page: currentPage.value,
        limit: 10,
      );

      if (response.isSuccess) {
        final projectResponse = ProjectApiResponse.fromJson(
          response.responseData,
        );
        projects.addAll(projectResponse.data.projects);

        hasMoreData.value = currentPage.value < projectResponse.data.meta.pages;
        _logger.i(
          'Successfully loaded ${projectResponse.data.projects.length} more projects',
        );
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
    if (isSearching.value && searchText.value.trim().isNotEmpty) {
      // Refresh search results
      await _performSearch(searchText.value.trim(), isRefresh: true);
    } else {
      // Refresh normal projects
      isSearching.value = false;
      await loadProjects(isRefresh: true);
    }
  }

  /// Handle search functionality
  void updateSearchText(String text) {
    searchText.value = text;

    if (text.trim().isEmpty) {
      // If search is cleared, load normal projects
      isSearching.value = false;
      loadProjects(isRefresh: true);
    } else {
      // Start searching with API
      isSearching.value = true;
      searchCurrentPage.value = 1;
      searchHasMoreData.value = true;
      _performSearch(text.trim(), isRefresh: true);
    }
  }

  /// Perform search using API
  Future<void> _performSearch(String keyword, {bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        searchCurrentPage.value = 1;
        searchHasMoreData.value = true;
      }

      isLoading.value = true;
      _logger.i(
        'Searching projects: "$keyword" - Page: ${searchCurrentPage.value}',
      );

      final response = await _projectApiService.searchProjects(
        keyword: keyword,
        page: searchCurrentPage.value,
        limit: 10,
      );

      if (response.isSuccess) {
        final projectResponse = ProjectApiResponse.fromJson(
          response.responseData,
        );

        if (isRefresh) {
          projects.value = projectResponse.data.projects;
        } else {
          projects.addAll(projectResponse.data.projects);
        }

        // Update search pagination info
        searchTotalPages.value = projectResponse.data.meta.pages;
        searchHasMoreData.value =
            searchCurrentPage.value < searchTotalPages.value;

        _logger.i(
          'Successfully found ${projectResponse.data.projects.length} projects for "$keyword"',
        );
      } else {
        _logger.e('Failed to search projects: ${response.errorMessage}');
        EasyLoading.showError(response.errorMessage);
      }

      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      _logger.e('Error searching projects: $error');
      EasyLoading.showError('Failed to search projects. Please try again.');
    }
  }

  /// Load more search results for pagination
  Future<void> loadMoreSearchResults() async {
    if (isLoadingMore.value ||
        !searchHasMoreData.value ||
        searchText.value.trim().isEmpty) {
      return;
    }

    try {
      isLoadingMore.value = true;
      searchCurrentPage.value++;

      _logger.i(
        'Loading more search results - Page: ${searchCurrentPage.value}',
      );

      final response = await _projectApiService.searchProjects(
        keyword: searchText.value.trim(),
        page: searchCurrentPage.value,
        limit: 10,
      );

      if (response.isSuccess) {
        final projectResponse = ProjectApiResponse.fromJson(
          response.responseData,
        );
        projects.addAll(projectResponse.data.projects);

        searchHasMoreData.value =
            searchCurrentPage.value < projectResponse.data.meta.pages;
        _logger.i(
          'Successfully loaded ${projectResponse.data.projects.length} more search results',
        );
      } else {
        searchCurrentPage.value--; // Revert page increment on failure
        _logger.e(
          'Failed to load more search results: ${response.errorMessage}',
        );
        EasyLoading.showError(response.errorMessage);
      }

      isLoadingMore.value = false;
    } catch (error) {
      isLoadingMore.value = false;
      searchCurrentPage.value--; // Revert page increment on failure
      _logger.e('Error loading more search results: $error');
      EasyLoading.showError(
        'Failed to load more search results. Please try again.',
      );
    }
  }

  /// Get filtered projects based on search text
  List<ProjectModel> get filteredProjects {
    // If we're using API search, return all projects as they're already filtered
    if (isSearching.value) {
      return projects;
    }

    // Local filtering for normal project list
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
    SchedulingRoutes.toAccessSchedule(
      arguments: {'projectId': project.id, 'projectName': project.title},
    );
  }

  /// Add new project - Navigate to Add Project Screen
  void addNewProject(BuildContext context) {
    _logger.i('Navigating to Add Project screen');
    // Use GetX routes for navigation
    SchedulingRoutes.toAddProject();
  }
}
