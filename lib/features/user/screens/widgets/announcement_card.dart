import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

// Announcement Model (if not already in a separate models file)
class AnnouncementModel {
  final String id;
  final String title;
  final String description;
  final String dateTime;
  final bool isRead;
  final bool hasResponse;

  AnnouncementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    this.isRead = false,
    this.hasResponse = false,
  });
}

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
            _buildCardHeader(),
            _buildCardTitle(),
            _buildCardDescription(),
            _buildCardActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardHeader() {
    return Padding(
      padding: EdgeInsets.all(Sizer.wp(16)),
      child: Text(
        announcement.dateTime,
        style: AppTextStyle.regular().copyWith(
          fontSize: Sizer.wp(12),
          color: AppColors.textSecondary.withOpacity(0.7),
          fontWeight: FontWeight.w400,
        ),
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
          color: AppColors.textSecondary.withOpacity(0.8),
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
          _buildResponseButton(),
          SizedBox(width: Sizer.wp(12)),
          _buildReadReceiptButton(),
        ],
      ),
    );
  }

  Widget _buildResponseButton() {
    return Container(
      height: Sizer.hp(36),
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizer.wp(18)),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onResponseTap ?? () {
          // Default action
          print('Response tapped for announcement: ${announcement.id}');
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
    );
  }

  Widget _buildReadReceiptButton() {
    return Expanded(
      child: Container(
        height: Sizer.hp(36),
        decoration: BoxDecoration(
          color: announcement.isRead ? AppColors.primary.withOpacity(0.7) : AppColors.primary,
          borderRadius: BorderRadius.circular(Sizer.wp(18)),
        ),
        child: InkWell(
          onTap: onReadReceiptTap ?? () {
            // Default action
            print('Read receipt tapped for announcement: ${announcement.id}');
          },
          borderRadius: BorderRadius.circular(Sizer.wp(18)),
          child: Center(
            child: Text(
              announcement.isRead ? 'Read' : 'Read receipt',
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