import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jesusvlsco/app.dart';
import 'package:jesusvlsco/features/announcements/admin_announcement/controllers/notification_controller.dart';
import 'package:jesusvlsco/firebase_options.dart';

import 'core/services/location_controller.dart';
import 'core/services/request_handaler.dart';
import 'core/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  await requestPermissions();
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
  runApp(const Jesusvlsco());
}
