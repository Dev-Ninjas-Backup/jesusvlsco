// controllers/schedule_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleController extends GetxController {
  // Dropdown values
  var dropdownValue = "Everyone".obs;
  final dropdownItems = ["Everyone", "Only Me"];

  // Date selection
  var selectedDate = DateTime.now().obs;

  // Time selection
  var startTime = TimeOfDay(hour: 9, minute: 0).obs;
  var endTime = TimeOfDay(hour: 17, minute: 0).obs;

  // Notes
  TextEditingController notesController = TextEditingController();

  // Toggle
  var unavailableAllDay = false.obs;

  // Mock employee data
  var employees = [
    {
      "name": "Sarah Johnson",
      "role": "Manager",
      "offDay": "Friday",
      "image": "https://randomuser.me/api/portraits/women/44.jpg",
    },
    {
      "name": "Emma Willson",
      "role": "Manager",
      "offDay": "Friday",
      "image": "https://randomuser.me/api/portraits/women/45.jpg",
    },
  ];
}
