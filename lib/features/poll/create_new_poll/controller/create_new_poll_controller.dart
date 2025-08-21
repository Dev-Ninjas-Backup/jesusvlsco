import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../survey_and_poll/create_new_survey_screen/screen/create_new_servey_screen.dart';


import '../../create_new_poll_two/screen/create_new_poll_two_screen.dart';
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
    if (type != null) {
      if (type == "Survey") {
        // 🔹 Direct navigate to Survey Screen
        Get.off(() =>  CreateNewSurveyScreen());
      } else {
        pollType.value = type;
      }
    }
  }

  /// 🔑 Computed labels (Poll only)
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
    debugPrint(
      "TODO: Save Template API call with data: ${titleController.text}",
    );
    Get.to(() => const PollListTemplateScreen(isPoll: true));
  }

  // Publish poll (Dummy for now)
  Future<void> publishPoll() async {
    final pollData = {
      "type": pollType.value,
      "title": titleController.text,
      "description": descriptionController.text,
      "questions": questions.map((q) => q.toJson()).toList(),
    };

    debugPrint("TODO: Publish Poll API call with data: $pollData");
    Get.to(() => const CreateNewPollTwoScreen());
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
