import 'package:flutter/material.dart';
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
