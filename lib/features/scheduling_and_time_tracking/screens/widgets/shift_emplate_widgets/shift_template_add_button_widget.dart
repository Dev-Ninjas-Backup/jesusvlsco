import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/constants/sizer.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/common/styles/global_text_style.dart';
import '../../../controllers/shift_template_controller.dart';

/// Add Template Button Widget for Shift Template Screen
class ShiftTemplateAddButtonWidget extends StatelessWidget {
  const ShiftTemplateAddButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ShiftTemplateController>();

    return GestureDetector(
      onTap: () => controller.addTemplate(),
      child: Container(
        width: double.infinity,
        height: Sizer.hp(48),
        padding: EdgeInsets.all(Sizer.wp(12)),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: Sizer.wp(20), color: AppColors.primary),
            SizedBox(width: Sizer.wp(8)),
            Text(
              'Add Template',
              style: AppTextStyle.f16W500().copyWith(
                color: AppColors.primary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
