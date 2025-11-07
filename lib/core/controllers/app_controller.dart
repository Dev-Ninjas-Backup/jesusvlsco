import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Sample controller showing how to integrate GetX with GoRouter
class AppController extends GetxController {
  // Reactive variables
  var isLoading = false.obs;
  var isDarkMode = false.obs;
  var currentUser = Rx<String?>(null);
  var notificationCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeApp();
  }

  @override
  void onReady() {
    super.onReady();
    if (kDebugMode) {
      print('AppController is ready');
    }
  }

  @override
  void onClose() {
    super.onClose();
    if (kDebugMode) {
      print('AppController is closed');
    }
  }

  /// Initialize app data
  void _initializeApp() {
    isLoading.value = true;

    // Simulate loading
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      if (kDebugMode) {
        print('App initialized');
      }
    });
  }

  /// Toggle theme
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  /// Login user
  Future<void> loginUser(String username) async {
    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      currentUser.value = username;
      notificationCount.value = 5; // Sample notification count

      Get.snackbar(
        'Success',
        'Welcome back, $username!',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Logout user
  void logoutUser() {
    currentUser.value = null;
    notificationCount.value = 0;

    Get.snackbar(
      'Logged out',
      'You have been logged out successfully',
      snackPosition: SnackPosition.TOP,
    );
  }

  /// Update notification count
  void updateNotificationCount(int count) {
    notificationCount.value = count;
  }

  /// Clear notifications
  void clearNotifications() {
    notificationCount.value = 0;
  }

  /// Check if user is logged in
  bool get isLoggedIn => currentUser.value != null;

  /// Get user display name
  String get userDisplayName => currentUser.value ?? 'Guest';
}
