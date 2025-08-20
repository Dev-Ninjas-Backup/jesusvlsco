import 'package:get/get.dart';

class ViewEyeController extends GetxController {
  // Dummy survey data (You can replace with API later)
  var surveyTitle = "Employee satisfaction Survey".obs;
  var status = "Active".obs;
  var duration = "May 1, 2025 - May 15, 2025".obs;
  var topDepartments = [
    {"name": "Sales", "rate": "40%"},
    {"name": "HR", "rate": "30%"},
    {"name": "IT", "rate": "20%"},
  ].obs;
  var creator = "HR Department".obs;
  var category = "Employee Engagement".obs;
  var timeRemaining = "2 days".obs;
  var description =
      "This survey gathers feedback on employee satisfaction and workplace environment."
          .obs;
}
