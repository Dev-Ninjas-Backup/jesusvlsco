import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  static LocationController get to => Get.find();
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
    _listenToBackgroundService();
  }

  Future<void> _initializeNotifications() async {
    // Define the notification channel for Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'location_channel', // Must match notificationChannelId in FlutterBackgroundService
      'Location Notifications',
      description: 'Notifications for location tracking',
      importance: Importance.high,
    );

    // Create the notification channel
    final androidPlugin = notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidPlugin?.createNotificationChannel(channel);

    // Initialize notifications
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );
    await notificationsPlugin.initialize(settings);
  }

  void _listenToBackgroundService() {
    FlutterBackgroundService().on('showDialog').listen((event) {
      if (event != null && event['isNearby'] == true) {
        Get.dialog(
          AlertDialog(
            title: const Text('Location Match'),
            content: const Text(
              'You are within 50 meters of the target location!',
            ),
            actions: [
              TextButton(onPressed: () => Get.back(), child: const Text('OK')),
            ],
          ),
          barrierDismissible: false,
        );
      }
    });
  }

  Future<void> initializeService() async {
    final service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
        foregroundServiceNotificationId: 888,
        notificationChannelId: 'location_channel',
        initialNotificationTitle: 'Location Tracking',
        initialNotificationContent: 'Tracking your location in the background',
      ),
      iosConfiguration: IosConfiguration(),
    );
    await service.startService();
  }
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
  }

  const double staticLat = 23.780708;
  const double staticLng = 90.400760;
  const double distanceThreshold = 50.0;

  // Create notification channel first
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'location_channel',
    'Location Notifications',
    description: 'Notifications for location tracking',
    importance: Importance.high,
  );
  final notificationsPlugin = FlutterLocalNotificationsPlugin();
  final androidPlugin = notificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();
  await androidPlugin?.createNotificationChannel(channel);

  // Initialize notifications after channel creation
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings settings = InitializationSettings(
    android: androidSettings,
  );
  await notificationsPlugin.initialize(settings);

  // Check if location services are enabled
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await notificationsPlugin.show(
      999,
      'Location Services Disabled',
      'Please enable location services to continue tracking.',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'location_channel',
          'Location Notifications',
          importance: Importance.high,
          priority: Priority.high,
          channelDescription: 'Notifications for location tracking',
        ),
      ),
    );
    return;
  }

  // Check location permissions
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await notificationsPlugin.show(
        999,
        'Location Permission Denied',
        'Please grant location permissions to continue tracking.',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'location_channel',
            'Location Notifications',
            importance: Importance.high,
            priority: Priority.high,
            channelDescription: 'Notifications for location tracking',
          ),
        ),
      );
      return;
    }
  }

  // Start location tracking with logging
  try {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen(
      (Position position) async {
        // Print current location
        print(
          'Current Location: Latitude: ${position.latitude}, Longitude: ${position.longitude}',
        );

        // Calculate and print distance to target location
        double distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          staticLat,
          staticLng,
        );
        print(
          'Distance to target location ($staticLat, $staticLng): $distance meters',
        );

        if (distance <= distanceThreshold) {
          print(
            'Within $distanceThreshold meters! Showing notification/dialog',
          );
          service.invoke('showDialog', {'isNearby': true});
          await notificationsPlugin.show(
            0,
            'Location Match',
            'You are within $distanceThreshold meters of the target location!',
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'location_channel',
                'Location Notifications',
                importance: Importance.high,
                priority: Priority.high,
                channelDescription: 'Notifications for location tracking',
              ),
            ),
          );
        }
      },
      onError: (dynamic error) async {
        print('Geolocator Error: $error');
        notificationsPlugin.show(
          999,
          'Location Error',
          'Failed to get location updates: $error',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'location_channel',
              'Location Notifications',
              importance: Importance.high,
              priority: Priority.high,
              channelDescription: 'Notifications for location tracking',
            ),
          ),
        );
        await Geolocator.openLocationSettings();
      },
    );
  } catch (e) {
    print('Location Service Error: $e');
    await notificationsPlugin.show(
      999,
      'Location Service Error',
      'Failed to start location tracking: $e',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'location_channel',
          'Location Notifications',
          importance: Importance.high,
          priority: Priority.high,
          channelDescription: 'Notifications for location tracking',
        ),
      ),
    );
  }
}
