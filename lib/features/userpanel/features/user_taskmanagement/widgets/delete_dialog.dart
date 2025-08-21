import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/announcements/admin_announcement/controllers/announcement_controller.dart';


class DeleteDialog extends StatelessWidget {
   DeleteDialog({super.key});

  final AnnouncementController _announcementController =
      Get.find<AnnouncementController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizer.wp(12)),
      ),
      title: Column(
        children: [
          Icon(
            Icons.cancel_outlined,
            color: AppColors.error,
            size: Sizer.wp(48),
          ),
          Text(
            "Are you sure",
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(20),
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: Text(
        "Do you want to delete these records? This process cannot be undone",
        style: AppTextStyle.regular().copyWith(
          fontSize: Sizer.wp(16),
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.error,
                ),
                child: Text(
                  "Delete",
                  style: AppTextStyle.regular().copyWith(
                    fontSize: Sizer.wp(16),
                    color: AppColors.primaryBackground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  _announcementController.clickdelete();
                  Get.back();
                },
              ),
            ),
            Expanded(
              child: TextButton(
                child: Text(
                  "Cancel",
                  style: AppTextStyle.regular().copyWith(
                    fontSize: Sizer.wp(16),
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
