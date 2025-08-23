import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../model/survey_report_model.dart';
import 'package:intl/intl.dart';

class SurveyReportController extends GetxController {
  var reports = <SurveyReportModel>[].obs;

  /// sort state (true = ascending, false = descending)
  var isAscending = true.obs;

  // Scroll controller and reactive variables for slider
  final ScrollController scrollController = ScrollController();
  var scrollPosition = 0.0.obs;
  var maxScrollExtent = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadReports();
    _setupScrollListener();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.hasClients) {
        maxScrollExtent.value = scrollController.position.maxScrollExtent;
        scrollPosition.value = scrollController.offset;
      }
    });
  }

  void onSliderDrag(double value) {
    scrollController.animateTo(
      value,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  void loadReports() {
    reports.value = [
      SurveyReportModel(
        date: "8/2/19",
        name: "Arlene McCoy",
        jobSatisfaction: "Satisfied",
        managerSupport: "Satisfied",
        workLifeBalance: "Satisfied",
        leaderRating: 5,
      ),
      SurveyReportModel(
        date: "5/27/15",
        name: "Savannah Nguyen",
        jobSatisfaction: "Satisfied",
        managerSupport: "Satisfied",
        workLifeBalance: "Satisfied",
        leaderRating: 4,
      ),
      SurveyReportModel(
        date: "11/7/16",
        name: "Darrell Steward",
        jobSatisfaction: "Dissatisfied",
        managerSupport: "Dissatisfied",
        workLifeBalance: "Dissatisfied",
        leaderRating: 3,
      ),
      SurveyReportModel(
        date: "4/21/12",
        name: "Jacob Jones",
        jobSatisfaction: "Neutral",
        managerSupport: "Neutral",
        workLifeBalance: "Dissatisfied",
        leaderRating: 2,
      ),
      SurveyReportModel(
        date: "9/4/12",
        name: "Kathryn Murphy",
        jobSatisfaction: "Satisfied",
        managerSupport: "Satisfied",
        workLifeBalance: "Satisfied",
        leaderRating: 5,
      ),
      SurveyReportModel(
        date: "8/15/17",
        name: "Albert Flores",
        jobSatisfaction: "Satisfied",
        managerSupport: "Satisfied",
        workLifeBalance: "Satisfied",
        leaderRating: 5,
      ),
    ];
  }

  /// Convert String -> DateTime
  DateTime _parseDate(String dateStr) {
    try {
      return DateFormat("M/d/yy").parse(dateStr);
    } catch (e) {
      return DateTime.now();
    }
  }

  /// Toggle sort order and sort list
  void toggleDateSort() {
    isAscending.value = !isAscending.value;
    reports.sort((a, b) {
      final dateA = _parseDate(a.date);
      final dateB = _parseDate(b.date);
      return isAscending.value
          ? dateA.compareTo(dateB)
          : dateB.compareTo(dateA);
    });
  }
}
