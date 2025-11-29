import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jesusvlsco/app.dart';
import 'package:jesusvlsco/features/announcements/admin_announcement/controllers/notification_controller.dart';
import 'package:jesusvlsco/features/user_time_clock/controller/user_time_clock_controller.dart';
import 'package:jesusvlsco/firebase_options.dart';
import 'core/services/location_controller.dart';
import 'core/services/request_handaler.dart';
import 'core/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  await requestPermissions();
  Get.put(UserTimeClockController(), permanent: true);
  final locationController = Get.put(LocationController());
  await locationController.initializeService();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationController notificationController = Get.put(
    NotificationController(),
  );
  notificationController.onInit();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  _configureEasyLoading();

  runApp(const Jesusvlsco());
}

void _configureEasyLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withValues(alpha: 0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}
