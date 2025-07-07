// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class Notificationpage extends StatefulWidget {
  const Notificationpage({Key? key}) : super(key: key);

  @override
  _NotificationpageState createState() => _NotificationpageState();
}

class _NotificationpageState extends State<Notificationpage> {
  // List to hold notification data and their read status
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();

    // Simulating a stream of notifications
    notifications = List.generate(10, (index) {
      return {
        'id': index,
        'title': 'New Message $index',
        'subtitle': 'You have a new message from John Doe.',
        'isRead': false, // Initially, all notifications are unread
      };
    });
  }

  // Toggle the read/unread state of a notification
  void toggleReadStatus(int index) {
    setState(() {
      notifications[index]['isRead'] = !notifications[index]['isRead'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // Separate notifications into unread and read
    var unreadNotifications = notifications
        .where((notification) => !notification['isRead'])
        .toList();
    var readNotifications = notifications
        .where((notification) => notification['isRead'])
        .toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        shadowColor: AppColors.textWhite,
        backgroundColor: Colors.white,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
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
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                  for (var notification in unreadNotifications)
                    _notificationTile(
                      iconData: Icons.notifications,
                      title: notification['title'],
                      subtitle: notification['subtitle'],
                      isRead: notification['isRead'],
                      onTap: () => toggleReadStatus(notification['id']),
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
                  for (var notification in readNotifications)
                    _notificationTile(
                      iconData: Icons.notifications,
                      title: notification['title'],
                      subtitle: notification['subtitle'],
                      isRead: notification['isRead'],
                      onTap: () => toggleReadStatus(notification['id']),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
          // height: Sizer.hp(88),

          // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                offset: isRead ? Offset(0, 2) : Offset(-4, 1),
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
