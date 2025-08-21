import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimeOfRequestUserScreenController extends GetxController{
  var selectedDate = ''.obs;
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