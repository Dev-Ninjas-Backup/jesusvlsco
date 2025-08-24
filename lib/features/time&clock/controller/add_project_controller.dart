import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:jesusvlsco/features/time&clock/models/team_model.dart';

/// AddProjectController manages the business logic for adding new projects
/// Handles team selection, member selection, and project creation
class AddProjectController extends GetxController {
  final Logger _logger = Logger();

  // Text controller for project name input
  final projectNameController = TextEditingController();

  // Observable variable for project name
  var projectName = ''.obs;

  // Observable variables for state management
  var isLoading = false.obs;
  var selectedTeam = Rx<TeamModel?>(null);
  var selectedMembers = <MemberModel>[].obs;
  var availableMembers = <MemberModel>[].obs;
  var teams = <TeamModel>[].obs;

  // Dropdown states
  var isTeamDropdownOpen = false.obs;
  var isMemberDropdownOpen = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTeamsAndMembers();

    // Listen to text changes
    projectNameController.addListener(() {
      projectName.value = projectNameController.text;
    });
  }

  @override
  void onClose() {
    projectNameController.dispose();
    super.onClose();
  }

  /// Load all available teams and members from API
  Future<void> loadTeamsAndMembers() async {
    try {
      isLoading.value = true;

      // Mock data for demonstration - replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Load teams
      teams.value = [
        const TeamModel(id: '1', name: 'Team 1', members: []),
        const TeamModel(id: '2', name: 'Team 2', members: []),
        const TeamModel(id: '3', name: 'Team 3', members: []),
      ];

      // Load all available members
      availableMembers.value = [
        const MemberModel(
          id: '1',
          name: 'Jane Cooper',
          position: 'Project Manager',
          avatar: 'https://i.pravatar.cc/150?img=1',
        ),
        const MemberModel(
          id: '2',
          name: 'Robert Fox',
          position: 'Construction Site Manager',
          avatar: 'https://i.pravatar.cc/150?img=2',
        ),
        const MemberModel(
          id: '3',
          name: 'Esther Howard',
          position: 'Assistant Project Manager',
          avatar: 'https://i.pravatar.cc/150?img=3',
        ),
        const MemberModel(
          id: '4',
          name: 'Desirae Botosh',
          position: 'Superintendent',
          avatar: 'https://i.pravatar.cc/150?img=4',
        ),
        const MemberModel(
          id: '5',
          name: 'Marley Stanton',
          position: 'Coordinator',
          avatar: 'https://i.pravatar.cc/150?img=5',
        ),
        const MemberModel(
          id: '6',
          name: 'Brandon Vaccaro',
          position: 'Operations Manager',
          avatar: 'https://i.pravatar.cc/150?img=6',
        ),
        const MemberModel(
          id: '7',
          name: 'Erin Press',
          position: 'Estimating Manager',
          avatar: 'https://i.pravatar.cc/150?img=7',
        ),
      ];

      // Pre-select some members to match the Figma design
      _preselectMembers();

      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      _logger.e('Error loading teams and members: $error');
      EasyLoading.showError('Failed to load teams and members');
    }
  }

  /// Pre-select members to match the Figma design
  void _preselectMembers() {
    final preselectedIds = [
      '1',
      '3',
      '5',
      '6',
    ]; // Jane, Esther, Marley, Brandon

    selectedMembers.value = availableMembers
        .where((member) => preselectedIds.contains(member.id))
        .toList();

    _logger.i('Pre-selected ${selectedMembers.length} members');
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
    if (isTeamDropdownOpen.value) {
      isMemberDropdownOpen.value = false;
    }
  }

  /// Toggle member dropdown visibility
  void toggleMemberDropdown() {
    isMemberDropdownOpen.value = !isMemberDropdownOpen.value;
    if (isMemberDropdownOpen.value) {
      isTeamDropdownOpen.value = false;
    }
  }

  /// Toggle member selection
  void toggleMemberSelection(MemberModel member) {
    final index = selectedMembers.indexWhere((m) => m.id == member.id);

    if (index != -1) {
      // Member is already selected, remove them
      selectedMembers.removeAt(index);
      _logger.i('Member ${member.name} deselected');
    } else {
      // Member is not selected, add them
      selectedMembers.add(member);
      _logger.i('Member ${member.name} selected');
    }

    // Force update the observable list
    selectedMembers.refresh();
  }

  /// Check if member is selected
  bool isMemberSelected(MemberModel member) {
    return selectedMembers.any((m) => m.id == member.id);
  }

  /// Get selected members count
  int get selectedMembersCount => selectedMembers.length;

  /// Validate form inputs
  bool get isFormValid {
    return projectName.value.trim().isNotEmpty &&
        selectedTeam.value != null &&
        selectedMembers.isNotEmpty;
  }

  /// Create new project
  Future<void> createProject() async {
    if (!isFormValid) {
      EasyLoading.showError('Please fill all required fields');
      return;
    }

    try {
      EasyLoading.show(status: 'Creating project...');

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 1500));

      _logger.i(
        'Creating project: ${projectNameController.text.trim()}, '
        'Team: ${selectedTeam.value!.name}, '
        'Members: ${selectedMembers.map((m) => m.name).join(', ')}',
      );

      EasyLoading.showSuccess('Project created successfully!');

      // Clear form
      _clearForm();

      // Navigate back to TimeSheet screen
      Get.back();
    } catch (error) {
      _logger.e('Error creating project: $error');
      EasyLoading.showError('Failed to create project');
    }
  }

  /// Clear form data
  void _clearForm() {
    projectNameController.clear();
    selectedTeam.value = null;
    selectedMembers.clear();
    isTeamDropdownOpen.value = false;
    isMemberDropdownOpen.value = false;
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
