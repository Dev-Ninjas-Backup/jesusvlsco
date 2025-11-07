import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jesusvlsco/core/services/storage_service.dart';

import '../../user_view_single_template/screen/user_view_single_template_screen.dart';

class UserSurveyController extends GetxController {
  // raw list for surveys only
  final surveys = <Map<String, dynamic>>[].obs;

  /// search input controller
  final searchController = TextEditingController();

  /// search text
  final searchQuery = ''.obs;

  final String token = StorageService.token ?? '';

  final String surveysUrl =
      "https://lgcglobalcontractingltd.com/js/employee/survey/assigned?page=1&limit=10";

  @override
  void onInit() {
    super.onInit();
    fetchSurveys();
  }

  /// Fetch surveys from API
  Future<void> fetchSurveys() async {
    try {
      final response = await http.get(
        Uri.parse(surveysUrl),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (kDebugMode) {
        print("Surveys response: ${response.body}");
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data["success"] == true && data["data"] != null) {
          final List<dynamic> surveyList = data["data"];
          surveys.value = surveyList.map((s) {
            return {
              "id": s["id"],
              "title": s["title"],
              "description": s["description"],
              "status": s["status"],
              "type": "survey",
            };
          }).toList();
          debugPrint("✅ Surveys loaded: ${surveys.length}");
        } else {
          Get.snackbar("Error", "No surveys found");
        }
      } else {
        Get.snackbar("Error", "Failed to load surveys");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  /// filtered list based on searchQuery
  List<Map<String, dynamic>> get filteredSurveys {
    if (searchQuery.value.trim().isEmpty) return surveys;
    final q = searchQuery.value.toLowerCase();
    return surveys.where((survey) {
      final t = (survey["title"] ?? "").toString().toLowerCase();
      return t.contains(q);
    }).toList();
  }

  /// called when user types in search
  void updateSearch(String value) {
    searchQuery.value = value;
  }

  /// navigate to survey details
  void takeSurvey(Map<String, dynamic> survey) {
    Get.to(() => const UserViewSingleTemplateScreen(), arguments: survey);
    debugPrint("Taking survey -> ${survey['title']}");
  }
}
