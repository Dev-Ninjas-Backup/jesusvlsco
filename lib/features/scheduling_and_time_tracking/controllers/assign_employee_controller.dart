// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:jesusvlsco/features/assign_employee/controller/user_schedule_controller.dart';
// import 'package:jesusvlsco/features/scheduling_and_time_tracking/models/assign_shift_model.dart';
// import 'package:jesusvlsco/features/scheduling_and_time_tracking/models/project_model.dart'
//     hide ProjectData;
// import 'package:logger/logger.dart';
// import 'package:intl/intl.dart';
// import '../../assign_employee/models/project_model.dart' hide ProjectData;
// import '../screens/widgets/filter_dialog.dart';
// import '../../../core/common/widgets/custom_date_picker_widget.dart';
// import '../routes/scheduling_routes.dart';
// import '../services/project_api_service.dart';

// /// AssignEmployeeController manages the business logic for employee assignment
// /// This includes handling employee data, search, filtering, and scheduling operations
// class AssignEmployeeController extends GetxController {
//   final Logger _logger = Logger();
//   final ScheduleController scheduleController = Get.put(ScheduleController());
//   final assignShiftModel = AssignShiftModel(
//     success: false,
//     message: '',
//     data: [],
//   ).obs;
//   final filteredEmployees = <ProjectData>[].obs;

//   // Observable variables for state management
//   var isLoading = false.obs;
//   var searchText = ''.obs;
//   var employees = <EmployeeModel>[].obs;
//   var activeEmployeesCount = 5.obs;
//   var selectedDate = DateTime.now().obs;
//   var projects = <ProjectModel>[].obs;

//   var selectedProject = Rx<ProjectModel?>(null);

//   // Pagination variables
//   var currentPage = 1.obs;
//   var hasMoreProjects = true.obs;
//   var isLoadingMoreProjects = false.obs;
//   var totalProjects = 0.obs;
//   var totalPages = 0.obs;
//   final int pageLimit = 5;

//   @override
//   void onInit() {
//     super.onInit();
//     ever(
//       scheduleController.selectedProject,
//       (_) => fetchAssignShift(scheduleController.selectedProject.value!.id),
//     );
//     fetchProjects();
//   }

//   Future<void> refreshProjects() async {
//     await fetchProjects(isRefresh: true);
//   }

//   Future<void> fetchAssignShift(String projectId) async {
//     isLoading.value = true;
//     try {
//       final model = await ProjectApiService.getAssignShift(projectId);
//       assignShiftModel.value = model;
//       filteredEmployees.assignAll(model.data);
//     } catch (e) {
//       assignShiftModel.value = AssignShiftModel(
//         success: false,
//         message: 'Error fetching employees: $e',
//         data: [],
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> fetchProjects({bool isRefresh = false}) async {
//     try {
//       if (isRefresh) {
//         currentPage.value = 1;
//         projects.clear();
//         hasMoreProjects.value = true;
//       }

//       if (isLoading.value || isLoadingMoreProjects.value) return;

//       if (currentPage.value == 1) {
//         isLoading.value = true;
//       } else {
//         isLoadingMoreProjects.value = true;
//       }

//       _logger.i(
//         'Fetching projects - Page: ${currentPage.value}, Limit: $pageLimit',
//       ); // Added pageLimit logging

//       final response = await scheduleController.projectService.getAllProjects(
//         page: currentPage.value,
//         limit: pageLimit,
//       );

//       _logger.i(
//         'API Response - Success: ${response.success}, Data length: ${response.data.length}',
//       );
//       _logger.i(
//         'Metadata - Page: ${response.metadata.page}, Limit: ${response.metadata.limit}, Total: ${response.metadata.total}, TotalPages: ${response.metadata.totalPage}',
//       );

//       if (response.success) {
//         if (currentPage.value == 1) {
//           projects.value = response.data;
//         } else {
//           projects.addAll(response.data);
//         }

//         totalProjects.value = response.metadata.total;
//         totalPages.value = response.metadata.totalPage;

//         // Check if there are more pages
//         hasMoreProjects.value = currentPage.value < response.metadata.totalPage;

//         _logger.i('Projects loaded: ${response.data.length}');
//         _logger.i('Total projects in list: ${projects.length}');
//         _logger.i('Has more: ${hasMoreProjects.value}');
//       } else {
//         EasyLoading.showError('Failed to load projects: ${response.message}');
//       }
//     } catch (e) {
//       _logger.e('Error fetching projects: $e');
//       EasyLoading.showError('Failed to load projects');
//     } finally {
//       isLoading.value = false;
//       isLoadingMoreProjects.value = false;
//     }
//   }

//   /// Handle search functionality
//   void updateSearchText(String text) {
//     searchText.value = text;
//   }

//   /// Get filtered employees based on search text
//   void filterEmployees(String query) {
//     if (query.isEmpty) {
//       filteredEmployees.assignAll(assignShiftModel.value.data);
//     } else {
//       filteredEmployees.assignAll(
//         assignShiftModel.value.data.where((projectData) {
//           final fullName =
//               '${projectData.user.firstName} ${projectData.user.lastName}';
//           return fullName.toLowerCase().contains(query.toLowerCase()) ||
//               projectData.project.title.toLowerCase().contains(
//                 query.toLowerCase(),
//               );
//         }).toList(),
//       );
//     }
//   }

//   /// Handle publish button press
//   void onPublishPressed() {
//     _logger.i('Publish button pressed');
//     EasyLoading.showSuccess('Schedule published successfully');
//   }

//   /// Handle filter button press
//   void onFilterPressed(BuildContext context) {
//     _logger.i('Filter button pressed');

//     // Show filter dialog
//     showDialog(
//       context: context,
//       builder: (context) => const FilterDialog(),
//     ).then((result) {
//       if (result != null) {
//         // Handle filter result
//         _applyFilters(result);
//       }
//     });
//   }

//   /// Apply filters to employee list
//   void _applyFilters(Map<String, List<String>> filterData) {
//     _logger.i('Applying filters: $filterData');

//     // Count total applied filters
//     int totalFilters = 0;
//     filterData.forEach((key, value) {
//       totalFilters += value.length;
//     });

//     if (totalFilters > 0) {
//       EasyLoading.showSuccess('$totalFilters filters applied');
//     } else {
//       EasyLoading.showInfo('All filters cleared');
//     }

//     // Here you would implement actual filtering logic
//     // For example:
//     // - Filter by assignment status (assigned/unassigned)
//     // - Filter by completion status
//     // - Filter by publish state
//     // - Filter by availability
//     // - Filter by shifts
//     // - Filter by groups

//     // Refresh the employee list with filtered data
//     // employees.refresh();
//   }

//   /// Handle date button press
//   Future<void> onDatePressed() async {
//     try {
//       _logger.i('Date button pressed');

//       final DateTime? pickedDate = await CustomDatePicker.show(
//         context: Get.context!,
//         initialDate: selectedDate.value,
//       );

//       if (pickedDate != null) {
//         selectedDate.value = pickedDate;
//         _logger.i(
//           'Date selected: ${DateFormat('yyyy-MM-dd').format(pickedDate)}',
//         );
//         EasyLoading.showSuccess(
//           'Date selected: ${DateFormat('MMM dd, yyyy').format(pickedDate)}',
//         );
//       }
//     } catch (error) {
//       _logger.e('Error showing date picker: $error');
//       EasyLoading.showError('Failed to show date picker');
//     }
//   }

//   /// Handle export button press
//   void onExportPressed() {
//     _logger.i('Export button pressed');
//     // Show export options
//   }

//   /// Handle more button press
//   void onMorePressed() {
//     _logger.i('More button pressed');
//     // Show more options menu
//   }

//   /// Handle schedule slot press
//   void onSchedulePressed(
//     ProjectData projectData,
//     int slotIndex,
//     bool isEditable,
//     BuildContext context,
//   ) {
//     // Check if a project is selected
//     if (scheduleController.selectedProject.value == null) {
//       EasyLoading.showError('Please select a project first');
//       return;
//     }

//     // Navigate to shift details screen with project and employee data
//     SchedulingRoutes.toShiftDetails(
//       arguments: {
//         'projectData': projectData,
//         'slotIndex': slotIndex,
//         'isEditable': isEditable,
//       },
//     );
//   }

//   /// Navigate back
//   void navigateBack() {
//     SchedulingRoutes.back();
//   }
// }

// /// Employee data model
// class EmployeeModel {
//   final String id;
//   final String name;
//   final String position;
//   final String avatar;
//   final bool isActive;
//   final int projectCount;
//   final String offDay;
//   final List<bool> scheduleSlots;

//   EmployeeModel({
//     required this.id,
//     required this.name,
//     required this.position,
//     required this.avatar,
//     required this.isActive,
//     required this.projectCount,
//     required this.offDay,
//     required this.scheduleSlots,
//   });

//   EmployeeModel copyWith({
//     String? id,
//     String? name,
//     String? position,
//     String? avatar,
//     bool? isActive,
//     int? projectCount,
//     String? offDay,
//     List<bool>? scheduleSlots,
//   }) {
//     return EmployeeModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       position: position ?? this.position,
//       avatar: avatar ?? this.avatar,
//       isActive: isActive ?? this.isActive,
//       projectCount: projectCount ?? this.projectCount,
//       offDay: offDay ?? this.offDay,
//       scheduleSlots: scheduleSlots ?? this.scheduleSlots,
//     );
//   }
// }
