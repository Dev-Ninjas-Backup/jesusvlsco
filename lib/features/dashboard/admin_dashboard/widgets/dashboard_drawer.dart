import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/common/widgets/common_divider.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/announcements/admin_announcement/screens/announcement_dashboard.dart';
import 'package:jesusvlsco/features/recognition/screens/recognition_dashboard.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_forward, color: AppColors.primary),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Sizer.hp(16),
          horizontal: Sizer.wp(16),
        ),
        child: Column(
          children: [
            _buildDrawerItem(
              imagePath: "assets/icons/drawer_notification.png",
              text: 'Announcement',
              onTap: () {
                Get.to(AnnouncementDashboard());
                // context.go('/home');
              },
            ),
            SizedBox(height: Sizer.hp(24)),
            const CommonDivider(height: 5),
            SizedBox(height: Sizer.hp(24)),
            _buildDrawerItem(
              imagePath: "assets/icons/drawer_survey.png",
              text: 'Survey & Poll',
              onTap: () {},
            ),
            SizedBox(height: Sizer.hp(24)),
            const CommonDivider(height: 5),
            SizedBox(height: Sizer.hp(24)),
            _buildDrawerItem(
              imagePath: 'assets/icons/drawer_recognition.png',
              text: 'Recognition',
              onTap: () {
                Get.to(RecognitionDashboard());
              },
            ),
            SizedBox(height: Sizer.hp(24)),
            const CommonDivider(height: 5),
            SizedBox(height: Sizer.hp(24)),
            _buildDrawerItem(
              imagePath: 'assets/icons/drawer_shift_scheduling.png',
              text: 'Shift Scheduling',
              onTap: () {},
            ),
            SizedBox(height: Sizer.hp(24)),
            const CommonDivider(height: 5),
            SizedBox(height: Sizer.hp(24)),
            _buildDrawerItem(
              imagePath: 'assets/icons/drawer_timelock.png',
              text: 'Timeclock',
              onTap: () {},
            ),
            SizedBox(height: Sizer.hp(24)),
            const CommonDivider(height: 5),
            SizedBox(height: Sizer.hp(24)),
            _buildDrawerItem(
              imagePath: 'assets/icons/drawer_time-off_requests.png',
              text: 'Time-off requests',
              onTap: () {},
            ),
            SizedBox(height: Sizer.hp(24)),
            const CommonDivider(height: 5),
            SizedBox(height: Sizer.hp(24)),
            _buildDrawerItem(
              imagePath: 'assets/icons/drawer_settings.png',
              text: 'Settings',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String imagePath,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Image.asset(imagePath, width: Sizer.wp(24), height: Sizer.hp(24)),
            SizedBox(width: Sizer.wp(8)),
            Text(
              text,
              style: AppTextStyle.f18W500().copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
