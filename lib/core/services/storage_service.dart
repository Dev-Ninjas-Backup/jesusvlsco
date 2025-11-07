import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/screen/login_screen.dart';

class StorageService {
  // Constants for preference keys
  static const String _tokenKey = 'auth_token';
  static const String _idKey = 'userId';

  // Singleton instance for SharedPreferences
  static SharedPreferences? _preferences;

  // Initialize SharedPreferences (call this during app startup)
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Check if a token exists in local storage
  static bool hasToken() {
    final token = _preferences?.getString(_tokenKey);
    return token != null;
  }

  // Save the token and user ID to local storage
  static Future<void> saveToken(String token, String id) async {
    await _preferences?.setString(_tokenKey, token);
    await _preferences?.setString(_idKey, id);
  }

  // Remove the token and user ID from local storage (for logout)
  static Future<void> logoutUser() async {
    await _preferences?.remove(_tokenKey);
    await _preferences?.remove(_idKey);
    // Navigate to the login screen
    // Get.offAllNamed('/login');
  }

  // Getter for user ID
  static String? get userId => _preferences?.getString(_idKey);

  // Getter for token
  static String? get token => _preferences?.getString(_tokenKey);

  static Future<String?> getId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id');

      debugPrint('📌 User ID: $userId');

      return userId;
    } catch (e) {
      if (kDebugMode) {
        print('🚨 Error getting user id: $e');
      }
      return null;
    }
  }

  // Helper method to get auth token
  static Future<String?> getAuthToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('auth_token');
    } catch (e) {
      if (kDebugMode) {
        print('🚨 Error getting auth token: $e');
      }
      return null;
    }
  }

  static Future<void> logout() async {
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

      if (kDebugMode) {
        print('✅ User logged out successfully');
      }

      // Navigate to login screen
      Get.offAll(() => LoginScreen());
    } catch (e) {
      if (kDebugMode) {
        print('🚨 Error during logout: $e');
      }
    }
  }
}
