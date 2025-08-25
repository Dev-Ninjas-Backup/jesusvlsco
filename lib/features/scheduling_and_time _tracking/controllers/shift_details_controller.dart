import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/constants/sizer.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/common/styles/global_text_style.dart';
import '../models/task_model.dart';
import '../models/activity_model.dart';
import '../screens/widgets/shift_emplate_widgets/add_user_dialog.dart';
import '../screens/views/shift_template_screen.dart';
import '../../../core/common/widgets/custom_date_picker_widget.dart';

/// Controller for Shift Details Screen
/// Manages form data, tasks, activities, and business logic for shift management
class ShiftDetailsController extends GetxController {
  final Logger _logger = Logger();

  // Form controllers
  final shiftTitleController = TextEditingController();
  final jobController = TextEditingController();
  final usersController = TextEditingController();
  final locationController = TextEditingController();
  final noteController = TextEditingController();

  // Observable variables for date and time
  var selectedDate = DateTime.now().obs;
  var selectedDateFormatted = ''.obs;
  var isAllDay = true.obs;
  var startTime = '9:00 am'.obs;
  var endTime = '5:00 pm'.obs;
  var duration = '08:00 Hours'.obs;

  // Tasks and activities lists
  var tasks = <TaskModel>[].obs;
  var activities = <ActivityModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockData();
    _logger.i('ShiftDetailsController initialized');

    // Initialize formatted date
    selectedDateFormatted.value = DateFormat(
      'dd/MM/yyyy',
    ).format(selectedDate.value);
  }

  /// Load mock data for tasks and activities
  void _loadMockData() {
    _logger.i('Loading mock data for shift details');

    tasks.value = [
      const TaskModel(
        id: '1',
        title: 'Metro Shopping Center',
        isCompleted: true,
      ),
      const TaskModel(
        id: '2',
        title: 'City Bridge Renovations',
        isCompleted: false,
      ),
      const TaskModel(
        id: '3',
        title: 'Golden Hills Estates',
        isCompleted: false,
      ),
      const TaskModel(
        id: '4',
        title: 'Riverside Apartments',
        isCompleted: true,
      ),
      const TaskModel(id: '5', title: 'The Commerce Hub', isCompleted: false),
    ];

    activities.value = [
      ActivityModel(
        id: '1',
        userName: 'Emma Willson',
        userAvatar: 'https://i.pravatar.cc/150?img=1',
        action: 'Shift published by',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      ActivityModel(
        id: '2',
        userName: 'Emma Willson',
        userAvatar: 'https://i.pravatar.cc/150?img=2',
        action: 'has completed the task',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
      ActivityModel(
        id: '3',
        userName: 'Emma Willson',
        userAvatar: 'https://i.pravatar.cc/150?img=3',
        action: 'has completed the task',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
      ),
      ActivityModel(
        id: '4',
        userName: 'Emma Willson',
        userAvatar: 'https://i.pravatar.cc/150?img=4',
        action: 'has completed the task',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
      ),
      ActivityModel(
        id: '5',
        userName: 'Marley Stanton',
        userAvatar: 'https://i.pravatar.cc/150?img=5',
        action: 'Shift created by',
        timestamp: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];
  }

  /// Select date using date picker
  Future<void> selectDate() async {
    try {
      _logger.i('Opening date picker');

      final DateTime? picked = await CustomDatePicker.show(
        context: Get.context!,
        initialDate: selectedDate.value,
      );

      if (picked != null) {
        selectedDate.value = picked;
        selectedDateFormatted.value = DateFormat('dd/MM/yyyy').format(picked);
        _logger.i('Date selected: ${selectedDateFormatted.value}');
        EasyLoading.showSuccess(
          'Date selected: ${DateFormat('MMM dd, yyyy').format(picked)}',
        );
      }
    } catch (error) {
      _logger.e('Error showing date picker: $error');
      EasyLoading.showError('Failed to show date picker');
    }
  }

  /// Select start time using time picker
  void selectStartTime() async {
    _logger.i('Opening start time picker');

    final TimeOfDay? picked = await Get.dialog<TimeOfDay>(
      _buildTimePicker(startTime.value),
    );

    if (picked != null) {
      startTime.value = _formatTimeOfDay(picked);
      _calculateDuration();
      _logger.i('Start time selected: ${startTime.value}');
    }
  }

  /// Select end time using time picker
  void selectEndTime() async {
    _logger.i('Opening end time picker');

    final TimeOfDay? picked = await Get.dialog<TimeOfDay>(
      _buildTimePicker(endTime.value),
    );

    if (picked != null) {
      endTime.value = _formatTimeOfDay(picked);
      _calculateDuration();
      _logger.i('End time selected: ${endTime.value}');
    }
  }

  /// Toggle all day option
  void toggleAllDay() {
    isAllDay.value = !isAllDay.value;
    _logger.i('All day toggled: ${isAllDay.value}');
  }

  /// Toggle task completion status
  void toggleTask(String taskId) {
    _logger.i('Toggling task completion for task ID: $taskId');

    final taskIndex = tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      final updatedTask = tasks[taskIndex].copyWith(
        isCompleted: !tasks[taskIndex].isCompleted,
      );
      tasks[taskIndex] = updatedTask;
      tasks.refresh();

      _logger.i(
        'Task ${updatedTask.title} completion status: ${updatedTask.isCompleted}',
      );
    }
  }

  /// Add new task to the list
  void addTask() {
    _logger.i('Opening add task dialog');
    Get.dialog(_buildAddTaskDialog());
  }

  /// Add new user to the shift
  Future<void> addUser() async {
    try {
      _logger.i('Opening add user dialog');

      // Show the add user dialog
      final selectedUsers = await showDialog<List<UserModel>>(
        context: Get.context!,
        builder: (context) => const AddUserDialog(),
      );

      if (selectedUsers != null && selectedUsers.isNotEmpty) {
        _logger.i('Users selected: ${selectedUsers.length}');

        // Add activity for each selected user
        for (final user in selectedUsers) {
          activities.add(
            ActivityModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              userName: user.name,
              userAvatar: user.avatar,
              action: 'Added to shift',
              timestamp: DateTime.now(),
            ),
          );
        }

        EasyLoading.showSuccess(
          '${selectedUsers.length} user(s) added to shift',
        );
        update();
      } else {
        _logger.i('No users selected');
      }
    } catch (error) {
      _logger.e('Error adding user: $error');
      EasyLoading.showError('Failed to add user');
    }
  }

  /// Save shift as template
  void saveAsTemplate() {
    _logger.i('Navigating to save as template screen');
    Get.to(() => const ShiftTemplateScreen());
  }

  /// Save shift as draft
  void saveDraft() {
    _logger.i('Saving shift as draft');
    EasyLoading.showSuccess('Shift saved as draft successfully');
  }

  /// Publish the shift
  void publish() {
    _logger.i('Publishing shift');

    // Validate form data
    if (shiftTitleController.text.isEmpty) {
      EasyLoading.showError('Please enter shift title');
      return;
    }

    if (jobController.text.isEmpty) {
      EasyLoading.showError('Please enter job');
      return;
    }

    EasyLoading.showSuccess('Shift published successfully');
  }

  /// Navigate back to previous screen
  void goBack() {
    _logger.i('Navigating back');
    Get.back();
  }

  /// Format TimeOfDay to string
  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'am' : 'pm';
    return '$hour:$minute $period';
  }

  /// Calculate duration between start and end time
  void _calculateDuration() {
    // Simple duration calculation for demo
    // In real implementation, calculate actual duration
    duration.value = '08:00 Hours';
    _logger.i('Duration calculated: ${duration.value}');
  }

  /// Build custom time picker dialog
  Widget _buildTimePicker(String currentTime) {
    return Dialog(
      child: Container(
        margin: EdgeInsets.only(top: Sizer.hp(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Time',
              style: AppTextStyle.f18W600().copyWith(color: AppColors.primary),
            ),
            SizedBox(height: Sizer.hp(20)),
            TimePickerDialog(initialTime: TimeOfDay.now()),
          ],
        ),
      ),
    );
  }

  /// Build add task dialog
  Widget _buildAddTaskDialog() {
    final taskController = TextEditingController();

    return Dialog(
      child: Container(
        padding: EdgeInsets.all(Sizer.wp(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add New Task',
              style: AppTextStyle.f18W600().copyWith(color: AppColors.primary),
            ),
            SizedBox(height: Sizer.hp(20)),
            TextField(
              controller: taskController,
              decoration: const InputDecoration(
                hintText: 'Enter task title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: Sizer.hp(20)),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Cancel'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (taskController.text.isNotEmpty) {
                        final newTask = TaskModel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          title: taskController.text,
                          isCompleted: false,
                        );
                        tasks.add(newTask);
                        _logger.i('New task added: ${newTask.title}');
                        Get.back();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onClose() {
    _logger.i('ShiftDetailsController disposing');
    shiftTitleController.dispose();
    jobController.dispose();
    usersController.dispose();
    locationController.dispose();
    noteController.dispose();
    super.onClose();
  }
}
