import 'package:get/get.dart';

class AdminTimeClockAddTimeOffScreenController extends GetxController {
  RxString selectedProject = 'Jane Cooper'.obs;
  

  final List<String> projectList = [
    'Jane Cooper',
    'Robert Fox',
    'Esther Howard',
    'Desirae Botosh',
    'Marley Stanton',
    'Kaylynn Stanton',
    'Brandon Vaccaro',
  ];

  void selectProject(String projectName) {
    selectedProject.value = projectName;
  }

  // this is for take the time of type 
  RxString selectedTimeOfType = 'Sick Leave'.obs;
  final List<String> timeOfTime = [
    'Sick Leave',
    'Casual Leave',
    'Unpaid Leave',
  ];
  void timeOffTime(String timeOffTimeName) {
    selectedTimeOfType.value = timeOffTimeName;
  }

  //this is for the all day time off button
  RxBool isSwitchOn = false.obs;

}
