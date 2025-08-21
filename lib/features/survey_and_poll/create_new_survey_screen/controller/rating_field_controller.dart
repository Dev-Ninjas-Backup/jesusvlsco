import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingFieldController extends GetxController {
  final questionController = TextEditingController();
  final descriptionController = TextEditingController();

  final ratingValue = 3.obs;
  final isRequired = false.obs;
  final locationStamp = false.obs;

  void increment() {
    if (ratingValue.value < 5) ratingValue.value++;
  }

  void decrement() {
    if (ratingValue.value > 1) ratingValue.value--;
  }
}
