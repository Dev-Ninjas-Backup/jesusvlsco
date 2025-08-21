import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../user_view_single_template/screen/user_view_single_template_screen.dart';

class UserSurveyController extends GetxController {
  // raw list (will replace with API model later)
  final surveys = <Map<String, dynamic>>[].obs;

  /// search input controller
  final searchController = TextEditingController();

  /// search text
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSurveys();
  }

  /// TODO: Replace this with real API call
  Future<void> fetchSurveys() async {
    // simulate network
    await Future.delayed(const Duration(milliseconds: 300));
    surveys.value = [
      {"title": "Employee Satisfaction"},
      {"title": "Workplace Safety"},
      {"title": "Remote Work Flexibility"},
      {"title": "Employee Wellness Program"},
      {"title": "Diversity & Inclusion"},
      {"title": "Team Collaboration"},
      {"title": "New Policy Awareness"},
      {"title": "Employee Engagement"},
    ];
  }

  /// filtered list based on searchQuery
  List<Map<String, dynamic>> get filteredSurveys {
    if (searchQuery.value.trim().isEmpty) return surveys;
    final q = searchQuery.value.toLowerCase();
    return surveys.where((s) {
      final t = (s["title"] ?? "").toString().toLowerCase();
      return t.contains(q);
    }).toList();
  }

  /// called when user types in search
  void updateSearch(String value) {
    searchQuery.value = value;
  }

  /// TODO: Implement navigation or API action when user taps "Take survey"
  void takeSurvey(Map<String, dynamic> survey) {
    Get.to(() => UserViewSingleTemplateScreen(), arguments: survey);
    debugPrint("TODO: takeSurvey -> ${survey['title']}");
  }
}
