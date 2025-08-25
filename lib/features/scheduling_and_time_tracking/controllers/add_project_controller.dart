import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/models/team_model.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/services/project_api_service.dart';

/// AddProjectController manages the business logic for adding new projects
/// Handles team selection, manager selection, and project creation
class AddProjectController extends GetxController {
  final Logger _logger = Logger();
  final ProjectApiService _projectApiService = ProjectApiService();

  // Text controllers for input fields
  final projectNameController = TextEditingController();
  final locationController = TextEditingController();

  // Observable variables for form inputs
  var projectName = ''.obs;
  var location = ''.obs;

  // Observable variables for state management
  var isLoading = false.obs;
  var isLoadingMoreTeams = false.obs;
  var isLoadingMoreManagers = false.obs;
  var selectedTeam = Rx<TeamModel?>(null);
  var selectedManager = Rx<MemberModel?>(null);
  var availableManagers = <MemberModel>[].obs;
  var teams = <TeamModel>[].obs;

  // Pagination variables
  var currentTeamPage = 1;
  var currentManagerPage = 1;
  var hasMoreTeams = true.obs;
  var hasMoreManagers = true.obs;

  // Dropdown states
  var isTeamDropdownOpen = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTeamsAndMembers();

    // Listen to text changes
    projectNameController.addListener(() {
      projectName.value = projectNameController.text;
    });

    locationController.addListener(() {
      location.value = locationController.text;
    });
  }

  @override
  void onClose() {
    projectNameController.dispose();
    locationController.dispose();
    super.onClose();
  }

  /// Load all available teams and managers from API
  Future<void> loadTeamsAndMembers() async {
    try {
      isLoading.value = true;
      currentTeamPage = 1;
      currentManagerPage = 1;

      // Load teams and managers in parallel
      final teamsFuture = _projectApiService.getAllTeams(page: 1, limit: 10);
      final managersFuture = _projectApiService.getAllManagers(
        page: 1,
        limit: 10,
      );

      final results = await Future.wait([teamsFuture, managersFuture]);
      final teamsResponse = results[0];
      final managersResponse = results[1];

      // Process teams response
      if (teamsResponse.isSuccess) {
        final teamsData = teamsResponse.responseData['data']['teams'] as List;
        final meta = teamsResponse.responseData['data']['meta'];

        teams.value = teamsData
            .map((team) => TeamModel.fromJson(team))
            .toList();
        hasMoreTeams.value = currentTeamPage < (meta['pages'] ?? 1);
        _logger.i(
          'Loaded ${teams.length} teams, hasMore: ${hasMoreTeams.value}',
        );
      } else {
        _logger.e('Failed to load teams: ${teamsResponse.errorMessage}');
        EasyLoading.showError('Failed to load teams');
      }

      // Process managers response
      if (managersResponse.isSuccess) {
        final managersData = managersResponse.responseData['data'] as List;
        final metadata = managersResponse.responseData['metadata'];

        availableManagers.value = managersData
            .map((manager) => MemberModel.fromManagerJson(manager))
            .toList();
        hasMoreManagers.value =
            currentManagerPage < (metadata['totalPage'] ?? 1);
        _logger.i(
          'Loaded ${availableManagers.length} managers, hasMore: ${hasMoreManagers.value}',
        );
      } else {
        _logger.e('Failed to load managers: ${managersResponse.errorMessage}');
        EasyLoading.showError('Failed to load managers');
      }

      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      _logger.e('Error loading teams and managers: $error');
      EasyLoading.showError('Failed to load data. Please try again.');
    }
  }

  /// Load more teams for pagination
  Future<void> loadMoreTeams() async {
    if (!hasMoreTeams.value || isLoadingMoreTeams.value) return;

    try {
      isLoadingMoreTeams.value = true;
      currentTeamPage++;

      final response = await _projectApiService.getAllTeams(
        page: currentTeamPage,
        limit: 10,
      );

      if (response.isSuccess) {
        final teamsData = response.responseData['data']['teams'] as List;
        final meta = response.responseData['data']['meta'];

        final newTeams = teamsData
            .map((team) => TeamModel.fromJson(team))
            .toList();
        teams.addAll(newTeams);
        hasMoreTeams.value = currentTeamPage < (meta['pages'] ?? 1);

        _logger.i(
          'Loaded ${newTeams.length} more teams, total: ${teams.length}',
        );
      } else {
        currentTeamPage--; // Revert page increment on error
        _logger.e('Failed to load more teams: ${response.errorMessage}');
      }

      isLoadingMoreTeams.value = false;
    } catch (error) {
      currentTeamPage--; // Revert page increment on error
      isLoadingMoreTeams.value = false;
      _logger.e('Error loading more teams: $error');
    }
  }

  /// Load more managers for pagination
  Future<void> loadMoreManagers() async {
    if (!hasMoreManagers.value || isLoadingMoreManagers.value) return;

    try {
      isLoadingMoreManagers.value = true;
      currentManagerPage++;

      final response = await _projectApiService.getAllManagers(
        page: currentManagerPage,
        limit: 10,
      );

      if (response.isSuccess) {
        final managersData = response.responseData['data'] as List;
        final metadata = response.responseData['metadata'];

        final newManagers = managersData
            .map((manager) => MemberModel.fromManagerJson(manager))
            .toList();
        availableManagers.addAll(newManagers);
        hasMoreManagers.value =
            currentManagerPage < (metadata['totalPage'] ?? 1);

        _logger.i(
          'Loaded ${newManagers.length} more managers, total: ${availableManagers.length}',
        );
      } else {
        currentManagerPage--; // Revert page increment on error
        _logger.e('Failed to load more managers: ${response.errorMessage}');
      }

      isLoadingMoreManagers.value = false;
    } catch (error) {
      currentManagerPage--; // Revert page increment on error
      isLoadingMoreManagers.value = false;
      _logger.e('Error loading more managers: $error');
    }
  }

  /// Handle manager selection
  void selectManager(MemberModel manager) {
    selectedManager.value = manager;
    _logger.i('Selected manager: ${manager.name}');
  }

  /// Handle team selection
  void selectTeam(TeamModel team) {
    selectedTeam.value = team;
    isTeamDropdownOpen.value = false;
    _logger.i('Selected team: ${team.name}');
  }

  /// Toggle team dropdown visibility
  void toggleTeamDropdown() {
    isTeamDropdownOpen.value = !isTeamDropdownOpen.value;
  }

  /// Validate form inputs
  bool get isFormValid {
    return projectName.value.trim().isNotEmpty &&
        location.value.trim().isNotEmpty &&
        selectedTeam.value != null &&
        selectedManager.value != null;
  }

  /// Create new project
  Future<void> createProject() async {
    if (!isFormValid) {
      EasyLoading.showError('Please fill all required fields');
      return;
    }

    try {
      EasyLoading.show(status: 'Creating project...');

      // Call API to create project
      final response = await _projectApiService.createProject(
        teamId: selectedTeam.value!.id,
        managerId: selectedManager.value!.id,
        title: projectNameController.text.trim(),
        projectLocation: locationController.text.trim(),
      );

      if (response.isSuccess) {
        _logger.i('Project created successfully');
        EasyLoading.showSuccess('Project created successfully!');

        // Clear form
        _clearForm();

        // Navigate back to previous screen
        Get.back();
      } else {
        _logger.e('Failed to create project: ${response.errorMessage}');
        EasyLoading.showError(
          response.errorMessage.isEmpty
              ? 'Failed to create project'
              : response.errorMessage,
        );
      }
    } catch (error) {
      _logger.e('Error creating project: $error');
      EasyLoading.showError('Failed to create project. Please try again.');
    }
  }

  /// Clear form data
  void _clearForm() {
    projectNameController.clear();
    locationController.clear();
    selectedTeam.value = null;
    selectedManager.value = null;
    isTeamDropdownOpen.value = false;
  }

  /// Navigate back to previous screen
  void navigateBack() {
    Get.back();
  }

  /// Create new team (placeholder functionality)
  void createNewTeam() {
    EasyLoading.showInfo('Create new team functionality');
    isTeamDropdownOpen.value = false;
  }
}
