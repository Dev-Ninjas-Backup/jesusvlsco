import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

import '../controller/user_time_clock_controller.dart';

void showCustomClockDialog(BuildContext context) {
  // State to manage loading for each button
  RxBool isClockInLoading = false.obs;
  RxBool isClockOutLoading = false.obs;
  UserTimeClockController userTimeClockController = Get.put(
    UserTimeClockController(),
  );

  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizer.wp(16)),
          ),
          backgroundColor: AppColors.backgroundLight,
          elevation: 8,
          contentPadding: EdgeInsets.symmetric(
            horizontal: Sizer.wp(24),
            vertical: Sizer.hp(24),
          ),
          titlePadding: EdgeInsets.only(
            top: Sizer.hp(16),
            left: Sizer.wp(24),
            right: Sizer.wp(24),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Choose an Action",
                style: AppTextStyle.semibold().copyWith(
                  fontSize: 20,
                  color: AppColors.textPrimary,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Container(
                  padding: EdgeInsets.all(Sizer.wp(4)),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.color2.withOpacity(0.2),
                  ),
                  child: Icon(Icons.close, color: AppColors.accent, size: 20),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select whether to clock in or clock out",
                textAlign: TextAlign.center,
                style: AppTextStyle.regular().copyWith(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: Sizer.hp(24)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(
                    () => SizedBox(
                      width: Sizer.wp(120),
                      height: Sizer.hp(48),
                      child: ElevatedButton(
                        onPressed: isClockInLoading.value
                            ? null
                            : () async {
                                isClockInLoading.value = true;
                                try {
                                  userTimeClockController.clockInNow();
                                  Get.back();
                                } catch (e) {
                                  Get.snackbar('Error', 'Clock In failed: $e');
                                } finally {
                                  isClockInLoading.value = false;
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.info, // Green for Clock In
                          foregroundColor: AppColors.textWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Sizer.wp(8)),
                          ),
                          elevation: 2,
                        ),
                        child: isClockInLoading.value
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: AppColors.textWhite,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                "Clock In",
                                style: AppTextStyle.semibold().copyWith(
                                  fontSize: 16,
                                  color: AppColors.textWhite,
                                ),
                              ),
                      ),
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      width: Sizer.wp(120),
                      height: Sizer.hp(48),
                      child: ElevatedButton(
                        onPressed: isClockOutLoading.value
                            ? null
                            : () async {
                                isClockOutLoading.value = true;
                                try {
                                  userTimeClockController.clockOutNow();
                                  Get.back();
                                } catch (e) {
                                  Get.snackbar('Error', 'Clock Out failed: $e');
                                } finally {
                                  isClockOutLoading.value = false;
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors.accent, // Red for Clock Out
                          foregroundColor: AppColors.textWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Sizer.wp(8)),
                          ),
                          elevation: 2,
                        ),
                        child: isClockOutLoading.value
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: AppColors.textWhite,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                "Clock Out",
                                style: AppTextStyle.semibold().copyWith(
                                  fontSize: 16,
                                  color: AppColors.textWhite,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
