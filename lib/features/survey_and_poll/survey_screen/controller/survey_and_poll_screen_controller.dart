import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_screen/model/survey_circle_statistics_model.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_screen/model/survey_progress_card_model.dart';

class SurveyAndPollScreenController extends GetxController {
  var surveys = <Survey>[].obs;
  var surveyAnalytics = <SurveyCircleStatisticsAnalyticsModel>[].obs;
  var poolResponses = <PoolResponseModel>[].obs;
  var selectedDate = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingAnalytics = false.obs;
  RxBool isLoadingPoolResponses = false.obs;
  var selectedSurveys = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    getActiveSurveys();
    getSurveyAnalytics();
    getPoolResponses();
    ever(surveys, (_) => _initializeSelectedSurveys());
  }

  //for deleting the survey
  void _initializeSelectedSurveys() {
    selectedSurveys.clear();
    for (var survey in surveys) {
      selectedSurveys[survey.id] = false;
    }
  }

  void toggleSurveySelection(String surveyId) {
    selectedSurveys[surveyId] = !(selectedSurveys[surveyId] ?? false);
    selectedSurveys.refresh();
  }

  // Toggle checkbox state (for deleting the survey/first ListView.builder list)
  Future<void> deleteSelectedSurveys() async {
    final surveysToDelete = selectedSurveys.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (surveysToDelete.isEmpty) {
      Get.snackbar('Info', 'No surveys selected for deletion');
      return;
    }

    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text(
          'Are you sure you want to delete ${surveysToDelete.length} survey(s)?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Get.back(result: true);
              Get.snackbar("Alert", "Deleted Successfully");
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final token = await StorageService.getAuthToken();
    if (token == null || token.isEmpty) {
      Get.snackbar('Error', 'Authentication token not found');
      return;
    }

    bool hasError = false;
    try {
      //  Get.dialog(Center(child: CircularProgressIndicator()), barrierDismissible: false);

      for (var surveyId in surveysToDelete) {
        final response = await http.delete(
          Uri.parse(
            'https://lgcglobalcontractingltd.com/js/admin/survey/$surveyId/delete',
          ),
          headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
        );

        if (response.statusCode != 200) {
          final jsonBody = json.decode(response.body);
          Get.snackbar(
            'Error',
            jsonBody['message'] ??
                'Failed to delete survey $surveyId: ${response.statusCode}',
          );
          hasError = true;
          break;
        }
      }

      if (!hasError) {
        surveys.removeWhere((survey) => surveysToDelete.contains(survey.id));
        selectedSurveys.removeWhere((key, _) => surveysToDelete.contains(key));
        await refreshData();
        Get.snackbar('Success', 'Selected surveys deleted successfully');
      }
    } catch (e) {
      Get.snackbar('Error', 'Exception occurred while deleting surveys: $e');
      hasError = true;
    } finally {
      Get.back();
      if (hasError) {
        await getActiveSurveys();
      }
    }
  }

  //This is for get user name with status(first ListView.builder)
  Future<void> getActiveSurveys() async {
    final token = await StorageService.getAuthToken();
    int page = 1;
    const int limit = 10;
    bool hasMore = true;

    surveys.clear();
    isLoading.value = true;

    while (hasMore) {
      final url =
          'https://lgcglobalcontractingltd.com/js/admin/survey/get-all?page=$page&limit=$limit&orderBy=asc';

      try {
        final response = await http.get(
          Uri.parse(url),
          headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
        );

        if (response.statusCode == 200) {
          final jsonBody = json.decode(response.body);
          final List<dynamic> data = jsonBody['data'];

          if (data.isEmpty) {
            hasMore = false;
          } else {
            final newSurveys = data
                .map((item) => Survey.fromJson(item))
                .toList();
            surveys.addAll(newSurveys);

            if (newSurveys.length < limit) {
              hasMore = false;
            } else {
              page++;
            }
          }
        } else {
          Get.snackbar(
            'Error',
            'Failed to load surveys: ${response.statusCode}',
          );
          hasMore = false;
        }
      } catch (e) {
        Get.snackbar('Error', 'Exception occurred: $e');
        hasMore = false;
      }
    }
    isLoading.value = false;
  }

  void pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDate.value = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  //This is for get survey circle statistics(second ListView.builder)
  Future<void> getSurveyAnalytics() async {
    final token = await StorageService.getAuthToken();

    if (token == null || token.isEmpty) {
      Get.snackbar('Error', 'Authentication token not found');
      return;
    }

    isLoadingAnalytics.value = true;
    surveyAnalytics.clear();

    try {
      final response = await http.get(
        Uri.parse(
          'https://lgcglobalcontractingltd.com/js/admin/survey-response/responses/analytics',
        ),
        headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);

        if (jsonBody['success'] == true && jsonBody['data'] != null) {
          final List<dynamic> data = jsonBody['data'];

          final analytics = data
              .map(
                (item) => SurveyCircleStatisticsAnalyticsModel.fromJson(item),
              )
              .toList();

          surveyAnalytics.addAll(analytics);

          debugPrint(
            'Successfully loaded ${analytics.length} survey analytics',
          );
        } else {
          Get.snackbar(
            'Error',
            jsonBody['message'] ?? 'Failed to load analytics',
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to load survey analytics: ${response.statusCode}',
        );
        debugPrint('Response body: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Exception occurred while loading analytics: $e');
      debugPrint('Exception: $e');
    } finally {
      isLoadingAnalytics.value = false;
    }
  }

  // Get Pool Responses/Survey Progress Card(third ListView.builder)
  Future<void> getPoolResponses() async {
    final token = await StorageService.getAuthToken();

    debugPrint('Starting getPoolResponses...');
    debugPrint('Token available: ${token != null && token.isNotEmpty}');

    if (token == null || token.isEmpty) {
      Get.snackbar('Error', 'Authentication token not found');
      return;
    }

    isLoadingPoolResponses.value = true;
    poolResponses.clear();

    try {
      final response = await http.get(
        Uri.parse(
          'https://lgcglobalcontractingltd.com/js/pool/pool-response/all',
        ),
        headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
      );

      debugPrint('Pool Response - Status code: ${response.statusCode}');
      debugPrint('Pool Response - Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);

        if (jsonBody['success'] == true && jsonBody['data'] != null) {
          final List<dynamic> data = jsonBody['data'];

          debugPrint('Pool Response - Data length: ${data.length}');

          final pools = data
              .map((item) => PoolResponseModel.fromJson(item))
              .toList();

          poolResponses.addAll(pools);

          debugPrint('Successfully loaded ${pools.length} pool responses');
          debugPrint(
            'poolResponses observable length: ${poolResponses.length}',
          );

          if (pools.isNotEmpty) {
            final firstPool = pools.first;
            debugPrint(
              'First pool: ${firstPool.title}, Options: ${firstPool.options.length}',
            );
          }
        } else {
          Get.snackbar(
            'Error',
            jsonBody['message'] ?? 'Failed to load pool responses',
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to load pool responses: ${response.statusCode}',
        );
        debugPrint('Pool Response - Error body: ${response.body}');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Exception occurred while loading pool responses: $e',
      );
      debugPrint('Pool Response - Exception: $e');
    } finally {
      isLoadingPoolResponses.value = false;
      debugPrint('isLoadingPoolResponses set to false');
    }
  }

  // Function to refresh both surveys and analytics
  Future<void> refreshData() async {
    await Future.wait([
      getActiveSurveys(),
      getSurveyAnalytics(),
      getPoolResponses(),
    ]);
  }

  // Function to get analytics for a specific survey
  SurveyCircleStatisticsAnalyticsModel? getAnalyticsForSurvey(String surveyId) {
    try {
      return surveyAnalytics.firstWhere(
        (analytics) => analytics.surveyId == surveyId,
      );
    } catch (e) {
      return null;
    }
  }
}

class Survey {
  final String id;
  final String title;
  final String status;

  Survey({required this.title, required this.status, required this.id});

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      id: json["id"],
      title: json['title'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
