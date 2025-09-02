// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/announcements/admin_announcement/controllers/notification_controller.dart'; // Ensure this import is correct

class Notificationpage extends StatefulWidget {
  const Notificationpage({Key? key}) : super(key: key);

  @override
  _NotificationpageState createState() => _NotificationpageState();
}

class _NotificationpageState extends State<Notificationpage> {
  // GetX controller instance. Get.put() ensures it's initialized and available.
  final NotificationController _notificationController = Get.put(
    NotificationController(),
  );

  @override
  void initState() {
    super.initState();
    // The notification fetching logic is now entirely in NotificationController's onInit
    // and its fetchMessages method.
    // No need for local 'notifications' list or simulation here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        shadowColor: AppColors.textWhite,
        backgroundColor: Colors.white,
        elevation: 0.1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'Notification',
          style: AppTextStyle.regular().copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              // Handle menu action if needed
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            // Obx rebuilds its content whenever _notificationController.notifications changes
            child: Obx(() {
              // Separate notifications into unread and read using the controller's list
              var unreadNotifications = _notificationController.notifications
                  .where((notif) => !notif.isRead)
                  .toList();
              var readNotifications = _notificationController.notifications
                  .where((notif) => notif.isRead)
                  .toList();

              // If no notifications, show a centered message
              if (_notificationController.notifications.isEmpty) {
                return Center(
                  child: Text(
                    'No notifications received yet.',
                    style: AppTextStyle.regular(),
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Unread Section
                    if (unreadNotifications.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Text(
                          'Unread',
                          style: AppTextStyle.regular().copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    // Unread Notifications List
                    for (var appNotification in unreadNotifications)
                      _notificationTile(
                        iconData: Icons.notifications,
                        title:
                            appNotification.message.notification?.title ??
                            'No Title',
                        subtitle:
                            appNotification.message.notification?.body ??
                            'No Body',
                        isRead: appNotification.isRead,
                        // Use the messageId for toggling read status in the controller
                        onTap: () => _notificationController.toggleReadStatus(
                          appNotification.message.messageId!,
                        ),
                      ),

                    // Read Section
                    if (readNotifications.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                        child: Text(
                          'Read',
                          style: AppTextStyle.regular().copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    // Read Notifications List
                    for (var appNotification in readNotifications)
                      _notificationTile(
                        iconData: Icons.notifications,
                        title:
                            appNotification.message.notification?.title ??
                            'No Title',
                        subtitle:
                            appNotification.message.notification?.body ??
                            'No Body',
                        isRead: appNotification.isRead,
                        // Use the messageId for toggling read status in the controller
                        onTap: () => _notificationController.toggleReadStatus(
                          appNotification.message.messageId!,
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// The _notificationTile widget remains exactly as you provided it,
// ensuring no design changes.
Widget _notificationTile({
  required IconData iconData,
  required String title,
  required String subtitle,
  required bool isRead,
  required VoidCallback onTap,
}) {
  return Stack(
    alignment: Alignment.topRight,
    children: [
      Padding(
        padding: EdgeInsets.only(
          left: Sizer.wp(15),
          right: Sizer.wp(15),
          top: Sizer.hp(8),
          bottom: Sizer.hp(6),
        ),
        child: Container(
          width: Sizer.wp(362),

          // height: Sizer.hp(88), // Height might need to be dynamic based on content
          decoration: BoxDecoration(
            border: Border.all(
              color: isRead ? Colors.transparent : AppColors.primary,
              width: 1,
            ),
            color: AppColors.backgroundLight,
            boxShadow: [
              BoxShadow(
                color: isRead ? AppColors.background : AppColors.primary,
                spreadRadius: 2,
                blurRadius: isRead ? 4 : 0,
                offset: isRead ? const Offset(0, 2) : const Offset(-4, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.only(
              left: Sizer.wp(12),
              right: Sizer.wp(12),
              top: Sizer.hp(16),
              bottom: Sizer.hp(16),
            ),
            leading: CircleAvatar(
              radius: Sizer.wp(20),
              backgroundColor: const Color.fromARGB(255, 204, 205, 239),
              child: Icon(iconData, color: AppColors.primary, size: 25),
            ),
            title: Text(
              title,
              style: AppTextStyle.regular().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            subtitle: Text(
              subtitle,
              style: AppTextStyle.regular().copyWith(
                fontSize: 14,
                color: AppColors.backgroundDark,
              ),
            ),
            onTap: onTap, // Toggle read/unread on tap
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: Sizer.wp(25), top: Sizer.wp(15)),
        child: CircleAvatar(
          radius: 5,
          backgroundColor: isRead ? Colors.transparent : AppColors.primary,
        ),
      ),
    ],
  );
}
