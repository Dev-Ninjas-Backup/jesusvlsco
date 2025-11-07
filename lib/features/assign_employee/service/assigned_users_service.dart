// services/assigned_users_service.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:jesusvlsco/features/assign_employee/models/assign_user_response_model.dart';

import 'package:jesusvlsco/features/splasho_screen/controller/splasho_controller.dart';
import 'package:logger/logger.dart';

class AssignedUsersService {
  final Logger _logger = Logger();
  final SplashController splashController = Get.find();

  static const String _baseUrl =
      'https://lgcglobalcontractingltd.com/js/employee';

  Future<Map<String, String>> get _headers async {
    final token = await splashController.getAuthToken();
    if (token == null) {
      throw Exception("Auth token is null");
    }
    return {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  Future<AssignedUsersResponse> getAssignedUsers({
    required String projectId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      _logger.i('Fetching assigned users for project: $projectId');

      var uri = Uri.parse('$_baseUrl/dashboard/assigned-users/$projectId');

      // Add date filters as query parameters if provided
      Map<String, String> queryParams = {};
      if (startDate != null) {
        queryParams['startDate'] = startDate.toIso8601String();
      }
      if (endDate != null) {
        queryParams['endDate'] = endDate.toIso8601String();
      }

      if (queryParams.isNotEmpty) {
        uri = uri.replace(queryParameters: queryParams);
      }

      _logger.i('Request URL: $uri');
      final headers = await _headers;
      final response = await http.get(uri, headers: headers);

      _logger.i('Assigned Users API Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final assignedUsersResponse = AssignedUsersResponse.fromJson(jsonData);
        _logger.i(
          'Assigned users fetched successfully: ${assignedUsersResponse.data.length} users',
        );
        return assignedUsersResponse;
      } else {
        _logger.e('API Error: ${response.statusCode} - ${response.body}');
        throw HttpException(
          'Failed to fetch assigned users: ${response.statusCode}',
          response.statusCode,
        );
      }
    } on FormatException catch (e) {
      _logger.e('JSON parsing error: $e');
      throw Exception('Failed to parse response data');
    } on HttpException catch (e) {
      _logger.e('HTTP error: ${e.message}');
      rethrow;
    } catch (e) {
      _logger.e('Unexpected error in getAssignedUsers: $e');
      throw Exception('Failed to fetch assigned users: $e');
    }
  }
}

class HttpException implements Exception {
  final String message;
  final int statusCode;

  HttpException(this.message, this.statusCode);

  @override
  String toString() => 'HttpException: $message';
}
