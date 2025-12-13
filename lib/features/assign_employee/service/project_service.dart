import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jesusvlsco/features/assign_employee/models/project_model.dart';
import 'package:jesusvlsco/features/splasho_screen/controller/splasho_controller.dart';
import 'package:logger/logger.dart';

class ProjectService {
  final Logger _logger = Logger();
  final SplashController splashController = Get.find();

  static const String _baseUrl =
      'https://lgcglobalcontractingltd.com/js/employee';

  Future<Map<String, String>> get _headers async {
    final token = await splashController.getAuthToken();
    if (token == null || token.isEmpty) {
      throw Exception("Auth token is null or empty");
    }
    return {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  /// New API: Returns only the projects assigned to the current logged-in user
  Future<UserShiftScheduleResponse> getUserAssignedProjects() async {
    try {
      _logger.i('Fetching user assigned projects from shift-schedule API');

      final uri = Uri.parse('$_baseUrl/dashboard/shift-schedule');

      _logger.i('Request URL: $uri');
      final headers = await _headers;
      final response = await http.get(uri, headers: headers);

      _logger.i('Shift Schedule API Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final scheduleResponse = UserShiftScheduleResponse.fromJson(jsonData);

        _logger.i(
          'User projects fetched: ${scheduleResponse.data.projectWithShifts.length} projects',
        );
        return scheduleResponse;
      } else {
        _logger.e('API Error: ${response.statusCode} - ${response.body}');
        throw Exception(
          'Failed to fetch shift schedule: ${response.statusCode}',
        );
      }
    } catch (e) {
      _logger.e('Error in getUserAssignedProjects: $e');
      rethrow;
    }
  }
}
