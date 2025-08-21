import 'package:get/get.dart';
import 'package:jesusvlsco/features/user_survey_poll/user_poll/screen/user_poll_screen.dart';

class UserViewSingleTemplateController extends GetxController {
  // TODO: replace with API model later
  final questions = <Map<String, dynamic>>[].obs;
  final currentIndex = 0.obs;

  // selected answer index
  final selectedAnswer = Rxn<int>();

  @override
  void onInit() {
    super.onInit();
    fetchSurveyDetail();
  }

  /// TODO: Fetch survey details (title, questions, progress) from API using surveyId
  void fetchSurveyDetail() async {
    // simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    questions.value = [
      {
        "id": 1,
        "question": "How satisfied are you with the current safety protocols on-site?",
        "options": [
          "Very Satisfied",
          "Satisfied",
          "Neutral",
          "Unsatisfied",
          "Very Unsatisfied"
        ]
      },
      {
        "id": 2,
        "question": "How would you rate the communication within your team?",
        "options": [
          "Excellent",
          "Good",
          "Average",
          "Poor",
          "Very Poor"
        ]
      },
      {
        "id": 3,
        "question": "Do you feel supported by your manager/supervisor?",
        "options": [
          "Strongly Agree",
          "Agree",
          "Neutral",
          "Disagree",
          "Strongly Disagree"
        ]
      },
      {
        "id": 4,
        "question": "How would you rate your overall work-life balance?",
        "options": [
          "Very Good",
          "Good",
          "Fair",
          "Poor",
          "Very Poor"
        ]
      },
      {
        "id": 5,
        "question": "Would you recommend this company as a good place to work?",
        "options": [
          "Definitely Yes",
          "Probably Yes",
          "Not Sure",
          "Probably No",
          "Definitely No"
        ]
      },
      // more dummy questions...
    ];
  }

  void nextQuestion() {
    if (currentIndex.value < questions.length - 1) {
      currentIndex.value++;
      selectedAnswer.value = null; // reset for new question
    }
  }

  void previousQuestion() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      selectedAnswer.value = null;
    }
  }

  bool get isLastQuestion => currentIndex.value == questions.length - 1;

  void submitSurvey() {
    // TODO: Call API to submit answers
    Get.snackbar("Submitted", "Your responses have been submitted successfully.");
    Get.to(UserPollScreen());
  }
}
