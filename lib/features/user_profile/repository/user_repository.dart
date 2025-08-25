import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jesusvlsco/features/user_profile/models/user_model.dart';

class UserProfileRepository {
  final String token;

  UserProfileRepository({required this.token});

  Future<UserProfileModel?> fetchUserProfile(String userId) async {
    try {
      final url = Uri.parse(
        'https://lgcglobalcontractingltd.com/js/admin/user/id/$userId',
      );

      final response = await http.get(
        url,
        headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return UserProfileModel.fromJson(data);
      } else {
        debugPrint(
          '🚨 Failed to fetch profile. Status: ${response.statusCode}',
        );
        return null;
      }
    } catch (e) {
      debugPrint('🚨 Error fetching profile: $e');
      return null;
    }
  }
}
