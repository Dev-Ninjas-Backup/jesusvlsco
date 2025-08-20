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
      SurveyReportModel(date: "8/2/19", name: "Arlene McCoy", status: "Satisfied"),
      SurveyReportModel(date: "5/22/15", name: "Savannah Nguyen", status: "Satisfied"),
      SurveyReportModel(date: "8/2/15", name: "Theresa Webb", status: "Satisfied"),
      SurveyReportModel(date: "4/21/12", name: "Jacob Jones", status: "Neutral"),
      SurveyReportModel(date: "11/7/16", name: "Darrell Steward", status: "Dissatisfied"),
      SurveyReportModel(date: "5/30/14", name: "Jerome Bell", status: "Dissatisfied"),
      SurveyReportModel(date: "9/4/12", name: "Kathryn Murphy", status: "Satisfied"),
      SurveyReportModel(date: "8/15/17", name: "Albert Flores", status: "Satisfied"),SurveyReportModel(date: "4/21/12", name: "Jacob Jones", status: "Neutral"),
      SurveyReportModel(date: "11/7/16", name: "Darrell Steward", status: "Dissatisfied"),
      SurveyReportModel(date: "5/30/14", name: "Jerome Bell", status: "Dissatisfied"),
      SurveyReportModel(date: "9/4/12", name: "Kathryn Murphy", status: "Satisfied"),
      SurveyReportModel(date: "8/15/17", name: "Albert Flores", status: "Satisfied"),SurveyReportModel(date: "9/4/12", name: "Kathryn Murphy", status: "Satisfied"),
      SurveyReportModel(date: "8/15/17", name: "Albert Flores", status: "Satisfied"),SurveyReportModel(date: "4/21/12", name: "Jacob Jones", status: "Neutral"),
      SurveyReportModel(date: "11/7/16", name: "Darrell Steward", status: "Dissatisfied"),
      SurveyReportModel(date: "5/30/14", name: "Jerome Bell", status: "Dissatisfied"),
      SurveyReportModel(date: "9/4/12", name: "Kathryn Murphy", status: "Satisfied"),
      SurveyReportModel(date: "8/15/17", name: "Albert Flores", status: "Satisfied"),
    ];
  }
}
