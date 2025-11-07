import 'package:get/get.dart';

class PollListTemplateController extends GetxController {
  var pollType = "Poll".obs;
  final pollTypes = ["Poll", "Survey"];

  // Fake search text
  var searchQuery = "".obs;

  // Dummy poll data (later will come from API)
  final pollTemplates = {
    "All": [
      "Employee satisfactory survey",
      "Team performance",
      "Training and Development",
    ],
    "HR Management": [
      "Team Performance",
      "Job Satisfaction",
    ],
    "Project Management": [
      "Project Progress",
      "Resource Management",
    ],
    "Safety and Compliance": [
      "Safety Protocols & site Inspections",
      "Health and Well-being",
    ]
  }.obs;

  void setPollType(String? type) {
    if (type != null) pollType.value = type;
  }

}
