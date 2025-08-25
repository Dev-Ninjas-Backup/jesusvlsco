import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/shift_scheduling_controller.dart';

/// ProjectOptionsDialog shows options for project actions
/// Displays Edit and Delete options in a simple dialog
class ProjectOptionsDialog extends StatelessWidget {
  const ProjectOptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TimeSheetController>();

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: Sizer.wp(200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Sizer.wp(12)),
          border: Border.all(color: AppColors.border2, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOptionItem(
              text: 'Edit',
              onTap: () {
                Get.back();
                controller.showEditDialog();
              },
            ),
            Container(height: 1, color: AppColors.border2),
            _buildOptionItem(
              text: 'Delete',
              onTap: () {
                Get.back();
                controller.showDeleteDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Build individual option item
  Widget _buildOptionItem({required String text, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(Sizer.wp(16)),
          child: Text(
            text,
            style: AppTextStyle.f18W600().copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
