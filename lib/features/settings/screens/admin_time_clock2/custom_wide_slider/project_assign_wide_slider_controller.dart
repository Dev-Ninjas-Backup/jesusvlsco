import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeTimeSchemeController extends GetxController {
  final sliderValue = 0.0.obs;
  final scrollController = ScrollController();

  void onSliderChanged(double value) {
    sliderValue.value = value;
    final maxScroll = scrollController.position.maxScrollExtent;
    scrollController.jumpTo(value * maxScroll);
  }
}
