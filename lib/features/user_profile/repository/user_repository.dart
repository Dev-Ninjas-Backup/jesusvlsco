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

  Future<UserProfileModel?> updateProfile({
    String? firstName,
    String? lastName,
    String? gender,
    String? jobTitle,
    String? department,
    String? address,
    String? city,
    String? state,
    String? country,
    String? nationality,
    String? pinCode,
    String? profileUrl,
  }) async {
    try {
      final url = Uri.parse(
        'https://lgcglobalcontractingltd.com/js/employee/user/profile',
      );

      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['accept'] = '*/*';

      if (firstName != null) request.fields['firstName'] = firstName;
      if (lastName != null) request.fields['lastName'] = lastName;
      if (gender != null) request.fields['gender'] = gender;
      if (jobTitle != null) request.fields['jobTitle'] = jobTitle;
      if (department != null) request.fields['department'] = department;
      if (address != null) request.fields['address'] = address;
      if (city != null) request.fields['city'] = city;
      if (state != null) request.fields['state'] = state;
      if (country != null) request.fields['country'] = country;
      if (nationality != null) request.fields['nationality'] = nationality;
      if (pinCode != null) request.fields['pinCode'] = pinCode;
      if (profileUrl != null && profileUrl.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath('profileUrl', profileUrl),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return UserProfileModel.fromJson(data);
      } else {
        debugPrint(
          '🚨 Failed to update profile. Status: ${response.statusCode}',
        );
        debugPrint('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('🚨 Error updating profile: $e');
      return null;
    }
  }
}
