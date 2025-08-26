// services/project_service.dart
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
    if (token == null) {
      throw Exception("Auth token is null");
    }
    return {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  Future<ProjectResponse> getAllProjects({int page = 1, int limit = 5}) async {
    try {
      _logger.i('Fetching projects - Page: $page, Limit: $limit');

      final uri = Uri.parse('$_baseUrl/project/all').replace(
        queryParameters: {'page': page.toString(), 'limit': limit.toString()},
      );

      _logger.i('Request URL: $uri');
      final headers = await _headers;
      final response = await http.get(uri, headers: headers);

      _logger.i('Projects API Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final projectResponse = ProjectResponse.fromJson(jsonData);
        _logger.i(
          'Projects fetched successfully: ${projectResponse.data.length} projects',
        );
        return projectResponse;
      } else {
        _logger.e('API Error: ${response.statusCode} - ${response.body}');
        throw HttpException(
          'Failed to fetch projects: ${response.statusCode}',
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
      _logger.e('Unexpected error in getAllProjects: $e');
      throw Exception('Failed to fetch projects: $e');
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
