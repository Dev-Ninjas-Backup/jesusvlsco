// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:intl/intl.dart';
// import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
// import 'package:jesusvlsco/core/utils/constants/colors.dart';
// import 'package:jesusvlsco/core/utils/constants/sizer.dart';
// import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/assign_employee_controller.dart';
// import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/time_sheet_appbar.dart';
// import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/employee_card_widget.dart';

// import '../../../assign_employee/widgets/projects_selection_dialog.dart';

// class AssignEmployeeScreen extends StatelessWidget {
//   const AssignEmployeeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(AssignEmployeeController());

//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: const TimeSheetAppBar(title: "Assigne Employee"),
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(height: Sizer.hp(24)),
//             // Project title and publish button
//             _buildProjectHeader(controller),

//             SizedBox(height: Sizer.hp(16)),

//             // Filter and action buttons
//             _buildActionButtons(controller, context),

//             SizedBox(height: Sizer.hp(24)),

//             // Employee availability section
//             _buildEmployeeAvailabilityHeader(controller),

//             SizedBox(height: Sizer.hp(16)),

//             // Project list section
//             _buildProjectSelectionSection(controller),

//             SizedBox(height: Sizer.hp(16)),

//             // Employee list
//             Expanded(child: _buildEmployeeList(controller)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProjectSelectionSection(AssignEmployeeController controller) {
//     return Container(
//       padding: EdgeInsets.only(
//         top: Sizer.hp(16),
//         left: Sizer.wp(10),
//         right: Sizer.wp(10),
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(Sizer.wp(12)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 10,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 'Projects *',
//                 style: AppTextStyle.regular().copyWith(
//                   fontSize: Sizer.wp(14),
//                   color: AppColors.primary,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Spacer(),
//               Obx(
//                 () => controller.isLoading.value
//                     ? SizedBox(
//                         width: Sizer.wp(16),
//                         height: Sizer.wp(16),
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           color: AppColors.primary,
//                         ),
//                       )
//                     : GestureDetector(
//                         onTap: () => controller.refreshProjects(),
//                         child: Icon(
//                           Icons.refresh,
//                           size: Sizer.wp(20),
//                           color: AppColors.primary.withValues(alpha: 0.7),
//                         ),
//                       ),
//               ),
//             ],
//           ),
//           SizedBox(height: Sizer.hp(12)),
//           _buildProjectSelector(controller),
//         ],
//       ),
//     );
//   }

//   Widget _buildProjectSelector(AssignEmployeeController controller) {
//     return Obx(() {
//       return GestureDetector(
//         onTap: () {
//           // Refresh projects when dialog opens if list is empty
//           if (controller.projects.isEmpty && !controller.isLoading.value) {
//             controller.refreshProjects();
//           }
//           Get.dialog(const ProjectSelectionDialog(), barrierDismissible: true);
//         },
//         child: Container(
//           height: Sizer.hp(48),
//           padding: EdgeInsets.symmetric(horizontal: Sizer.wp(12)),
//           decoration: BoxDecoration(
//             color: Colors.grey[50],
//             borderRadius: BorderRadius.circular(Sizer.wp(8)),
//             border: Border.all(
//               color: controller.selectedProject.value != null
//                   ? AppColors.primary.withValues(alpha: 0.5)
//                   : const Color(0xFFC8CAE7),
//               width: 1,
//             ),
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   controller.scheduleController.selectedProject.value?.title ??
//                       'Select a project to continue',
//                   style: AppTextStyle.f14W400().copyWith(
//                     color: controller.selectedProject.value != null
//                         ? AppColors.text
//                         : AppColors.text.withValues(alpha: 0.6),
//                     height: 1.5,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               Icon(
//                 Iconsax.arrow_down_1,
//                 size: Sizer.wp(24),
//                 color: AppColors.text,
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }

//   /// Build project header with title and publish button
//   Widget _buildProjectHeader(AssignEmployeeController controller) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               'Shift Scheduling Project 1',
//               style: AppTextStyle.f18W600().copyWith(
//                 color: AppColors.primary,
//                 height: 1.5,
//               ),
//             ),
//           ),
//           SizedBox(width: Sizer.wp(16)),
//           GestureDetector(
//             onTap: controller.onPublishPressed,
//             child: Container(
//               padding: EdgeInsets.symmetric(
//                 horizontal: Sizer.wp(12),
//                 vertical: Sizer.hp(8),
//               ),
//               decoration: BoxDecoration(
//                 color: AppColors.primary,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.notifications_active,
//                     size: Sizer.wp(20),
//                     color: Colors.white,
//                   ),
//                   SizedBox(width: Sizer.wp(8)),
//                   Text(
//                     'Publish',
//                     style: AppTextStyle.f16W500().copyWith(
//                       color: Colors.white,
//                       height: 1.5,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Builds action buttons row (filter, date, export, more)
//   Widget _buildActionButtons(
//     AssignEmployeeController controller,
//     BuildContext context,
//   ) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
//       child: Row(
//         children: [
//           // Filter button
//           GestureDetector(
//             onTap: () => controller.onFilterPressed(context),
//             child: Container(
//               height: Sizer.hp(40),
//               padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.primary),
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: Center(
//                 child: Icon(
//                   Icons.filter_list,
//                   size: Sizer.wp(20),
//                   color: AppColors.primary,
//                 ),
//               ),
//             ),
//           ),

//           SizedBox(width: Sizer.wp(16)),

//           // Date button
//           Expanded(
//             child: GestureDetector(
//               onTap: controller.onDatePressed,
//               child: Container(
//                 height: Sizer.hp(40),
//                 padding: EdgeInsets.symmetric(horizontal: Sizer.wp(6)),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: AppColors.primary),
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.calendar_month,
//                       size: Sizer.wp(20),
//                       color: AppColors.primary,
//                     ),
//                     SizedBox(width: Sizer.wp(4)),
//                     Obx(
//                       () => Text(
//                         DateFormat(
//                           'MMM dd',
//                         ).format(controller.selectedDate.value),
//                         style: AppTextStyle.f14W400().copyWith(
//                           color: AppColors.primary,
//                           height: 1.45,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: Sizer.wp(8)),
//                     Icon(
//                       Icons.arrow_drop_down,
//                       size: Sizer.wp(20),
//                       color: AppColors.primary,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           SizedBox(width: Sizer.wp(16)),

//           // Export button
//           GestureDetector(
//             onTap: controller.onExportPressed,
//             child: Container(
//               height: Sizer.hp(40),
//               padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.primary),
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.file_download_outlined,
//                     size: Sizer.wp(20),
//                     color: AppColors.primary,
//                   ),
//                   SizedBox(width: Sizer.wp(8)),
//                   Text(
//                     'Export',
//                     style: AppTextStyle.f14W400().copyWith(
//                       color: AppColors.primary,
//                       height: 1.45,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           SizedBox(width: Sizer.wp(16)),

//           // More button
//           GestureDetector(
//             onTap: controller.onMorePressed,
//             child: Container(
//               height: Sizer.hp(40),
//               width: Sizer.hp(40),
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.primary),
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: Center(
//                 child: Icon(
//                   Icons.more_vert,
//                   size: Sizer.wp(20),
//                   color: AppColors.primary,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Build employee availability header
//   Widget _buildEmployeeAvailabilityHeader(AssignEmployeeController controller) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Employee Availability',
//             style: AppTextStyle.f16W600().copyWith(
//               color: AppColors.primary,
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Build employee list
//   Widget _buildEmployeeList(AssignEmployeeController controller) {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return const Center(
//           child: CircularProgressIndicator(color: AppColors.primary),
//         );
//       }

//       final assignShiftModel = controller.assignShiftModel.value;

//       if (!assignShiftModel.success) {
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.error_outline,
//                 size: Sizer.wp(64),
//                 color: const Color(0xFF949494),
//               ),
//               SizedBox(height: Sizer.hp(16)),
//               Text(
//                 assignShiftModel.message.isNotEmpty
//                     ? assignShiftModel.message
//                     : 'Please select a project',
//                 style: AppTextStyle.f16W500().copyWith(
//                   color: const Color(0xFF949494),
//                   height: 1.5,
//                 ),
//               ),
//             ],
//           ),
//         );
//       }

//       final employees = controller.filteredEmployees;

//       if (employees.isEmpty) {
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.person_off_outlined,
//                 size: Sizer.wp(64),
//                 color: const Color(0xFF949494),
//               ),
//               SizedBox(height: Sizer.hp(16)),
//               Text(
//                 'No employees found',
//                 style: AppTextStyle.f16W500().copyWith(
//                   color: const Color(0xFF949494),
//                   height: 1.5,
//                 ),
//               ),
//             ],
//           ),
//         );
//       }

//       return ListView.separated(
//         padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
//         itemCount: employees.length,
//         separatorBuilder: (context, index) => Container(
//           height: 1,
//           margin: EdgeInsets.symmetric(vertical: Sizer.hp(16)),
//           color: const Color(0xFFE5E5E5),
//         ),
//         itemBuilder: (context, index) {
//           final projectData = employees[index];
//           return GestureDetector(
//             onTap: () =>
//                 controller.onSchedulePressed(projectData, 0, false, context),
//             child: EmployeeCardWidget(
//               projectData: projectData,
//               onSchedulePressed: (scheduleIndex) => controller
//                   .onSchedulePressed(projectData, scheduleIndex, true, context),
//             ),
//           );
//         },
//       );
//     });
//   }
// }
