import 'package:get/get.dart';

class SurveyAndPollScreenController extends GetxController {
  var surveys = <Survey>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSurveys();
  }

  void loadSurveys() {
    surveys.value = [
      Survey(title: "Survey A", status: "Active"),
      Survey(title: "Survey B", status: "Completed"),
      Survey(title: "Survey C", status: "Active"),
      Survey(title: "Survey D", status: "Completed"),
      Survey(title: "Survey D", status: "Completed"),
      Survey(title: "Survey D", status: "Completed"),
      Survey(title: "Survey D", status: "Completed"),
    ];
  }
}

class Survey {
  final String title;
  final String status;

  Survey({required this.title, required this.status});
}
