import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/constants/sizer.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/common/styles/global_text_style.dart';
import '../../../controllers/shift_template_controller.dart';

/// App Bar Widget for Shift Template Screen
class ShiftTemplateAppBarWidget extends StatelessWidget {
  const ShiftTemplateAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ShiftTemplateController>();

    return Container(
      height: Sizer.hp(96),
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(169, 183, 221, 0.08),
            offset: Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => controller.goBack(),
            child: SizedBox(
              width: Sizer.wp(24),
              height: Sizer.wp(24),
              child: Icon(
                Icons.arrow_back_ios,
                size: Sizer.wp(16),
                color: AppColors.primary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Shift Template',
              textAlign: TextAlign.center,
              style: AppTextStyle.f20W700().copyWith(
                color: AppColors.primary,
                height: 1.4,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Show menu options
            },
            child: SizedBox(
              width: Sizer.wp(24),
              height: Sizer.wp(24),
              child: Icon(
                Icons.more_vert,
                size: Sizer.wp(20),
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
