import 'package:get/get.dart';
import 'dart:async';

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
  
  // Task history
  final RxList<Map<String, dynamic>> taskHistory = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadTaskHistory();
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