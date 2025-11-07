import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

// AppNotification model to hold notification data
class AppNotification {
  final RemoteMessage message;
  bool isRead;

  AppNotification({required this.message, this.isRead = false});
}

class NotificationController extends GetxController {
  final RxList<AppNotification> _notifications = <AppNotification>[].obs;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  List<AppNotification> get notifications => _notifications.toList();

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
    _setupFCMListeners();
  }

  // Initialize local notifications
  Future<void> _initializeNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Android setup (make sure the icon is placed in res/drawable folder)
    const initializationSettingsAndroid = AndroidInitializationSettings('ic_notification'); // Refer to icon without .png extension
    const initializationSettingsIOS = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // Initialize the plugin
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Request notification permission
    await _requestNotificationPermission();
  }

  // Set up Firebase Cloud Messaging listeners
  Future<void> _setupFCMListeners() async {
    // Foreground message handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _addNotification(message);
    });

    // Background message handler (requires top-level function)
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessageHandler);

    // Handle notification tap from background or terminated state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessageTap(message);
    });

    // Handle app launch from a terminated state (if notification was tapped)
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) _addNotification(initialMessage);
  }

  // Add a new notification to the list (ensure no duplicates)
  void _addNotification(RemoteMessage message) {
    final existingNotification = _notifications.firstWhereOrNull(
      (notif) => notif.message.messageId == message.messageId,
    );

    if (existingNotification == null) {
      _notifications.add(AppNotification(message: message, isRead: false));
    } else {
      existingNotification.isRead = false;  // Optionally mark as unread again if needed
      _notifications.refresh();
    }
  }

  // Handle notification tap (mark as read)
  void _handleMessageTap(RemoteMessage message) {
    final existingNotification = _notifications.firstWhereOrNull(
      (notif) => notif.message.messageId == message.messageId,
    );

    if (existingNotification == null) {
      _addNotification(message);
    } else {
      existingNotification.isRead = true;
      _notifications.refresh();
    }
  }

  // Request notification permission for iOS and Android
  Future<void> _requestNotificationPermission() async {
    try {
      if (Platform.isAndroid) {
        await Permission.notification.request();
      }

      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // Get the FCM token
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (kDebugMode) {
        print("FCM Token: $fcmToken");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error requesting permission or getting token: $e");
      }
    }
  }

  // Method to toggle the read status for a specific notification by its message ID
  void toggleReadStatus(String messageId) {
    final index = _notifications.indexWhere(
      (notif) => notif.message.messageId == messageId,
    );
    if (index != -1) {
      _notifications[index].isRead = !_notifications[index].isRead;
      _notifications.refresh();
    }
  }
}

// This must be a top-level function
Future<void> _firebaseBackgroundMessageHandler(RemoteMessage message) async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const androidDetails = AndroidNotificationDetails(
    'high_importance_channel',
    'High Importance Channel',
    channelDescription: 'Channel for high priority notifications',
    importance: Importance.high,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('notification_sound'),
    icon: 'ic_notification', // Custom icon
    channelShowBadge: true,
    enableVibration: true,
    priority: Priority.high,
  );

  const platformDetails = NotificationDetails(android: androidDetails);

  // Show notification
  await flutterLocalNotificationsPlugin.show(
    message.messageId.hashCode,
    message.notification?.title,
    message.notification?.body,
    platformDetails,
    payload: message.data.toString(),
  );
}
