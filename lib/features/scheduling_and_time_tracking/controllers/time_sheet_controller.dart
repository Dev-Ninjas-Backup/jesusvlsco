import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/project_options_dialog.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/edit_project_dialog.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/delete_project_dialog.dart';
import '../routes/scheduling_routes.dart';

/// TimeSheetController manages the business logic for time sheet operations
/// This includes handling project management and dialog states
class TimeSheetController extends GetxController {
  final Logger _logger = Logger();

  // Observable variables for state management
  var isLoading = false.obs;
  var searchText = ''.obs;
  var projects = <ProjectModel>[].obs;
  var editingProject = Rx<ProjectModel?>(null);

  @override
  void onInit() {
    super.onInit();
    loadProjects();
  }

  /// Load all projects from API or local storage
  Future<void> loadProjects() async {
    try {
      isLoading.value = true;

      // Mock data for demonstration - replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      projects.value = [
        ProjectModel(
          id: '1',
          title: 'Job Scheduling',
          projectName: 'Project 1',
          assignedUsers: [
            UserModel(
              id: '1',
              name: 'John Doe',
              avatar: 'https://i.pravatar.cc/150?img=1',
            ),
            UserModel(
              id: '2',
              name: 'Jane Smith',
              avatar: 'https://i.pravatar.cc/150?img=2',
            ),
          ],
          adminUser: UserModel(
            id: '3',
            name: 'Admin User',
            avatar: 'https://i.pravatar.cc/150?img=3',
          ),
        ),
        ProjectModel(
          id: '2',
          title: 'Job Scheduling',
          projectName: 'Project 2',
          assignedUsers: [
            UserModel(
              id: '1',
              name: 'John Doe',
              avatar: 'https://i.pravatar.cc/150?img=1',
            ),
            UserModel(
              id: '2',
              name: 'Jane Smith',
              avatar: 'https://i.pravatar.cc/150?img=2',
            ),
          ],
          adminUser: UserModel(
            id: '3',
            name: 'Admin User',
            avatar: 'https://i.pravatar.cc/150?img=3',
          ),
        ),
        ProjectModel(
          id: '3',
          title: 'Job Scheduling',
          projectName: 'Project 3',
          assignedUsers: [
            UserModel(
              id: '1',
              name: 'John Doe',
              avatar: 'https://i.pravatar.cc/150?img=1',
            ),
            UserModel(
              id: '2',
              name: 'Jane Smith',
              avatar: 'https://i.pravatar.cc/150?img=2',
            ),
          ],
          adminUser: UserModel(
            id: '3',
            name: 'Admin User',
            avatar: 'https://i.pravatar.cc/150?img=3',
          ),
        ),
        ProjectModel(
          id: '4',
          title: 'Job Scheduling',
          projectName: 'Project 4',
          assignedUsers: [
            UserModel(
              id: '1',
              name: 'John Doe',
              avatar: 'https://i.pravatar.cc/150?img=1',
            ),
            UserModel(
              id: '2',
              name: 'Jane Smith',
              avatar: 'https://i.pravatar.cc/150?img=2',
            ),
          ],
          adminUser: UserModel(
            id: '3',
            name: 'Admin User',
            avatar: 'https://i.pravatar.cc/150?img=3',
          ),
        ),
      ];

      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      _logger.e('Error loading projects: $error');
      EasyLoading.showError('Failed to load projects');
    }
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
              project.projectName.toLowerCase().contains(
                searchText.value.toLowerCase(),
              ) ||
              project.title.toLowerCase().contains(
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

  /// Update project title
  Future<void> updateProjectTitle(String newTitle) async {
    try {
      EasyLoading.show(status: 'Updating...');

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 1000));

      if (editingProject.value != null) {
        final index = projects.indexWhere(
          (p) => p.id == editingProject.value!.id,
        );
        if (index != -1) {
          projects[index] = projects[index].copyWith(projectName: newTitle);
          projects.refresh();
        }
      }

      EasyLoading.showSuccess('Project updated successfully');
      SchedulingRoutes.back(); // Close edit dialog
      SchedulingRoutes.back(); // Close options dialog
    } catch (error) {
      _logger.e('Error updating project: $error');
      EasyLoading.showError('Failed to update project');
    }
  }

  /// Delete project
  Future<void> deleteProject() async {
    try {
      EasyLoading.show(status: 'Deleting...');

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 1000));

      if (editingProject.value != null) {
        projects.removeWhere((p) => p.id == editingProject.value!.id);
        projects.refresh();
      }

      EasyLoading.showSuccess('Project deleted successfully');
      SchedulingRoutes.back(); // Close delete dialog
      SchedulingRoutes.back(); // Close options dialog
    } catch (error) {
      _logger.e('Error deleting project: $error');
      EasyLoading.showError('Failed to delete project');
    }
  }

  /// Navigate to project schedule
  void accessSchedule(ProjectModel project, BuildContext context) {
    _logger.i('Accessing schedule for project: ${project.projectName}');
    // Navigate to access schedule screen using GetX routes
    SchedulingRoutes.toAccessSchedule(
      arguments: {'projectId': project.id, 'projectName': project.projectName},
    );
  }

  /// Add new project - Navigate to Add Project Screen
  void addNewProject(BuildContext context) {
    _logger.i('Navigating to Add Project screen');
    // Use GetX routes for navigation
    SchedulingRoutes.toAddProject();
  }
}

/// Project data model
class ProjectModel {
  final String id;
  final String title;
  final String projectName;
  final List<UserModel> assignedUsers;
  final UserModel adminUser;

  ProjectModel({
    required this.id,
    required this.title,
    required this.projectName,
    required this.assignedUsers,
    required this.adminUser,
  });

  ProjectModel copyWith({
    String? id,
    String? title,
    String? projectName,
    List<UserModel>? assignedUsers,
    UserModel? adminUser,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      title: title ?? this.title,
      projectName: projectName ?? this.projectName,
      assignedUsers: assignedUsers ?? this.assignedUsers,
      adminUser: adminUser ?? this.adminUser,
    );
  }
}

/// User data model
class UserModel {
  final String id;
  final String name;
  final String avatar;

  UserModel({required this.id, required this.name, required this.avatar});
}
