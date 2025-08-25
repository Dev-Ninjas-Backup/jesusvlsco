import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/constants/sizer.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/common/styles/global_text_style.dart';
import '../../../controllers/shift_template_controller.dart';
import '../../../models/shift_template_model.dart';

/// Template List Widget for Shift Template Screen
class ShiftTemplateListWidget extends StatelessWidget {
  const ShiftTemplateListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ShiftTemplateController>();

    return Obx(
      () => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: controller.filteredTemplates.map((template) {
                return _buildTemplateCard(template, controller);
              }).toList(),
            ),
    );
  }

  Widget _buildTemplateCard(
    ShiftTemplateModel template,
    ShiftTemplateController controller,
  ) {
    return GestureDetector(
      onTap: () => controller.selectTemplate(template),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: Sizer.hp(24)),
        padding: EdgeInsets.all(Sizer.wp(16)),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        template.startTime,
                        style: AppTextStyle.f14W400().copyWith(
                          color: Colors.white,
                          height: 1.45,
                        ),
                      ),
                      SizedBox(width: Sizer.wp(8)),
                      Text(
                        '-',
                        style: AppTextStyle.f14W400().copyWith(
                          color: Colors.white,
                          height: 1.45,
                        ),
                      ),
                      SizedBox(width: Sizer.wp(8)),
                      Text(
                        template.endTime,
                        style: AppTextStyle.f14W400().copyWith(
                          color: Colors.white,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Sizer.hp(4)),
                  Text(
                    template.title,
                    style: AppTextStyle.f16W600().copyWith(
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
