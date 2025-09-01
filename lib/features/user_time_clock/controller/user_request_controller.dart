import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeOffController extends GetxController {
  final timeOffRequests = <TimeOffRequest>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  void fetchRequests() {
    // Simulate API fetch
    timeOffRequests.assignAll([
      TimeOffRequest(
        startDate: "02/09/25",
        endDate: "05/09/25",
        policy: "I need to go outside of Dhaka",
        requestedOn: "01/09/25",
        totalDays: 4,
        status: "PENDING",
        notes: "Trip to Sylhet",
      ),
      TimeOffRequest(
        startDate: "02/09/25",
        endDate: "03/09/25",
        policy: "I need to go outside of Dhaka",
        requestedOn: "01/09/25",
        totalDays: 2,
        status: "PENDING",
        notes: "Family visit",
      ),
    ]);
  }

  void viewNotes(TimeOffRequest request) {
    Get.defaultDialog(
      title: "Notes",
      content: Text(request.notes),
    );
  }
}
class TimeOffRequest {
  final String startDate;
  final String endDate;
  final String policy;
  final String requestedOn;
  final int totalDays;
  final String status;
  final String notes;

  TimeOffRequest({
    required this.startDate,
    required this.endDate,
    required this.policy,
    required this.requestedOn,
    required this.totalDays,
    required this.status,
    required this.notes,
  });
}
