import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDashboardController extends GetxController {
  final RxString alertMessage =
      "Urgent Shift change for tomorrow, your shift starts at 8:00 AM instead of 9:00 AM"
          .obs;
  final RxBool showAlert = true.obs;

  final RxString shiftTime = "09:00 AM - 05:00 PM".obs;
  final RxString shiftDate = "Friday, June 20".obs;
  final RxString shiftLocation = "Downtown Flagship Store".obs;

  final RxList<Map<String, String>> teamMembers = <Map<String, String>>[
    {'initial': 'L', 'name': 'Lisa'},
    {'initial': 'M', 'name': 'Mike'},
    {'initial': 'C', 'name': 'Chris'},
  ].obs;

  final RxList<Map<String, dynamic>> upcomingTasks = <Map<String, dynamic>>[
    {'title': 'Complete Q2 Sales Report', 'dueDate': 'Today', 'isToday': true},
    {
      'title': 'Review Team Performancesdfsdfsdfsdfsf',
      'dueDate': 'Tomorrow',
      'isToday': false,
    },
    {
      'title': 'Prepare Monthly Budget',
      'dueDate': 'Tomorrow',
      'isToday': false,
    },
    {
      'title': 'Client Meeting Preparation',
      'dueDate': 'Today',
      'isToday': true,
    },
    {
      'title': 'Update Inventory System',
      'dueDate': 'Tomorrow',
      'isToday': false,
    },
  ].obs;

  void dismissAlert() {
    showAlert.value = false;
  }

  final RxList<Map<String, String>> companyUpdates = <Map<String, String>>[
    {
      'department': 'HR',
      'departmentName': 'HR Department',
      'message':
          'Annual Performance reviews are starting. Please schedule a meeting with your manager',
      'timeAgo': '2 days ago',
    },
    {
      'department': 'IT',
      'departmentName': 'IT Department',
      'message':
          'System maintenance scheduled for this weekend. Please save your work regularly',
      'timeAgo': '1 day ago',
    },
    {
      'department': 'FIN',
      'departmentName': 'Finance Department',
      'message':
          'Monthly expense reports are due by end of this week. Submit through the portal',
      'timeAgo': '3 hours ago',
    },
    {
      'department': 'MKT',
      'departmentName': 'Marketing Department',
      'message':
          'New brand guidelines have been released. Check your email for detailed documentation',
      'timeAgo': '5 days ago',
    },
    {
      'department': 'OPS',
      'departmentName': 'Operations Department',
      'message':
          'Office timings will be extended during peak season. New schedule effective next Monday',
      'timeAgo': '1 week ago',
    },
  ].obs;
  final RxList<Map<String, dynamic>> recognitionEngagement =
      <Map<String, dynamic>>[
        {
          'title': 'Employee of the Month: John Doe',
          'description': 'Recognized for outstanding performance',
          'icon': 'assets/icons/crown.png',
        },
        {
          'title': 'Team Achievement: Project Alpha Completed',
          'description': 'Celebrating successful project delivery',
          'icon': 'assets/icons/crown.png',
        },
        {
          'title': 'Innovation Award: Sarah Johnson',
          'description': 'Awarded for creative problem-solving approach',
          'icon': 'assets/icons/crown.png',
        },
        {
          'title': 'Customer Service Excellence: Mike Chen',
          'description': 'Outstanding customer satisfaction ratings',
          'icon': 'assets/icons/crown.png',
        },
        {
          'title': 'Team Collaboration: Marketing Team',
          'description': 'Exceptional cross-department cooperation',
          'icon': 'assets/icons/crown.png',
        },
      ].obs;
}
