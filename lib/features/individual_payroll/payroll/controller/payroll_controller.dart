import 'package:get/get.dart';

class IndividualPayrollController extends GetxController {
  // Observable variables for current status
  RxString clockInTime = "07:00 AM".obs;
  RxString clockOutTime = "04:00 PM".obs;
  RxString hoursToday = "0:36 / 8:00".obs;
  RxString currentDate = "Wednesday, June 25, 2024".obs;

  // Observable variables for work time inputs
  RxDouble regularHours = 183.75.obs;
  RxDouble overtimeHours = 11.0.obs;
  RxDouble paidTimeOffHours = 8.0.obs;

  // Computed total paid hours
  double get totalPaidHours =>
      regularHours.value + overtimeHours.value + paidTimeOffHours.value;

  // Observable variables for time period selection
  RxString selectedTimePeriod = "19/06/2025".obs;
  RxString weeklyPeriod = "Jun 23-Jun 29".obs;

  // Sample data for requests (will be replaced with API calls)
  RxList<PayrollRequest> myRequests = <PayrollRequest>[
    PayrollRequest(
      id: "1",
      dateRange: "Jul 15 - Jul 19, 2024 (5 days)",
      description: "Annual vacation",
      status: PayrollRequestStatus.pending,
      type: PayrollRequestType.timeOff,
    ),
    PayrollRequest(
      id: "2",
      dateRange: "Jun 22, 2024",
      description: "Forgot to clock out - actual end time was 5:30 PM",
      status: PayrollRequestStatus.approved,
      type: PayrollRequestType.clockCorrection,
    ),
  ].obs;

  // Sample data for recent activity
  RxList<RecentActivity> recentActivities = <RecentActivity>[
    RecentActivity(
      id: "1",
      title: "Clocked in",
      description: "our work has started",
      type: ActivityType.clockIn,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    RecentActivity(
      id: "2",
      title: "Timesheet approved",
      description: "Your timesheet for June 24 has been approved",
      type: ActivityType.timesheetApproved,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
    RecentActivity(
      id: "3",
      title: "Clocked out",
      description: "Your work has ended",
      type: ActivityType.clockOut,
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 8)),
    ),
    RecentActivity(
      id: "4",
      title: "Clocked in",
      description: "Your work has ended",
      type: ActivityType.clockIn,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ].obs;

  // Sample data for weekly schedule (horizontally scrollable)
  RxList<WeeklyScheduleItem> weeklySchedule = <WeeklyScheduleItem>[
    WeeklyScheduleItem(
      date: "Sun 29/6",
      projectName: "Select",
      startTime: "8:00 AM",
      endTime: "6:00 AM",
      totalHours: "10 Hours",
      dailyTotal: "9 Hours",
    ),
    WeeklyScheduleItem(
      date: "Sat 28/6",
      projectName: "Select",
      startTime: "8:00 AM",
      endTime: "6:00 AM",
      totalHours: "10 Hours",
      dailyTotal: "9 Hours",
    ),
    WeeklyScheduleItem(
      date: "Fri 27/6",
      projectName: "Select",
      startTime: "8:00 AM",
      endTime: "6:00 AM",
      totalHours: "10 Hours",
      dailyTotal: "9 Hours",
    ),
    WeeklyScheduleItem(
      date: "Thu 26/6",
      projectName: "Select",
      startTime: "8:00 AM",
      endTime: "6:00 AM",
      totalHours: "10 Hours",
      dailyTotal: "9 Hours",
    ),
    WeeklyScheduleItem(
      date: "Wed 25/6",
      projectName: "Select",
      startTime: "8:00 AM",
      endTime: "6:00 AM",
      totalHours: "10 Hours",
      dailyTotal: "9 Hours",
    ),
    WeeklyScheduleItem(
      date: "Tue 24/6",
      projectName: "Select",
      startTime: "8:00 AM",
      endTime: "6:00 AM",
      totalHours: "10 Hours",
      dailyTotal: "9 Hours",
    ),
    WeeklyScheduleItem(
      date: "Mon 23/6",
      projectName: "Select",
      startTime: "8:00 AM",
      endTime: "6:00 AM",
      totalHours: "10 Hours",
      dailyTotal: "9 Hours",
    ),
  ].obs;

  // Loading states
  RxBool isLoading = false.obs;
  RxBool isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  void _initializeData() {
    // Initialize with current date and time
    _updateCurrentDateTime();
  }

  void _updateCurrentDateTime() {
    final now = DateTime.now();
    final weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    currentDate.value =
        "${weekdays[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}, ${now.year}";
  }

  // Methods for handling user actions
  void incrementRegularHours() {
    regularHours.value += 0.25; // Add 15 minutes
    update();
  }

  void decrementRegularHours() {
    if (regularHours.value > 0) {
      regularHours.value -= 0.25; // Subtract 15 minutes
      update();
    }
  }

  void incrementOvertimeHours() {
    overtimeHours.value += 0.25;
    update();
  }

  void decrementOvertimeHours() {
    if (overtimeHours.value > 0) {
      overtimeHours.value -= 0.25;
      update();
    }
  }

  void incrementPaidTimeOff() {
    paidTimeOffHours.value += 0.25;
    update();
  }

  void decrementPaidTimeOff() {
    if (paidTimeOffHours.value > 0) {
      paidTimeOffHours.value -= 0.25;
      update();
    }
  }

  void selectTimePeriod() {
    Get.snackbar(
      "Info",
      "Time period selection will be implemented with date picker",
    );
  }

  void exportPayroll() {
    Get.snackbar("Info", "Export functionality will be implemented");
  }

  void addPayrollEntry() {
    Get.snackbar("Info", "Add payroll entry functionality will be implemented");
  }

  Future<void> submitPayroll() async {
    isSubmitting.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      Get.snackbar("Success", "Payroll submitted successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to submit payroll: $e");
    } finally {
      isSubmitting.value = false;
    }
  }

  void cancelRequest(String requestId) {
    myRequests.removeWhere((request) => request.id == requestId);
    Get.snackbar("Success", "Request cancelled successfully");
  }

  void selectProject(String date) {
    Get.snackbar("Info", "Project selection for $date will be implemented");
  }

  void viewNotes(String date) {
    Get.snackbar("Info", "View notes for $date will be implemented");
  }

  void chatWithAdmin() {
    Get.snackbar("Info", "Chat with admin functionality will be implemented");
  }
}

// Data models for the payroll screen
class PayrollRequest {
  final String id;
  final String dateRange;
  final String description;
  final PayrollRequestStatus status;
  final PayrollRequestType type;

  PayrollRequest({
    required this.id,
    required this.dateRange,
    required this.description,
    required this.status,
    required this.type,
  });
}

enum PayrollRequestStatus { pending, approved, rejected }

enum PayrollRequestType { timeOff, clockCorrection, overtime }

class RecentActivity {
  final String id;
  final String title;
  final String description;
  final ActivityType type;
  final DateTime timestamp;

  RecentActivity({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.timestamp,
  });
}

enum ActivityType { clockIn, clockOut, timesheetApproved, requestSubmitted }

class WeeklyScheduleItem {
  final String date;
  final String projectName;
  final String startTime;
  final String endTime;
  final String totalHours;
  final String dailyTotal;

  WeeklyScheduleItem({
    required this.date,
    required this.projectName,
    required this.startTime,
    required this.endTime,
    required this.totalHours,
    required this.dailyTotal,
  });
}
