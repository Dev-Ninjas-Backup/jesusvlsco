import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Overduecontroller extends GetxController {
  
  List<OverduetaskModel> dummyData = [
    OverduetaskModel(
      title: 'Create a new Flutter project',
      subtitle: 'Due Jun 22 at 11:00 AM',
      label: 'Today',
      comment: 5,
    ),
    OverduetaskModel(
      title: 'Create a new Flutter project',
      subtitle: 'Due Jun 22 at 11:00 AM',
      label: 'Today',
      comment: 5,
    ),
    OverduetaskModel(
      title: 'Create a new Flutter project',
      subtitle: 'Due Jun 22 at 11:00 AM',
      label: 'Today',
      comment: 5,
    ),
  ];
}

class OverduetaskModel {
  final String title;
  final dynamic subtitle;
  final String label;
  final String name;
  double comment;

  OverduetaskModel({
    required this.label,
    required this.title,
    required this.subtitle,
    this.comment = 0,
    this.name = 'UNKNOWN',
  });
}
