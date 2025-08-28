import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/features/user_survey_poll/user_survey/screen/user_survey_screen.dart';

class UserViewSingleTemplateController extends GetxController {
  /// Observables
  final questions = <Map<String, dynamic>>[].obs;
  final currentIndex = 0.obs;
  final selectedAnswer = Rxn<int>(); // UI highlight index
  final answers = <String, dynamic>{}.obs; // {questionId: answer}

  final surveyTitle = ''.obs;
  final surveyDescription = ''.obs;
  final surveyStatus = ''.obs;

  final String token = StorageService.token ?? '';
  late final String surveyId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    surveyId = args?["id"] ?? "";
    if (surveyId.isNotEmpty) fetchSurveyDetail(surveyId);
  }

  /// Fetch survey details
  Future<void> fetchSurveyDetail(String surveyId) async {
    final url =
        "https://lgcglobalcontractingltd.com/js/employee/survey/$surveyId/assigned";

    try {
      final response = await http.get(Uri.parse(url), headers: _headers);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body["success"] == true && body["data"] != null) {
          final survey = body["data"];

          surveyTitle.value = survey["title"] ?? "";
          surveyDescription.value = survey["description"] ?? "";
          surveyStatus.value = survey["status"] ?? "";

          final qList = survey["questions"] as List? ?? [];
          questions.assignAll(qList.map(_mapQuestion).toList());
        } else {
          Get.snackbar("Error", body["message"] ?? "No data found");
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to load survey details (${response.statusCode})",
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  /// Map API question -> usable Map
  Map<String, dynamic> _mapQuestion(dynamic q) {
    return {
      "id": q["id"],
      "question": q["question"],
      "description": q["description"],
      "type": q["type"], // SELECT / OPEN_ENDED / RANGE
      "options": (q["options"] as List? ?? []).map((opt) {
        return {"id": opt["id"], "text": opt["text"]};
      }).toList(),
      "rangeStart": q["rangeStart"],
      "rangeEnd": q["rangeEnd"],
    };
  }

  /// Save user answer
  void saveAnswer(String questionId, dynamic answer) {
    answers[questionId] = answer;
  }

  /// Navigation between questions
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
    if (surveyId.isEmpty) {
      Get.snackbar("Error", "Survey ID missing");
      return;
    }

    final formattedAnswers = answers.entries.map((entry) {
      final qId = entry.key;
      final answer = entry.value;

      return {
        "questionId": qId,
        "answerText": answer is String ? answer : null,
        "options": answer is Map<String, dynamic>
            ? [
                {"optionId": answer["id"]},
              ]
            : [],
        "rate": answer is int ? answer : null,
      };
    }).toList();

    final url =
        "https://lgcglobalcontractingltd.com/js/employee/survey/$surveyId/response";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: _headers,
        body: json.encode({"answers": formattedAnswers}),
      );

      final body = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (body["success"] == true) {
          Get.snackbar("Success", "Survey submitted successfully");
          Get.offAll(() => const UserSurveyScreen());
        } else {
          Get.snackbar("Error", body["message"] ?? "Submission failed");
        }
      } else {
        Get.snackbar("Error", "Failed (${response.statusCode})");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  /// Common headers
  Map<String, String> get _headers => {
    "accept": "*/*",
    "Content-Type": "application/json",
    "Authorization": "Bearer $token",
  };
}
