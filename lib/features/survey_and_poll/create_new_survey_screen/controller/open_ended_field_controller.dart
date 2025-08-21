import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpenEndedFieldController extends GetxController {
  final questionController = TextEditingController();
  final descriptionController = TextEditingController();
  final answerController = TextEditingController();

  final isRequired = false.obs;
  final locationStamp = false.obs;
}
