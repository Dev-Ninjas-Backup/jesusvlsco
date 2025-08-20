import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/features/settings/widget/notification_container.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom_appbar(title: 'Notification Settings'),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationContainer(text: 'Email'),
            NotificationContainer(text: 'Communication'),
            NotificationContainer(text: 'Users'),
            NotificationContainer(text: 'Survey & poll'),
            NotificationContainer(text: 'Task & projects'),
            NotificationContainer(text: 'Scheduling'),
            NotificationContainer(text: 'Message'),
            SizedBox(height: 10),
            Text('User Registration', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.email_outlined),
                    SizedBox(width: 5),
                    Text('Email'),
                  ],
                ),
                SizedBox(width: 50),

                Row(
                  children: [
                    Icon(Icons.email_outlined),
                    SizedBox(width: 5),
                    Text('In-App'),
                  ],
                ),
              ],
            ),
            Divider(color: Colors.grey.shade300, thickness: 1),
          ],
        ),
      ),
    );
  }
}
