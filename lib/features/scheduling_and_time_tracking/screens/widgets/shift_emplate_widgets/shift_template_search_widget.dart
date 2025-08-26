import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/shift_template_controller.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';

/// Search Field Widget for Shift Template Screen
class ShiftTemplateSearchWidget extends StatelessWidget {
  const ShiftTemplateSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ShiftTemplateController>();

    return Container(
      width: double.infinity,
      height: Sizer.hp(48),
      padding: EdgeInsets.symmetric(
        horizontal: Sizer.wp(16),
        vertical: Sizer.hp(14),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF949494)),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(169, 183, 221, 0.08),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.searchController,
              onChanged: (value) => controller.searchQuery.value = value,
              style: AppTextStyle.f14W400().copyWith(
                color: const Color(0xFF949494),
                height: 1.45,
              ),
              decoration: InputDecoration(
                hintText: 'Search templates',
                hintStyle: AppTextStyle.f14W400().copyWith(
                  color: const Color(0xFF949494),
                  height: 1.45,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Image.asset(
            'assets/icons/search.png',
            width: Sizer.wp(20),
            height: Sizer.hp(20),
          ),
        ],
      ),
    );
  }
}
