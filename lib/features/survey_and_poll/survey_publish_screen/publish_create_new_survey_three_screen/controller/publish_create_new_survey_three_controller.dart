import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PublishCreateNewSurveyThreeController extends GetxController {
  var publishOption = "Publish now".obs;
  var notifyEmployees = false.obs;
  var reminderEnabled = false.obs;
  var showOnFeed = false.obs;

  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;

  void setPublishOption(String option) {
    publishOption.value = option;
  }

  void toggleNotifyEmployees(bool value) {
    notifyEmployees.value = value;
  }

  void toggleReminder(bool value) {
    reminderEnabled.value = value;
  }

  void toggleShowOnFeed(bool value) {
    showOnFeed.value = value;
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  void setTime(TimeOfDay time) {
    selectedTime.value = time;
  }

  void nextStep() {
    // Navigate to Summary screen later
  }
}
