import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/constants/sizer.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/common/styles/global_text_style.dart';
import '../../../controllers/shift_details_controller.dart';

/// Date and time selection widget for shift details
/// Provides date picker, all day toggle, and time selection
class ShiftDetailsDateTimeWidget extends StatelessWidget {
  final ShiftDetailsController controller;

  const ShiftDetailsDateTimeWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Date and All Day toggle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Date',
                  style: AppTextStyle.f14W400().copyWith(
                    color: const Color(0xFF949494),
                    height: 1.45,
                  ),
                ),
                SizedBox(width: Sizer.wp(8)),
                GestureDetector(
                  onTap: () => controller.selectDate(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizer.wp(12),
                      vertical: Sizer.hp(8),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF949494)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Obx(
                          () => Text(
                            controller.selectedDateFormatted.value,
                            style: AppTextStyle.f14W400().copyWith(
                              color: const Color(0xFF949494),
                              height: 1.45,
                            ),
                          ),
                        ),
                        SizedBox(width: Sizer.wp(8)),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: Sizer.wp(20),
                          color: const Color(0xFF949494),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'All Day',
                  style: AppTextStyle.f14W400().copyWith(
                    color: const Color(0xFF949494),
                    height: 1.45,
                  ),
                ),
                SizedBox(width: Sizer.wp(8)),
                Obx(
                  () => GestureDetector(
                    onTap: () => controller.toggleAllDay(),
                    child: Container(
                      width: Sizer.wp(40),
                      height: Sizer.hp(24),
                      padding: EdgeInsets.all(Sizer.wp(4)),
                      decoration: BoxDecoration(
                        color: controller.isAllDay.value
                            ? AppColors.primary
                            : const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(500),
                      ),
                      child: AnimatedAlign(
                        duration: const Duration(milliseconds: 200),
                        alignment: controller.isAllDay.value
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          width: Sizer.wp(16),
                          height: Sizer.wp(16),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: Sizer.hp(12)),

        // Start and End time selection (Always Visible)
        Row(
          children: [
            // Start time
            Expanded(
              child: Row(
                children: [
                  Text(
                    'Start',
                    style: AppTextStyle.f14W400().copyWith(
                      color: const Color(0xFF949494),
                      height: 1.45,
                    ),
                  ),
                  SizedBox(width: Sizer.wp(8)),
                  GestureDetector(
                    onTap: () => controller.selectStartTime(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizer.wp(12),
                        vertical: Sizer.hp(8),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF949494)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Obx(
                        () => Text(
                          controller.startTime.value,
                          style: AppTextStyle.f14W400().copyWith(
                            color: const Color(0xFF949494),
                            height: 1.45,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: Sizer.wp(16)),

            // End time
            Expanded(
              child: Row(
                children: [
                  Text(
                    'End',
                    style: AppTextStyle.f14W400().copyWith(
                      color: const Color(0xFF949494),
                      height: 1.45,
                    ),
                  ),
                  SizedBox(width: Sizer.wp(8)),
                  GestureDetector(
                    onTap: () => controller.selectEndTime(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizer.wp(12),
                        vertical: Sizer.hp(8),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF949494)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Obx(
                        () => Text(
                          controller.endTime.value,
                          style: AppTextStyle.f14W400().copyWith(
                            color: const Color(0xFF949494),
                            height: 1.45,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: Sizer.wp(16)),

            // Duration display
            Obx(
              () => Text(
                controller.duration.value,
                style: AppTextStyle.f12W400().copyWith(
                  color: const Color(0xFF484848),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
