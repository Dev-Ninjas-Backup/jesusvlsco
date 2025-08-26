// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
// import 'package:jesusvlsco/core/utils/constants/colors.dart';
// import 'package:jesusvlsco/core/utils/constants/sizer.dart';
// import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/add_project_controller.dart';
// import 'package:jesusvlsco/features/scheduling_and_time_tracking/models/team_model.dart';

// /// Member selection dialog widget
// /// Shows a scrollable list of team members with checkbox selection
// class MemberSelectionDialog extends StatelessWidget {
//   const MemberSelectionDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<AddProjectController>();

//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: EdgeInsets.symmetric(horizontal: Sizer.wp(32)),
//       child: Container(
//         constraints: BoxConstraints(
//           maxHeight: Sizer.hp(600),
//           maxWidth: double.infinity,
//         ),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(Sizer.wp(8)),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFFA9B7DD).withValues(alpha: 0.25),
//               offset: const Offset(0, 0),
//               blurRadius: 12,
//               spreadRadius: 0,
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Header
//             Container(
//               padding: EdgeInsets.all(Sizer.wp(24)),
//               decoration: BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(
//                     color: AppColors.textfield.withValues(alpha: 0.2),
//                     width: 1,
//                   ),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Select Members',
//                     style: AppTextStyle.f18W600().copyWith(
//                       color: AppColors.primary,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () => Get.back(),
//                     child: Icon(
//                       Icons.close,
//                       size: Sizer.wp(20),
//                       color: AppColors.textfield,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Scrollable member list
//             Expanded(
//               child: Obx(() {
//                 if (controller.isLoading.value) {
//                   return SizedBox(
//                     height: Sizer.hp(200),
//                     child: const Center(
//                       child: CircularProgressIndicator(
//                         color: AppColors.primary,
//                       ),
//                     ),
//                   );
//                 }

//                 if (controller.availableMembers.isEmpty) {
//                   return SizedBox(
//                     height: Sizer.hp(200),
//                     child: Center(
//                       child: Text(
//                         'No members available',
//                         style: AppTextStyle.f16W500().copyWith(
//                           color: AppColors.textfield,
//                         ),
//                       ),
//                     ),
//                   );
//                 }

//                 return ListView.builder(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: Sizer.wp(24),
//                     vertical: Sizer.wp(16),
//                   ),
//                   itemCount: controller.availableMembers.length,
//                   itemBuilder: (context, index) {
//                     final member = controller.availableMembers[index];
//                     return _buildMemberItem(member, controller);
//                   },
//                 );
//               }),
//             ),
//             // Add button
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(Sizer.wp(24)),
//               decoration: BoxDecoration(
//                 border: Border(
//                   top: BorderSide(
//                     color: AppColors.textfield.withValues(alpha: 0.2),
//                     width: 1,
//                   ),
//                 ),
//               ),
//               child: _buildAddButton(controller),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Build individual member item with checkbox and avatar
//   Widget _buildMemberItem(MemberModel member, AddProjectController controller) {
//     return Container(
//       margin: EdgeInsets.only(bottom: Sizer.hp(16)),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () => controller.toggleMemberSelection(member),
//           borderRadius: BorderRadius.circular(Sizer.wp(8)),
//           child: Padding(
//             padding: EdgeInsets.all(Sizer.wp(12)),
//             child: Row(
//               children: [
//                 // Checkbox
//                 Obx(() {
//                   final isSelected = controller.isMemberSelected(member);
//                   return Container(
//                     width: Sizer.wp(20),
//                     height: Sizer.wp(20),
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? const Color(0xFF1EBD66)
//                           : Colors.transparent,
//                       border: Border.all(
//                         color: isSelected
//                             ? const Color(0xFF1EBD66)
//                             : const Color(0xFFC5C5C5),
//                         width: isSelected ? 0 : 1,
//                       ),
//                       borderRadius: BorderRadius.circular(Sizer.wp(4)),
//                     ),
//                     child: isSelected
//                         ? Icon(
//                             Icons.check,
//                             size: Sizer.wp(14),
//                             color: Colors.white,
//                           )
//                         : null,
//                   );
//                 }),
//                 SizedBox(width: Sizer.wp(16)),
//                 // Member info
//                 Expanded(
//                   child: Row(
//                     children: [
//                       // Avatar
//                       Container(
//                         width: Sizer.wp(40),
//                         height: Sizer.wp(40),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(Sizer.wp(20)),
//                           image: DecorationImage(
//                             image: NetworkImage(member.avatar),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: Sizer.wp(16)),
//                       // Name and position
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               member.name,
//                               style: AppTextStyle.f16W600().copyWith(
//                                 color: AppColors.primary,
//                                 height: 1.2,
//                               ),
//                             ),
//                             SizedBox(height: Sizer.hp(2)),
//                             Text(
//                               member.position,
//                               style: AppTextStyle.f14W500().copyWith(
//                                 color: AppColors.textfield,
//                                 height: 1.2,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// Build add button
//   Widget _buildAddButton(AddProjectController controller) {
//     return Container(
//       height: Sizer.hp(48),
//       decoration: BoxDecoration(
//         color: AppColors.primary,
//         borderRadius: BorderRadius.circular(Sizer.wp(8)),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () {
//             controller.toggleMemberDropdown();
//             Get.back();
//           },
//           borderRadius: BorderRadius.circular(Sizer.wp(8)),
//           child: Center(
//             child: Text(
//               'Add Selected Members',
//               style: AppTextStyle.f16W600().copyWith(
//                 color: Colors.white,
//                 height: 1.2,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
