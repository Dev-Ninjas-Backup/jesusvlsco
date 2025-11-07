// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/models/Announcemodel.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/announcements/admin_announcement/controllers/announcement_controller.dart';
import 'package:jesusvlsco/features/announcements/admin_announcement/screens/response_page.dart';

// Announcement Model (if not already in a separate models file)

class AnnouncementCard extends StatelessWidget {
  final AnnouncementModel announcement;
  final VoidCallback? onResponseTap;
  final VoidCallback? onReadReceiptTap;

  const AnnouncementCard({
    super.key,
    required this.announcement,
    this.onResponseTap,
    this.onReadReceiptTap,
  });

  @override
  Widget build(BuildContext context) {
    final AnnouncementController announcementcontroller = Get.find();

    return Padding(
      padding: EdgeInsets.only(left: Sizer.wp(16), right: Sizer.wp(16)),
      child: Container(
        width: Sizer.wp(360),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(Sizer.wp(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardHeader(
              announcementcontroller.announcements.indexOf(announcement),
            ),
            _buildCardTitle(),
            _buildCardDescription(),
            _buildCardActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardHeader(int index) {
    final AnnouncementController announcementcontroller = Get.find();

    return Padding(
      padding: EdgeInsets.all(Sizer.wp(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            announcement.dateTime,
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(12),
              color: AppColors.textSecondary.withValues(alpha: 0.7),
              fontWeight: FontWeight.w400,
            ),
          ),
          Obx(
            () => announcementcontroller.isdelete.value
                ? Container()
                : SizedBox(
                    width: Sizer.wp(16),
                    height: Sizer.hp(16),
                    child: Checkbox(
                      value: announcementcontroller
                          .announcements[index]
                          .isChecked
                          .value, // Bind to the RxBool of the specific announcement
                      onChanged: (value) {
                        // Toggle the checkbox state for the specific index
                        announcementcontroller.toggleCheckbox(index);
                        if (kDebugMode) {
                          print(
                            "Checkbox value for index $index: ${announcementcontroller.announcements[index].isChecked.value}",
                          );
                        }
                      },
                      activeColor: AppColors.primary,
                      checkColor: Colors.white,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
      child: Text(
        announcement.title,
        style: AppTextStyle.regular().copyWith(
          fontSize: Sizer.wp(16),
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildCardDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizer.wp(16),
        vertical: Sizer.hp(8),
      ),
      child: Text(
        announcement.description,
        style: AppTextStyle.regular().copyWith(
          fontSize: Sizer.wp(14),
          color: AppColors.textSecondary.withValues(alpha: 0.8),
          fontWeight: FontWeight.w400,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildCardActions() {
    return Padding(
      padding: EdgeInsets.all(Sizer.wp(16)),
      child: Row(
        children: [
          _buildResponseButton(
            onResponseTap: () {
              Get.to(ResponsePage());
            },
          ),
          SizedBox(width: Sizer.wp(12)),
          _buildReadReceiptButton(),
        ],
      ),
    );
  }

  Widget _buildResponseButton({VoidCallback? onResponseTap}) {
    return InkWell(
      onTap: onResponseTap,
      child: Container(
        height: Sizer.hp(36),
        padding: EdgeInsets.symmetric(horizontal: Sizer.wp(20)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Sizer.wp(18)),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: InkWell(
          onTap:
              onResponseTap ??
              () {
                // Default action
                if (kDebugMode) {
                  print('Response tapped for announcement: ${announcement.id}');
                }
              },
          borderRadius: BorderRadius.circular(Sizer.wp(18)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.remove_red_eye_outlined,
                color: AppColors.primary,
                size: Sizer.wp(16),
              ),
              SizedBox(width: Sizer.wp(6)),
              Text(
                'Response',
                style: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(13),
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReadReceiptButton() {
    return Expanded(
      child: Container(
        height: Sizer.hp(36),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(Sizer.wp(18)),
        ),
        child: InkWell(
          onTap: onReadReceiptTap ?? () {},
          borderRadius: BorderRadius.circular(Sizer.wp(18)),
          child: Center(
            child: Text(
              'Read receipt',
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(13),
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
