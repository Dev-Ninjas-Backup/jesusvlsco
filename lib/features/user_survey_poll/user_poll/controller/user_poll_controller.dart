import 'package:get/get.dart';

class UserPollController extends GetxController {
  final pollQuestion = {
    "title": "Employee Satisfaction Poll",
    "owner": "Admin",
    "duration": "May 1 - May 15, 2025",
    "status": "Active",
    "question": "How satisfied are you with your current role in the project?",
    "options": [
      "Very Satisfied",
      "Satisfied",
      "Neutral",
      "Unsatisfied",
      "Very Unsatisfied",
    ]
  }.obs;

  final selectedAnswer = Rxn<int>();

  void submitPoll() {
    if (selectedAnswer.value == null) {
      Get.snackbar("Error", "Please select an option");
      return;
    }
    Get.snackbar("Thank you", "Your poll response has been submitted!");
    // TODO: Call API to submit poll response
  }
}
