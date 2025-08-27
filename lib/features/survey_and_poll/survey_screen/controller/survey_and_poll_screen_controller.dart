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
  RxBool isSelectedUser = false.obs;


  @override
  void onInit() {
    super.onInit();
    getActiveSurveys();
    getSurveyAnalytics();
    getPoolResponses();
  }


  //This is for get user name with status(first ListView.builder)
  Future<void> getActiveSurveys() async {
    final token = await StorageService.getAuthToken();
    int page = 1;
    const int limit = 10;
    bool hasMore = true;

    surveys.clear(); // Reset before loading
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
        Uri.parse('https://lgcglobalcontractingltd.com/js/admin/survey-response/responses/analytics'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        
        if (jsonBody['success'] == true && jsonBody['data'] != null) {
          final List<dynamic> data = jsonBody['data'];
          
          final analytics = data
              .map((item) => SurveyCircleStatisticsAnalyticsModel.fromJson(item))
              .toList();
          
          surveyAnalytics.addAll(analytics);
          
          print('Successfully loaded ${analytics.length} survey analytics');
        } else {
          Get.snackbar('Error', jsonBody['message'] ?? 'Failed to load analytics');
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to load survey analytics: ${response.statusCode}',
        );
        print('Response body: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Exception occurred while loading analytics: $e');
      print('Exception: $e');
    } finally {
      isLoadingAnalytics.value = false;
    }
  }


  // Get Pool Responses/Survey Progress Card(third ListView.builder)
  Future<void> getPoolResponses() async {
    final token = await StorageService.getAuthToken();
    
    print('Starting getPoolResponses...');
    print('Token available: ${token != null && token.isNotEmpty}');
    
    if (token == null || token.isEmpty) {
      Get.snackbar('Error', 'Authentication token not found');
      return;
    }

    isLoadingPoolResponses.value = true;
    poolResponses.clear();

    try {
      final response = await http.get(
        Uri.parse('https://lgcglobalcontractingltd.com/js/pool/pool-response/all'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        },
      );

      print('Pool Response - Status code: ${response.statusCode}');
      print('Pool Response - Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        
        if (jsonBody['success'] == true && jsonBody['data'] != null) {
          final List<dynamic> data = jsonBody['data'];
          
          print('Pool Response - Data length: ${data.length}');
          
          final pools = data
              .map((item) => PoolResponseModel.fromJson(item))
              .toList();
          
          poolResponses.addAll(pools);
          
          print('Successfully loaded ${pools.length} pool responses');
          print('poolResponses observable length: ${poolResponses.length}');
          
          // Debug: Print first pool if available
          if (pools.isNotEmpty) {
            final firstPool = pools.first;
            print('First pool: ${firstPool.title}, Options: ${firstPool.options.length}');
          }
          
        } else {
          Get.snackbar('Error', jsonBody['message'] ?? 'Failed to load pool responses');
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to load pool responses: ${response.statusCode}',
        );
        print('Pool Response - Error body: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Exception occurred while loading pool responses: $e');
      print('Pool Response - Exception: $e');
    } finally {
      isLoadingPoolResponses.value = false;
      print('isLoadingPoolResponses set to false');
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
      return surveyAnalytics.firstWhere((analytics) => analytics.surveyId == surveyId);
    } catch (e) {
      return null;
    }
  }

}

class Survey {
  final String id;
  final String title;
  final String status;

  Survey({required this.title, required this.status,required this.id});

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(id: json["id"],title: json['title'] ?? '', status: json['status'] ?? '');
  }
}
