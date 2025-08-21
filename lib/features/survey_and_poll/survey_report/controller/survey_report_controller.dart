import 'package:get/get.dart';
import '../model/survey_report_model.dart';

class SurveyReportController extends GetxController {
  var reports = <SurveyReportModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadReports();
  }

  void loadReports() {
    reports.value = [
      SurveyReportModel(
        date: "8/2/19",
        name: "Arlene McCoy",
        jobSatisfaction: "Satisfied",
        managerSupport: "Satisfied",
        workLifeBalance: "Satisfied",
        leaderRating: 5,
      ),
      SurveyReportModel(
        date: "5/27/15",
        name: "Savannah Nguyen",
        jobSatisfaction: "Satisfied",
        managerSupport: "Satisfied",
        workLifeBalance: "Satisfied",
        leaderRating: 4,
      ),
      SurveyReportModel(
        date: "11/7/16",
        name: "Darrell Steward",
        jobSatisfaction: "Dissatisfied",
        managerSupport: "Dissatisfied",
        workLifeBalance: "Dissatisfied",
        leaderRating: 3,
      ),
      SurveyReportModel(
        date: "4/21/12",
        name: "Jacob Jones",
        jobSatisfaction: "Neutral",
        managerSupport: "Neutral",
        workLifeBalance: "Dissatisfied",
        leaderRating: 2,
      ),
      SurveyReportModel(
        date: "9/4/12",
        name: "Kathryn Murphy",
        jobSatisfaction: "Satisfied",
        managerSupport: "Satisfied",
        workLifeBalance: "Satisfied",
        leaderRating: 5,
      ),
      SurveyReportModel(
        date: "8/15/17",
        name: "Albert Flores",
        jobSatisfaction: "Satisfied",
        managerSupport: "Satisfied",
        workLifeBalance: "Satisfied",
        leaderRating: 5,
      ),
    ];
  }
}
