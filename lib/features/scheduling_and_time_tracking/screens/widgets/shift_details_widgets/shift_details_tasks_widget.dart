import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/constants/sizer.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/common/styles/global_text_style.dart';
import '../../../controllers/shift_details_controller.dart';

/// Tasks section widget for shift details
/// Displays and manages shift tasks with completion status
class ShiftDetailsTasksWidget extends StatelessWidget {
  final ShiftDetailsController controller;

  const ShiftDetailsTasksWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        // Container(
        //   width: double.infinity,
        //   padding: EdgeInsets.only(bottom: Sizer.hp(8)),
        //   decoration: const BoxDecoration(
        //     border: Border(
        //       bottom: BorderSide(color: Color(0xFFE4E5F3), width: 1),
        //     ),
        //   ),
        //   child: Text(
        //     'Shift Tasks',
        //     style: AppTextStyle.f18W600().copyWith(
        //       color: AppColors.primary,
        //       height: 1.5,
        //     ),
        //   ),
        // ),

        // SizedBox(height: Sizer.hp(16)),

        // Task list
        // Obx(
        //   () => Column(
        //     children: controller.tasks.map((task) {
        //       return Container(
        //         margin: EdgeInsets.only(bottom: Sizer.hp(8)),
        //         child: Row(
        //           children: [
        //             // Checkbox
        //             GestureDetector(
        //               onTap: () => controller.toggleTask(task.id),
        //               child: Container(
        //                 width: Sizer.wp(16),
        //                 height: Sizer.wp(16),
        //                 decoration: BoxDecoration(
        //                   color: task.isCompleted
        //                       ? const Color(0xFF1EBD66)
        //                       : Colors.transparent,
        //                   border: Border.all(
        //                     color: task.isCompleted
        //                         ? const Color(0xFF1EBD66)
        //                         : const Color(0xFFC5C5C5),
        //                   ),
        //                 ),
        //                 child: task.isCompleted
        //                     ? Icon(
        //                         Icons.check,
        //                         size: Sizer.wp(10),
        //                         color: Colors.white,
        //                       )
        //                     : null,
        //               ),
        //             ),

        //             SizedBox(width: Sizer.wp(12)),

        //             // Task text
        //             Expanded(
        //               child: Text(
        //                 task.title,
        //                 style: AppTextStyle.f14W400().copyWith(
        //                   color: const Color(0xFF484848),
        //                   height: 1.45,
        //                   decoration: task.isCompleted
        //                       ? TextDecoration.lineThrough
        //                       : null,
        //                 ),
        //               ),
        //             ),

        //             // Avatar placeholder
        //             Container(
        //               width: Sizer.wp(44),
        //               height: Sizer.wp(44),
        //               decoration: BoxDecoration(
        //                 shape: BoxShape.circle,
        //                 color: AppColors.primary.withOpacity(0.1),
        //                 border: Border.all(
        //                   color: AppColors.primary.withOpacity(0.3),
        //                 ),
        //               ),
        //               child: Icon(
        //                 Icons.person,
        //                 size: Sizer.wp(20),
        //                 color: AppColors.primary,
        //               ),
        //             ),
        //           ],
        //         ),
        //       );
        //     }).toList(),
        //   ),
        // ),
        SizedBox(height: Sizer.hp(16)),

        // Add Task button
        GestureDetector(
          onTap: () => controller.addTask(),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Sizer.wp(20),
              vertical: Sizer.hp(8),
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, size: Sizer.wp(20), color: Colors.white),
                SizedBox(width: Sizer.wp(12)),
                Text(
                  'Add Task',
                  style: AppTextStyle.f16W500().copyWith(
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
