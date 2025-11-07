import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:jesusvlsco/model/taskresponse_model.dart';



// ignore: camel_case_types
class User_Taskcontroller extends GetxController {
  
  // Timer related
  Timer? _timer;
  final RxString elapsedTime = '00:00:00'.obs;
  final RxBool isRunning = false.obs;
  final Rx<Duration> elapsed = Duration.zero.obs;
  
  // Task related
  final RxBool showAllTasks = false.obs;
  final RxString projectTitle = 'Website Redesign Project'.obs;
  final RxString description = 'Redesign the company website with a modern look and feel. Focus on improving user experience and mobile responsiveness.'.obs;
  final RxString assignedTo = 'Afiq Nishat Kanta'.obs;
  final RxString startTime = '3/06/25 at 05:00'.obs;
  final RxString endTime = '27/06/25 at 05:00'.obs;
  static const String _baseUrl = 'https://lgcglobalcontractingltd.com';
  static const String _token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImppaGFkbXVnZGhvNzM1QGdtYWlsLmNvbSIsInJvbGVzIjoiRU1QTE9ZRUUiLCJzdWIiOiJhN2Y3MjM0OC0zYTUyLTQ0MjYtOGI5Mi02NTZjMDE4NTNhMTMiLCJpYXQiOjE3NTYxOTUyMzksImV4cCI6MTc2Mzk3MTIzOX0.GYqCH2fl3JI5EPEh-Yxocb1bkWyyaSWpwklNfVX8TGo';

  Future<List<Task>> fetchTasks() async {
    final uri = Uri.parse('$_baseUrl/js/employee/project/task/all?page=1&limit=10');
    final headers = {
      'Authorization': 'Bearer $_token',
      'Accept': 'application/json',
    };

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final TaskResponse taskResponse = TaskResponse.fromJson(jsonResponse);
        if (kDebugMode) {
          print('Fetched ${taskResponse.data} tasks');
        }
        return taskResponse.data.tasks;
      } else {
        throw Exception('Failed to load tasks: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load tasks: $e');
    }
  }
  
  // Task history
  final RxList<Map<String, dynamic>> taskHistory = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadTaskHistory();
    fetchTasks();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startStopTimer() {
    if (isRunning.value) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    isRunning.value = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      elapsed.value += Duration(seconds: 1);
      elapsedTime.value = _formatDuration(elapsed.value);
    });
  }

  void _stopTimer() {
    isRunning.value = false;
    _timer?.cancel();
    
    // Add to history when stopped
    if (elapsed.value.inSeconds > 0) {
      _addToHistory();
    }
  }

  void resetTimer() {
    _timer?.cancel();
    isRunning.value = false;
    elapsed.value = Duration.zero;
    elapsedTime.value = '00:00:00';
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void toggleTaskView() {
    showAllTasks.value = !showAllTasks.value;
  }

  void setTaskView(bool isAllTasks) {
    showAllTasks.value = isAllTasks;
  }

  void addAttachment() {
    Get.snackbar(
      'Attachment',
      'File picker would open here',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void submitTask() {
    if (elapsed.value.inSeconds > 0) {
      _addToHistory();
      resetTimer();
      Get.snackbar(
        'Success',
        'Task submitted successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor,
        colorText: Get.theme.colorScheme.onPrimary,
      );
    } else {
      Get.snackbar(
        'Error',
        'Please start the timer before submitting',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _addToHistory() {
    taskHistory.add({
      'title': projectTitle.value,
      'duration': _formatDuration(elapsed.value),
      'date': DateTime.now().toString().split(' ')[0],
      'time': DateTime.now().toString().split(' ')[1].substring(0, 5),
      'status': 'Completed',
    });
  }

  void _loadTaskHistory() {
    // Mock data for demonstration
    taskHistory.addAll([
      {
        'title': 'Mobile App Design',
        'duration': '02:30:15',
        'date': '2025-08-20',
        'time': '14:30',
        'status': 'Completed',
      },
      {
        'title': 'Database Optimization',
        'duration': '01:45:22',
        'date': '2025-08-19',
        'time': '10:15',
        'status': 'Completed',
      },
    ]);
  }

  void goToHistory() {
    Get.toNamed('/task-history');
  }

  void goToTask() {
    Get.toNamed('/task');
  }
}