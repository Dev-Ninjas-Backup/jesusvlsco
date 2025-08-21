import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SurveyAndPollScreenController extends GetxController {
  var surveys = <Survey>[].obs;
  var selectedDate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadSurveys();
  }

  void loadSurveys() {
    surveys.value = [
      Survey(title: "Survey A", status: "Active"),
      Survey(title: "Survey B", status: "Completed"),
      Survey(title: "Survey C", status: "Active"),
      Survey(title: "Survey D", status: "Completed"),
      Survey(title: "Survey D", status: "Completed"),
      Survey(title: "Survey D", status: "Completed"),
      Survey(title: "Survey D", status: "Completed"),
    ];
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
}

class Survey {
  final String title;
  final String status;

  Survey({required this.title, required this.status});
}
