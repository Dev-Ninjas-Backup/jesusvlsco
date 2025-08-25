import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jesusvlsco/features/user_settings/models/notification_model.dart';

class UserSettingsRepository {
  final String token;

  UserSettingsRepository({required this.token});

  Future<NotificationSettingsModel?> fetchNotificationSettings() async {
    final url = Uri.parse(
      "https://lgcglobalcontractingltd.com/js/notification-setting",
    );

    try {
      final response = await http.get(
        url,
        headers: {"accept": "*/*", "Authorization": "Bearer $token"},
      );

      debugPrint(
        "Fetch Settings Response: ${response.statusCode} ${response.body}",
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body["success"] == true) {
          debugPrint("Settings fetched successfully");
          return NotificationSettingsModel.fromJson(body["data"]);
        } else {
          debugPrint("Fetch failed: ${body['message'] ?? 'No message'}");
        }
      } else {
        debugPrint("Fetch HTTP error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Exception fetching settings: $e");
    }
    return null;
  }

  Future<bool> updateNotificationSettings(
    NotificationSettingsModel settings,
  ) async {
    final url = Uri.parse(
      "https://lgcglobalcontractingltd.com/js/notification-setting",
    );

    try {
      final response = await http.patch(
        url,
        headers: {
          "accept": "*/*",
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(settings.toJson()),
      );

      debugPrint(
        "Update Settings Request Body: ${jsonEncode(settings.toJson())}",
      );
      debugPrint(
        "Update Settings Response: ${response.statusCode} ${response.body}",
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final success = body["success"] == true;
        debugPrint(
          success
              ? "Settings updated successfully"
              : "Failed to update settings: ${body['message'] ?? 'No message'}",
        );
        return success;
      } else {
        debugPrint("Update HTTP error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Exception updating settings: $e");
    }

    return false;
  }
}
