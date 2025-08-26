import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/shift_scheduling_controller.dart';

/// EditProjectDialog allows users to edit project title
/// Shows a text field with current project name and confirm button
class EditProjectDialog extends StatelessWidget {
  const EditProjectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TimeSheetController>();
    final textController = TextEditingController(
      text: controller.editingProject.value?.title ?? '',
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: Sizer.wp(320),
        padding: EdgeInsets.symmetric(
          horizontal: Sizer.wp(16),
          vertical: Sizer.hp(36),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Sizer.wp(12)),
          border: Border.all(color: AppColors.border2, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            SizedBox(height: Sizer.hp(16)),
            _buildTextField(textController),
            SizedBox(height: Sizer.hp(16)),
            _buildConfirmButton(textController, controller),
          ],
        ),
      ),
    );
  }

  /// Build dialog header with close button and title
  Widget _buildHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Icon(
                Iconsax.close_circle,
                size: Sizer.wp(16),
                color: AppColors.text,
              ),
            ),
          ],
        ),
        SizedBox(height: Sizer.hp(12)),
        Text(
          'Title this scheduler',
          style: AppTextStyle.f18W600().copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Build text input field
  Widget _buildTextField(TextEditingController textController) {
    return Container(
      height: Sizer.hp(40),
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(10)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border2, width: 1),
        borderRadius: BorderRadius.circular(Sizer.wp(8)),
      ),
      child: Center(
        child: TextField(
          controller: textController,
          textAlign: TextAlign.center,
          style: AppTextStyle.f16W500().copyWith(
            color: AppColors.textSecondary,
            height: 1,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }

  /// Build confirm button
  Widget _buildConfirmButton(
    TextEditingController textController,
    TimeSheetController controller,
  ) {
    return Container(
      height: Sizer.hp(40),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(Sizer.wp(20)),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (textController.text.trim().isNotEmpty) {
              controller.updateProjectTitle(textController.text.trim());
            }
          },
          borderRadius: BorderRadius.circular(Sizer.wp(20)),
          child: Center(
            child: Text(
              'Confirm',
              style: AppTextStyle.f16W500().copyWith(
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
