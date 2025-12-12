// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jesusvlsco/features/auth/screen/login_screen.dart';
import 'package:jesusvlsco/features/bottom_navigation/screen/admin_bottom_navigation_scaffold.dart';
import 'package:jesusvlsco/features/bottom_navigation/screen/user_bottom_navigation_scaffold.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkUserAndNavigate();
  }

  void _checkUserAndNavigate() async {
    // Show splash for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    // Check if user is authenticated
    bool isAuthenticated = await _checkAuthentication();

    if (isAuthenticated) {
      // Check user role and navigate accordingly
      String userRole = await _getUserRole();

      if (userRole == 'ADMIN') {
        debugPrint(' Role : $userRole');
        Get.offAll(() => AdminBottomNavigationScaffold());
      } else if (userRole == 'SUPER_ADMIN') {
        debugPrint(' Role : $userRole');
        Get.offAll(() => AdminBottomNavigationScaffold());
      } else {
        debugPrint(' Role : $userRole');
        Get.offAll(() => const UserBottomNavigationScaffold());
      }
    } else {
      // Navigate to login
      Get.offAll(() => LoginScreen());
    }
  }

  Future<bool> _checkAuthentication() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Check if user is logged in
      bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

      // Check if user is verified
      bool isVerified = prefs.getBool('is_verified') ?? false;

      // Check if auth token exists
      String? token = prefs.getString('auth_token');

      String? userId = prefs.getString('user_id');

      // User is authenticated if they are logged in, verified, and have a token
      bool isAuthenticated = isLoggedIn && isVerified && (token!.isNotEmpty);

      print('🔍 Authentication Check:');
      print('   - Is Logged In: $isLoggedIn');
      print('   - Is Verified: $isVerified');
      print('   - Has Token: ${token!.isNotEmpty}');
      print('   - Final Result: $isAuthenticated');

      print('✅ User is authenticated: UserToken : $token');
      print('✅ User is authenticated: User ID : $userId');

      return isAuthenticated;
    } catch (e) {
      print('🚨 Error checking authentication: $e');
      return false;
    }
  }

  Future<String> _getUserRole() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String userRole = prefs.getString('user_role') ?? 'ADMIN';

      print('👤 User Role: $userRole');
      return userRole;
    } catch (e) {
      print('🚨 Error getting user role: $e');
      return 'user'; // Default to user role if error occurs
    }
  }

  // Helper method to get stored user data
  Future<Map<String, dynamic>?> getStoredUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? userData = prefs.getString('user_data');

      print('user data $userData');
      return json.decode(userData!) as Map<String, dynamic>;
    } catch (e) {
      print('🚨 Error getting stored user data: $e');
      return null;
    }
  }

  // Helper method to get auth token
  Future<String?> getAuthToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('auth_token');
    } catch (e) {
      print('🚨 Error getting auth token: $e');
      return null;
    }
  }

  Future<String?> getId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id');

      debugPrint('📌 User ID: $userId');

      return userId;
    } catch (e) {
      print('🚨 Error getting user id: $e');
      return null;
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Clear all user-related data
      await prefs.remove('auth_token');
      await prefs.remove('user_role');
      await prefs.remove('user_id');
      await prefs.remove('user_email');
      await prefs.remove('employee_id');
      await prefs.remove('is_verified');
      await prefs.remove('is_logged_in');
      await prefs.remove('user_profile');
      await prefs.remove('user_data');

      print('✅ User logged out successfully');

      // Navigate to login screen
      Get.offAll(() => LoginScreen());
    } catch (e) {
      print('🚨 Error during logout: $e');
    }
  }
}
