import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jesusvlsco/features/assign_employee/models/user_time_off_request_model.dart';

class TimeOffRepository {
  final String baseUrl = "https://lgcglobalcontractingltd.com/js/employee";
  final String token;

  TimeOffRepository({required this.token});

  Future<TimeOffRequestModel?> createTimeOffRequest({
    required String startDate,
    required String endDate,
    required String reason,
    required String type,
    required bool isFullDayOff,
    required int totalDaysOff,
  }) async {
    final url = Uri.parse("$baseUrl/time-off-request/create");

    final body = {
      "startDate": startDate,
      "endDate": endDate,
      "reason": reason,
      "type": type,
      "isFullDayOff": isFullDayOff,
      "totalDaysOff": totalDaysOff,
    };

    final response = await http.post(
      url,
      headers: {
        "accept": "*/*",
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("Response body: ${response.body}");

      final data = jsonDecode(response.body);
      if (data["success"] == true) {
        return TimeOffRequestModel.fromJson(data["data"]);
      } else {
        throw Exception(data["message"]);
      }
    } else {
      throw Exception(
        "Failed to create time off request. Status: ${response.statusCode}",
      );
    }
  }
}
