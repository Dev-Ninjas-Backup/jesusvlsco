import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/core/common/widgets/custom_button.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/settings/widget/custom_switch.dart';

class UserSettingsScreen extends StatelessWidget {
  const UserSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom_appbar(title: 'Notification Settings'),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 0),
            child: Container(
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
                // bottom: 10,
              ),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: const Color(0xFFEDEEF7)),
                  borderRadius: BorderRadius.circular(16),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x14A9B7DD),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildNotificationItem(
                    title: 'Email',
                    imgPath: 'assets/icons/mail.png',
                  ),
                  buildNotificationItem(
                    title: 'Communication',
                    imgPath: 'assets/icons/tooltip_2.png',
                  ),
                  buildNotificationItem(
                    title: 'Users',
                    imgPath: 'assets/icons/Property 1=Default.png',
                  ),
                  buildNotificationItem(
                    title: 'Survey & poll',
                    imgPath: 'assets/icons/Property 1=Default (1).png',
                  ),
                  buildNotificationItem(
                    title: 'Task & projects',
                    imgPath: 'assets/icons/add_task_inactive.png',
                  ),
                  buildNotificationItem(
                    title: 'Scheduling',
                    imgPath: 'assets/icons/schedulling_inactive.png',
                  ),
                  buildNotificationItem(
                    title: 'Message',
                    imgPath: 'assets/icons/mail.png',
                  ),
                ],
              ),
            ),
          ),

          _buildUserRegistrationView(),
          SizedBox(height: Sizer.hp(15)),
          Container(
            height: Sizer.hp(50),
            margin: EdgeInsets.all(15),
            child: CustomButton(
              textColor: Colors.white,
              isExpanded: true,
              onPressed: () {},
              text: 'Save Settings',
              decorationColor: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserRegistrationView() {
    return Container(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 10),
      margin: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFFEDEEF7)),
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x14A9B7DD),
            blurRadius: 8,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User Registration', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(Icons.email_outlined, size: 28),
                        SizedBox(width: 5),
                        Text('Email'),
                      ],
                    ),
                  ),

                  SizedBox(width: 50),
                  GestureDetector(
                    onTap: () {
                      Get.snackbar('title', 'message');
                    },
                    child: Row(
                      children: [
                        Icon(Icons.notifications_active_outlined, size: 28),
                        SizedBox(width: 5),
                        Text('In-App'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          CustomSwitch(),
        ],
      ),
    );
  }

  Widget buildNotificationItem({
    required String title,
    required String imgPath,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  imgPath,
                  height: Sizer.hp(24),
                  width: Sizer.wp(24),
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Text(title, style: const TextStyle(fontSize: 16)),
              ],
            ),
            CustomSwitch(),
          ],
        ),
        Divider(color: Colors.grey.shade300, thickness: 1),
      ],
    );
  }
}
