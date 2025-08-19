import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/poll/create_new_poll_two/screen/create_new_poll_two_screen.dart';

import '../../poll_list_template/screen/poll_list_template_screen.dart';

class CreateNewPollController extends GetxController {
  // Dropdown for Type
  var pollType = "Poll".obs;
  final pollTypes = ["Poll", "Survey"];

  // Title & Description
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  // Questions List
  var questions = <QuestionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Add first question by default
    addQuestion();
  }

  void setPollType(String? type) {
    if (type != null) pollType.value = type;
  }

  /// 🔑 Computed labels (Poll/Survey dynamic)
  String get titleLabel => "${pollType.value} Title";
  String get descriptionLabel => "${pollType.value} Description";
  String get detailsLabel => "${pollType.value} details";

  // Add a new question
  void addQuestion() {
    questions.add(QuestionModel());
  }

  void removeQuestion(int index) {
    if (questions.length > 1) {
      questions.removeAt(index);
    }
  }

  void addOption(int questionIndex) {
    questions[questionIndex].options.add(TextEditingController());
    questions.refresh();
  }

  void removeOption(int questionIndex, int optionIndex) {
    if (questions[questionIndex].options.length > 1) {
      questions[questionIndex].options.removeAt(optionIndex);
      questions.refresh();
    }
  }

  // Save poll template (Dummy for now)
  Future<void> saveTemplate() async {
    // TODO: Implement Save Template API
    debugPrint("TODO: Save Template API call with data: ${titleController.text}");
    Get.to(() => const PollListTemplateScreen());
  }

  // Publish poll (Dummy for now)
  Future<void> publishPoll() async {
    final pollData = {
      "type": pollType.value,
      "title": titleController.text,
      "description": descriptionController.text,
      "questions": questions.map((q) => q.toJson()).toList(),
    };

    // TODO: Implement Publish Poll API
    debugPrint("TODO: Publish Poll API call with data: $pollData");
    Get.to(() =>  CreateNewPollTwoScreen());
  }
}

class QuestionModel {
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> options = [
    TextEditingController(),
    TextEditingController(),
  ];

  Map<String, dynamic> toJson() {
    return {
      "question": questionController.text,
      "options": options.map((o) => o.text).toList(),
    };
  }
}
