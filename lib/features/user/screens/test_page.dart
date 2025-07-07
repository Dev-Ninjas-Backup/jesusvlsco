import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _requestPermission();
    _configureFirebaseMessaging();
  }

  Future<void> _requestPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  void _configureFirebaseMessaging() {
    // Get FCM Token
    FirebaseMessaging.instance.getToken().then((token) {
      print("FCM Token: $token");
    });

    // Handle messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Foreground message received: ${message.notification?.title}');

      // Display as local notification (to make it visible in foreground)
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel', // Must match ID in main.dart
              'High Importance Notifications',
              channelDescription: 'This channel is used for important notifications.',
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }

      // Save notification to Firestore
      await FirebaseFirestore.instance.collection('notifications').add({
        'title': message.notification?.title ?? 'No Title',
        'body': message.notification?.body ?? 'No Body',
        'timestamp': FieldValue.serverTimestamp(),
      });
    });

    // Handle messages when the user taps on a notification
    // from the background or terminated state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('Message opened from background/terminated: ${message.notification?.title}');
      // Save notification to Firestore
      await FirebaseFirestore.instance.collection('notifications').add({
        'title': message.notification?.title ?? 'No Title',
        'body': message.notification?.body ?? 'No Body',
        'timestamp': FieldValue.serverTimestamp(),
      });
    });

    // Handle initial message (if app was terminated and opened by tapping notification)
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
      if (message != null) {
        print('App opened from terminated state by notification: ${message.notification?.title}');
        // Save notification to Firestore
        await FirebaseFirestore.instance.collection('notifications').add({
          'title': message.notification?.title ?? 'No Title',
          'body': message.notification?.body ?? 'No Body',
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications History"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .orderBy('timestamp', descending: true) // Newest first
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No notifications yet. Send one from Firebase Console!'));
          }

          final notifications = snapshot.data!.docs
              .map((doc) => NotificationModel.fromFirestore(doc))
              .toList();

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 2,
                child: ListTile(
                  title: Text(
                    notification.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body),
                      SizedBox(height: 4),
                      Text(
                        '${notification.timestamp.toLocal().toString().split('.')[0]}',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



class NotificationModel {
  final String title;
  final String body;
  final DateTime timestamp;

  NotificationModel({
    required this.title,
    required this.body,
    required this.timestamp,
  });

  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      title: data['title'] ?? 'No Title',
      body: data['body'] ?? 'No Body',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}