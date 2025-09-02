import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/shift_scheduling_controller.dart';

/// DeleteProjectDialog shows confirmation for project deletion
/// Displays warning message with Delete and Cancel buttons
class DeleteProjectDialog extends StatelessWidget {
  const DeleteProjectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TimeSheetController>();

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: Sizer.wp(320),
        padding: EdgeInsets.symmetric(
          horizontal: Sizer.wp(16),
          vertical: Sizer.hp(24),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Sizer.wp(12)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA9B7DD).withValues(alpha: 0.25),
              offset: const Offset(0, 0),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDeleteIcon(),
            SizedBox(height: Sizer.hp(24)),
            _buildContent(),
            SizedBox(height: Sizer.hp(24)),
            _buildActionButtons(controller),
          ],
        ),
      ),
    );
  }

  /// Build delete warning icon
  Widget _buildDeleteIcon() {
    return Container(
      width: Sizer.wp(100),
      height: Sizer.wp(100),
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Icon(
        Icons.cancel_outlined,
        size: Sizer.wp(100),
        color: const Color(0xFFDC1E28),
      ),
    );
  }

  /// Build warning content
  Widget _buildContent() {
    return Column(
      children: [
        Text(
          'Are you sure?',
          style: AppTextStyle.f18W600().copyWith(
            color: AppColors.primary,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: Sizer.hp(16)),
        Text(
          'Do you really want to delete these record? This process cannot be undone.',
          style: AppTextStyle.f14W400().copyWith(
            color: AppColors.text,
            height: 1.45,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Build action buttons
  Widget _buildActionButtons(TimeSheetController controller) {
    return Row(
      children: [
        // Delete button
        Expanded(
          child: Container(
            height: Sizer.hp(40),
            margin: EdgeInsets.only(right: Sizer.wp(8)),
            decoration: BoxDecoration(
              color: const Color(0xFFDC1E28),
              borderRadius: BorderRadius.circular(Sizer.wp(8)),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => controller.deleteProject(),
                borderRadius: BorderRadius.circular(Sizer.wp(8)),
                child: Center(
                  child: Text(
                    'Delete',
                    style: AppTextStyle.f16W500().copyWith(
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Cancel button
        Expanded(
          child: Container(
            height: Sizer.hp(40),
            margin: EdgeInsets.only(left: Sizer.wp(8)),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(Sizer.wp(8)),
              border: Border.all(color: AppColors.border2, width: 1),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Get.back(),
                borderRadius: BorderRadius.circular(Sizer.wp(8)),
                child: Center(
                  child: Text(
                    'Cancel',
                    style: AppTextStyle.f16W500().copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
