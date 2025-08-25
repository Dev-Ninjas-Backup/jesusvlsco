import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/core/common/widgets/custom_button.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/user_settings/controller/notification_controller.dart';

class UserSettingsScreen extends StatelessWidget {
  const UserSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserSettingsController());

    return Scaffold(
      appBar: Custom_appbar(title: 'Notification Settings'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
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
                      value: controller.email,
                      onChanged: (val) =>
                          controller.toggleSwitch(controller.email, val),
                    ),
                    buildNotificationItem(
                      title: 'Communication',
                      imgPath: 'assets/icons/tooltip_2.png',
                      value: controller.communication,
                      onChanged: (val) => controller.toggleSwitch(
                        controller.communication,
                        val,
                      ),
                    ),

                    buildNotificationItem(
                      title: 'Survey & poll',
                      imgPath: 'assets/icons/Property 1=Default (1).png',
                      value: controller.surveyAndPoll,
                      onChanged: (val) => controller.toggleSwitch(
                        controller.surveyAndPoll,
                        val,
                      ),
                    ),
                    buildNotificationItem(
                      title: 'Task & projects',
                      imgPath: 'assets/icons/add_task_inactive.png',
                      value: controller.tasksAndProjects,
                      onChanged: (val) => controller.toggleSwitch(
                        controller.tasksAndProjects,
                        val,
                      ),
                    ),
                    buildNotificationItem(
                      title: 'Scheduling',
                      imgPath: 'assets/icons/schedulling_inactive.png',
                      value: controller.scheduling,
                      onChanged: (val) =>
                          controller.toggleSwitch(controller.scheduling, val),
                    ),
                    buildNotificationItem(
                      title: 'Message',
                      imgPath: 'assets/icons/mail.png',
                      value: controller.message,
                      onChanged: (val) =>
                          controller.toggleSwitch(controller.message, val),
                    ),
                  ],
                ),
              ),
            ),
            _buildUserRegistrationView(controller),
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
        );
      }),
    );
  }

  Widget _buildUserRegistrationView(UserSettingsController controller) {
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
          Switch(
            value: controller.userRegistration.value,
            onChanged: (val) =>
                controller.toggleSwitch(controller.userRegistration, val),
          ),
        ],
      ),
    );
  }

  Widget buildNotificationItem({
    required String title,
    required String imgPath,
    required RxBool value,
    required Function(bool) onChanged,
  }) {
    return Obx(
      () => Column(
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
              Switch(value: value.value, onChanged: onChanged),
            ],
          ),
          Divider(color: Colors.grey.shade300, thickness: 1),
        ],
      ),
    );
  }
}
