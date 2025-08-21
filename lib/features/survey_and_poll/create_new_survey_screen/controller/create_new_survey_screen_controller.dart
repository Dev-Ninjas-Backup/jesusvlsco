import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CreateNewSurveyScreenController extends GetxController {
  final questionController = TextEditingController();
  final answerControllers = <TextEditingController>[TextEditingController()].obs;

  final isRequired = false.obs;
  final locationStamp = false.obs;
  final multipleSelection = false.obs;

  void addAnswerField() {
    answerControllers.add(TextEditingController());
  }

  void removeAnswerField(int index) {
    if (answerControllers.length > 1) {
      answerControllers.removeAt(index);
    }
  }
}
