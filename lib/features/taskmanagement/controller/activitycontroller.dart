import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Activitycontroller  extends GetxController{



// Your dummy data list
final List<Activity> dummyActivities = [
  Activity(
    time: '12:37 am',
    avatarUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHBvcnRyYWl0fGVufDB8fDB8fHww',
    activityText: 'Jane Cooper has completed a task',
  ),
  Activity(
    time: '12:32 am',
    avatarUrl:
        'https://images.unsplash.com/photo-1564564321837-a93175c2e176?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D',
    activityText: 'Robert Fox has viewed the task',
  ),
  Activity(
    time: '11:38 am',
    avatarUrl:
        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D',
    activityText: 'Admin edited a task',
  ),
  Activity(
    time: '12:30 am',
    avatarUrl:
        'https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHBvcnRyYWl0fGVufDB8fDB8fHww',
    activityText: 'Admin created a task',
  ),
  Activity(
    time: '12:00 am',
    avatarUrl:
        'https://images.unsplash.com/photo-1522075469751-3a669400075f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fHBvcnRyYWl0fGVufDB8fDB8fHww',
    activityText: 'Admin completed a task',
  ),
];
}
class Activity {
  final String time;
  final String avatarUrl;
  final String activityText;

  Activity({
    required this.time,
    required this.avatarUrl,
    required this.activityText,
  });
}