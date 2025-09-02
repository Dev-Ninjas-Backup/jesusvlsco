// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';
import 'dart:convert';

import 'package:jesusvlsco/features/user_time_clock/model/user_request_model.dart';

class UserRequestTimeOffController extends GetxController {
  var isLoading = true.obs;
  final timeOffRequests = <TimeOffRequest>[].obs;
  final dateFormatter = DateFormat('dd/MM/yyyy');


  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    isLoading.value = true;
    const url = '${ApiConstants.baseurl}/employee/time-off-request/my-requests';
    final token = await StorageService.getAuthToken(); 

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': '*/*',
          'Authorization': "Bearer $token",
        },
      );
      print("token of user request: $token");

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        final List<dynamic> data = jsonBody['data'];
        print(response.body);

        timeOffRequests.assignAll(
          data.map((e) => TimeOffRequest.fromJson(e)).toList(),
        );
      } else {
        
        print("Error: Failed to fetch requests: ${response.statusCode}");
        Get.snackbar("Error", "Failed to fetch requests: ${response.statusCode}");
      }
    } catch (e) {
      print("Something went wrong: $e");
      Get.snackbar("Exception", "Something went wrong: $e");
    }finally{
      isLoading.value = false;
    }
  }

  void viewNotes(TimeOffRequest request) {
    Get.defaultDialog(
      title: "Admin Note",
      content: Text(request.adminNote ?? ''),
    );
  }
}
