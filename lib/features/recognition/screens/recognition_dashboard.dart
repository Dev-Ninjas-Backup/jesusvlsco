// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/icon_path.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/recognition/controllers/recognition_controller.dart';
import 'package:jesusvlsco/features/recognition/screens/badge_library.dart';
import 'package:jesusvlsco/features/recognition/screens/send_recognition.dart';

class RecognitionDashboard extends StatelessWidget {
  const RecognitionDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final RecognitionController controller = Get.put(RecognitionController());
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: cutombutton(
                    text: "Send recognition",
                    textcolor: AppColors.textWhite,
                    bgcolor: AppColors.primary,
                    brcolor: AppColors.primary,
                    onPressed: () {
                      Get.to(SendRecognition());
                    },
                  ),
                ),
                SizedBox(width: Sizer.wp(16)),
                Expanded(
                  child: cutombutton(
                    textcolor: AppColors.primary,
                    text: "Badge library",
                    bgcolor: Colors.transparent,
                    brcolor: AppColors.primary,
                    onPressed: () {
                      Get.to(BadgeLibrary());
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: Sizer.wp(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildDatePicker(() {
                  controller.selectDate(context);
                }),
              ],
            ),
          ),
          SizedBox(height: Sizer.hp(16)),

          // ListView.builder to render items dynamically
          Expanded(
            child: ListView.builder(
              itemCount: controller.users.length,
              itemBuilder: (context, index) {
                return _buildUserCard(controller.users[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Date Picker Container
  Widget _buildDatePicker(VoidCallback onpress) {
    return InkWell(
      onTap: onpress,
      child: Container(
        width: Sizer.wp(120),
        height: Sizer.hp(40),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          border: Border.all(width: 1, color: AppColors.primary),
          borderRadius: BorderRadius.circular(Sizer.wp(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.calendar_today, color: AppColors.primary),
            Text(
              "Date",
              style: AppTextStyle.regular().copyWith(color: AppColors.primary),
            ),
            Icon(Icons.arrow_drop_down, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  // User Card Builder
  Widget _buildUserCard(Map<String, dynamic> user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: Sizer.hp(72),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.textSecondary.withValues(alpha: 0.1),
              blurRadius: 3,
              offset: const Offset(0, 4),
            ),
          ],
          color: AppColors.primaryBackground,
          borderRadius: BorderRadius.circular(Sizer.wp(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: Sizer.wp(20),
                backgroundImage: NetworkImage(user["imageUrl"]),
              ),
              Text(
                user["name"],
                style: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(16),
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              SvgPicture.asset(
                IconPath.teamplayer,
                height: Sizer.wp(20),
                width: Sizer.wp(20),
              ),
              Text(
                user["name"], // If you have another field, use it here
                style: AppTextStyle.regular().copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              SvgPicture.asset(
                IconPath.likes,
                color: AppColors.textPrimary,
                height: Sizer.wp(20),
                width: Sizer.wp(20),
              ),
              VerticalDivider(color: AppColors.textSecondary, thickness: 1),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  SvgPicture.asset(
                    IconPath.message,
                    color: AppColors.textPrimary,
                    height: Sizer.wp(20),
                    width: Sizer.wp(20),
                  ),
                  CircleAvatar(
                    radius: Sizer.wp(6),
                    backgroundColor: AppColors.list,
                    child: Text(
                      user["messages"].toString(),
                      style: AppTextStyle.regular().copyWith(
                        fontSize: Sizer.wp(8),
                        color: AppColors.success,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      shadowColor: Colors.white,
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
        'Recognition',
        style: TextStyle(
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
          onPressed: () {},
        ),
      ],
    );
  }

  Widget cutombutton({
    required Color bgcolor,
    required Color brcolor,
    required String text,
    required Color textcolor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: Sizer.hp(40),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgcolor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: brcolor, width: 1),
            borderRadius: BorderRadius.circular(Sizer.wp(8)),
          ),
        ),
        onPressed: onPressed,
        child: FittedBox(
          child: Text(
            text,
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(16),
              color: textcolor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
