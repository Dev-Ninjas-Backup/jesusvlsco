import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:permission_handler/permission_handler.dart';




class NotificationController extends GetxController {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void onInit() {
    super.onInit();
    initNotification();
  }

  /// 🔔 Initialize notifications and create channel
  Future<void> initNotification() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Android settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');



    // iOS/Mac
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    // Full platform settings
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
          macOS: initializationSettingsDarwin,
        );

    // Create notification channel (Android)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'custom_sound_channel',
      'Custom Sound Channel',
      description: 'Channel for custom sound',
      importance: Importance.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
    );

    // Register channel
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    // Initialize plugin
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // Optional tap handler
      },
    );

    // 🔐 Request permission
    await requestNotificationPermission();
    // print("FCM tokennnnn: $FCMtoken");
  }

  /// 📢 Show instant notification
  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'custom_sound_channel',
          'Custom Sound Channel',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('notification_sound'),
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }

  /// ✅ Ask for notification permission
Future<String?> requestNotificationPermission() async {
  try {
    // Android permission
    if (Platform.isAndroid) {
      await Permission.notification.request();
    }
    
    // // iOS permission
    // if (Platform.isIOS) {
    //   await FirebaseMessaging.instance.requestPermission();
    // }
    
    // Get FCM token
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    
    if (fcmToken != null) {
      print("FCM Token: $fcmToken");
      return fcmToken;
    }
    
    return null;
  } catch (e) {
    print("Error: $e");
    return null;
  }
}

  // Future<void> shedule_alarm(
  //   int id,
  //   String title,
  //   String? body,
  //   DateTime dateTime,
  // ) async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     id,
  //     title,
  //     body,
  //     tz.TZDateTime.from(dateTime, tz.local),
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'alarm_channel',
  //         'Alarm Channel',
  //         channelDescription: 'Channel for scheduled alarms',
  //         importance: Importance.max,
  //         priority: Priority.high,
  //       ),
  //     ),

  //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //     matchDateTimeComponents: DateTimeComponents.dateAndTime,
  //     // uiLocalNotificationDateInterpretation:
  //     //     UILocalNotificationDateInterpretation.absoluteTime,
  //   );
  // }
}