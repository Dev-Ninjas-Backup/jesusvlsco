import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/announcements/admin_announcement/controllers/announcement_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResponsePage extends StatelessWidget {
  const ResponsePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AnnouncementController announcementcontroller = Get.find();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        shadowColor: AppColors.textWhite,
        backgroundColor: AppColors.primaryBackground,
        elevation: 0.1,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.arrow_left,
            color: AppColors.backgroundDark,
            size: Sizer.wp(24),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Response',
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Progress Cards Section
            SizedBox(height: Sizer.hp(16)),
            Container(
              // height: Sizer.hp(196),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.border.withValues(alpha: 0.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(Sizer.wp(12)),
                // border: Border.all(color: AppColors.border, width: 1),
              ),
              // width: Sizer.wp(360),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(Sizer.wp(12)),
                    child: _buildProgressCard(
                      persentcolor: AppColors.progresstext,
                      title: '210 /250',
                      subtitle: 'Users have viewed',
                      progress: 210 / 250,
                      progressColor: AppColors.progress1,
                      icon: Icons.visibility,
                      iconColor: Colors.green,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      right: Sizer.wp(12),
                      left: Sizer.wp(4),
                    ),
                    child: _buildProgressCard(
                      persentcolor: AppColors.error,
                      title: '40 /250',
                      subtitle: 'Users have not viewed',
                      progress: 40 / 250,
                      progressColor: AppColors.progress2,
                      icon: Icons.visibility_off,
                      iconColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Sizer.hp(16)),
            Container(
              width: Sizer.wp(360),
              height: Sizer.hp(671),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Sizer.wp(12)),
                // border: Border.all(color: AppColors.border, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(),

                  child: ListView.builder(
                    itemCount: announcementcontroller.dummyUsers.length,
                    itemBuilder: (context, index) {
                      return _buildUserRow(
                        isSelected: false,
                        name: announcementcontroller.dummyUsers[index]['name'],
                        profileImageUrl: announcementcontroller
                            .dummyUsers[index]['profileImageUrl'],
                        statusText: announcementcontroller
                            .dummyUsers[index]['statusText'],
                        statusColor: announcementcontroller
                            .dummyUsers[index]['statusColor'],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard({
    required String title,
    required String subtitle,
    required double progress,
    required Color progressColor,
    required IconData icon,
    required Color iconColor,
    required Color persentcolor,
  }) {
    return Container(
      width: Sizer.wp(159),
      height: Sizer.hp(164),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.border.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizer.wp(12)),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Progress Circle
            CircularPercentIndicator(
              radius: Sizer.wp(25.0),
              lineWidth: 10.0,
              animation: true,
              percent: progress,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: progressColor,
              backgroundColor: AppColors.secondary,
            ),
            SizedBox(
              height: Sizer.hp(4),
            ), // Add some space between the progress circle and the percentage text
            // Percentage Text
            Text(
              "${(progress * 100).toInt()}%",
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(12),
                fontWeight: FontWeight.w600,
                color: persentcolor,
              ),
            ),
            SizedBox(
              height: Sizer.hp(6),
            ), // Space between the percentage and the title text
            // Title Text
            Text(
              title,
              style: AppTextStyle.textlarge().copyWith(
                fontSize: Sizer.wp(16),
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
              textAlign: TextAlign.center, // Ensure title is centered
            ),
            SizedBox(height: Sizer.hp(6)), // Space between title and subtitle
            // Subtitle Text
            Text(
              subtitle,
              style: AppTextStyle.textlarge().copyWith(
                fontSize: Sizer.wp(14),
                fontWeight: FontWeight.w400,
                color: AppColors.text,
              ),
              textAlign: TextAlign.center, // Ensure subtitle is centered
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserRow({
    required String name,
    String? profileImageUrl,
    required String statusText,
    required Color statusColor,
    required bool isSelected,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,

        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1)),
      ),
      child: Row(
        children: [
          // Checkbox
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue.shade600 : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Colors.blue.shade600 : Color(0xFFD1D5DB),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
              child: isSelected
                  ? Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
          ),

          const SizedBox(width: 12),

          // Profile Image
          CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFFE5E7EB),
            backgroundImage:
                profileImageUrl != null && profileImageUrl.isNotEmpty
                ? NetworkImage(profileImageUrl)
                : null,
            child: profileImageUrl == null || profileImageUrl.isEmpty
                ? Icon(Icons.person, color: Color(0xFF9CA3AF), size: 24)
                : null,
          ),

          const SizedBox(width: 12),

          // Name
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1F2937),
              ),
            ),
          ),

          // Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              statusText,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
