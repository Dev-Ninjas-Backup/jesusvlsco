import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/icon_path.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/taskmanagement/controller/activitycontroller.dart';

// ActivityFeedScreen widget
class ActivityFeedScreen extends StatelessWidget {
  const ActivityFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Activitycontroller activityController = Get.put(Activitycontroller());
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0), // A light grey background color
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          constraints: const BoxConstraints(), // Optional: for web/desktop view
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDateSelector(),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: activityController.dummyActivities.length,
                  itemBuilder: (context, index) {
                    final activity = activityController.dummyActivities[index];
                    return _buildActivityItem(
                      time: activity.time,
                      avatarUrl: activity.avatarUrl,
                      activityText: activity.activityText,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Container(
            width: Sizer.wp(142),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary),
              borderRadius: BorderRadius.circular(Sizer.wp(8)),
            ),
            child: Text(
              '19/06',
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(24),
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Container(
            width: Sizer.wp(88),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 14.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary),
              borderRadius: BorderRadius.circular(Sizer.wp(8)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  IconPath.celender,
                  height: Sizer.hp(24),
                  width: Sizer.wp(24),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.primary,
                  size: Sizer.wp(16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required String time,
    required String avatarUrl,
    required String activityText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80.0,
            child: Text(
              time,
              style: AppTextStyle.regular().copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,

                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          // Avatar and Calendar Icon Stack
          Row(
            children: [
              SvgPicture.asset(
                IconPath.nestclock,
                height: Sizer.hp(24),
                width: Sizer.wp(24),
              ),
              SizedBox(width: 8.0),

              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(avatarUrl),
              ),

              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  activityText,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) {
  return AppBar(
    shadowColor: AppColors.textWhite,
    backgroundColor: Colors.white,
    elevation: 0.1,
    leading: IconButton(
      icon: Icon(
        CupertinoIcons.arrow_left,
        color: AppColors.backgroundDark,
        size: Sizer.wp(24),
      ),
      onPressed: () {
        Get.back();
      },
    ),
    title: Text(
      'Activity Log',
      style: AppTextStyle.regular().copyWith(
        fontSize: Sizer.wp(20),
        color: AppColors.primary,
        fontWeight: FontWeight.w700,
      ),
    ),
    centerTitle: true,
    actions: [
      IconButton(
        icon: Icon(
          CupertinoIcons.bars,
          color: AppColors.backgroundDark,
          size: Sizer.wp(24),
        ),
        onPressed: () {
          // Handle menu action if needed
        },
      ),
    ],
  );
}
