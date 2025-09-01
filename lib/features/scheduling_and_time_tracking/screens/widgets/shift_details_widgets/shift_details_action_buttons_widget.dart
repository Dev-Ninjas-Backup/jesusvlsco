import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import '../../../controllers/shift_details_controller.dart';

/// Action buttons widget for shift details
/// Contains save, draft, and publish buttons
class ShiftDetailsActionButtonsWidget extends StatelessWidget {
  final ShiftDetailsController controller;

  const ShiftDetailsActionButtonsWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Publish button
        GestureDetector(
          onTap: () => controller.publish(),
          child: Container(
            width: double.infinity,
            height: Sizer.hp(48),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_active,
                  size: Sizer.wp(18),
                  color: Colors.white,
                ),
                SizedBox(width: Sizer.wp(12)),
                Text(
                  controller.isEditable ? 'Update' : 'Publish',
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
