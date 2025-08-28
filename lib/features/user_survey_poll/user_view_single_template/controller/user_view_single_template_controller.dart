import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/features/user_survey_poll/user_survey/screen/user_survey_screen.dart';

class UserViewSingleTemplateController extends GetxController {
  final questions = <Map<String, dynamic>>[].obs;
  final currentIndex = 0.obs;

  // selected option index (UI highlight)
  final selectedAnswer = Rxn<int>();

  // user answers -> {questionId: answer}
  // answer can be String (OPEN_ENDED), Map (SELECT), int (RANGE)
  final answers = <String, dynamic>{}.obs;

  // survey info
  final surveyTitle = ''.obs;
  final surveyDescription = ''.obs;
  final surveyStatus = ''.obs;

  final String token = StorageService.token ?? '';

  late String surveyId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args["id"] != null) {
      surveyId = args["id"];
      fetchSurveyDetail(surveyId);
    }
  }

  /// Fetch survey details
  Future<void> fetchSurveyDetail(String surveyId) async {
    try {
      final url =
          "https://lgcglobalcontractingltd.com/js/employee/survey/$surveyId/assigned";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data["success"] == true && data["data"] != null) {
          final survey = data["data"];

          surveyTitle.value = survey["title"] ?? "";
          surveyDescription.value = survey["description"] ?? "";
          surveyStatus.value = survey["status"] ?? "";

          final List<dynamic> qList = survey["questions"] ?? [];
          questions.value = qList.map((q) {
            return {
              "id": q["id"],
              "question": q["question"],
              "description": q["description"],
              "type": q["type"], // SELECT / OPEN_ENDED / RANGE
              "options": (q["options"] as List).map((opt) {
                return {
                  "id": opt["id"], // optionId
                  "text": opt["text"],
                };
              }).toList(),
              "rangeStart": q["rangeStart"],
              "rangeEnd": q["rangeEnd"],
            };
          }).toList();
        }
      } else {
        Get.snackbar("Error", "Failed to load survey details");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  void saveAnswer(String questionId, dynamic answer) {
    answers[questionId] = answer;
  }

  void nextQuestion() {
    if (currentIndex.value < questions.length - 1) {
      currentIndex.value++;
      selectedAnswer.value = null;
    }
  }

  void previousQuestion() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      selectedAnswer.value = null;
    }
  }

  bool get isLastQuestion => currentIndex.value == questions.length - 1;

  /// Submit answers
  Future<void> submitSurvey() async {
    try {
      if (surveyId.isEmpty) {
        Get.snackbar("Error", "Survey ID missing");
        return;
      }

      final List<Map<String, dynamic>> formattedAnswers = [];
      answers.forEach((questionId, answer) {
        formattedAnswers.add({
          "questionId": questionId,
          "answerText": answer is String ? answer : null,
          "options": answer is Map<String, dynamic>
              ? [
                  {"optionId": answer["id"]},
                ]
              : [],
          "rate": answer is int ? answer : null,
        });
      });

      final url =
          "https://lgcglobalcontractingltd.com/js/employee/survey/$surveyId/response";

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({"answers": formattedAnswers}),
      );

      print(response.body);

      final data = json.decode(response.body);

      if (response.statusCode == 201 && data["success"] == true) {
        Get.snackbar("Success", "Survey submitted successfully");
        Get.offAll(() => const UserSurveyScreen());
      } else {
        Get.snackbar("Error", data["message"] ?? "Submission failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }
}
