// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/models/assign_shift_model.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../../../core/utils/constants/sizer.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/common/styles/global_text_style.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/api_constants.dart';
import '../../../core/models/response_data.dart';
import '../models/task_model.dart';
import '../models/activity_model.dart';
import '../routes/scheduling_routes.dart';
import '../../../core/common/widgets/custom_date_picker_widget.dart';

class ShiftDetailsController extends GetxController {
  final Logger _logger = Logger();
  final NetworkCaller _networkCaller = NetworkCaller();

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
  bool isEditable = Get.arguments != null
      ? (Get.arguments['isEditable'] as bool? ?? false)
      : true;
  final ProjectData? projectData = Get.arguments != null
      ? Get.arguments['projectData'] as ProjectData
      : null;

  // Tasks and activities lists
  var tasks = <TaskModel>[].obs;
  var activities = <ActivityModel>[].obs;

  // Dynamic data
  var selectedProjectId = "".obs;
  var selectedUserIds = <String>[];
  var selectedTaskIds = <String>[].obs;

  // Location lat/lng
  double? latitude;
  double? longitude;

  // Map visibility
  var showMap = false.obs;

  // Search suggestions
  var locationSuggestions = <String>[].obs;
  var isSearching = false.obs;
  Timer? _searchTimer;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      print('userName: ${projectData?.user.firstName}}');
    }
    isEditableMode();

    selectedDateFormatted.value = DateFormat(
      'dd/MM/yyyy',
    ).format(selectedDate.value);
  }

  void isEditableMode() {
    final int? scheduleIndex = Get.arguments != null
        ? Get.arguments['slotIndex'] as int?
        : null;
    final dateFormat = DateFormat('h:mm a');
    if (isEditable) {
      if (projectData != null && scheduleIndex != null) {
        selectedDate.value = projectData!.shifts[scheduleIndex].date;
        isAllDay.value = projectData!.shifts[scheduleIndex].allDay;
        startTime.value = dateFormat.format(
          projectData!.shifts[scheduleIndex].startTime,
        );
        endTime.value = dateFormat.format(
          projectData!.shifts[scheduleIndex].endTime,
        );
        shiftTitleController.text = projectData!.shifts[scheduleIndex].title;
        jobController.text = projectData!.shifts[scheduleIndex].job;
        locationController.text = projectData!.shifts[scheduleIndex].location;
        noteController.text = projectData!.shifts[scheduleIndex].note;
        selectedProjectId.value = projectData!.project.id;
        latitude = projectData!.shifts[scheduleIndex].lat;
        longitude = projectData!.shifts[scheduleIndex].lng;
        selectedUserIds.add(projectData!.user.id);
        pickCurrentLocation();
      } else {
        debugPrint(
          'Invalid project data ${projectData!.project.title} or schedule index $scheduleIndex',
        );
      }
    } else {
      if (projectData?.project.id != null) {
        selectedProjectId.value = projectData!.project.id;
        selectedUserIds.add(projectData!.user.id);
      } else {
        debugPrint('No project ID provided in arguments');
      }
    }
  }

  // ================= DATE & TIME =================
  Future<void> selectDate() async {
    try {
      final DateTime? picked = await CustomDatePicker.show(
        context: Get.context!,
        initialDate: selectedDate.value,
      );

      if (picked != null) {
        selectedDate.value = picked;
        selectedDateFormatted.value = DateFormat('dd/MM/yyyy').format(picked);
      }
    } catch (error) {
      EasyLoading.showError('Failed to show date picker');
    }
  }

  void selectStartTime() async {
    final TimeOfDay? picked = await Get.dialog<TimeOfDay>(
      _buildTimePicker(startTime.value),
    );
    if (picked != null) {
      startTime.value = _formatTimeOfDay(picked);
      _calculateDuration();
    }
  }

  void selectEndTime() async {
    final TimeOfDay? picked = await Get.dialog<TimeOfDay>(
      _buildTimePicker(endTime.value),
    );
    if (picked != null) {
      endTime.value = _formatTimeOfDay(picked);
      _calculateDuration();
    }
  }

  void toggleAllDay() => isAllDay.value = !isAllDay.value;

  // ================= TASK =================
  void toggleTask(String taskId) {
    final taskIndex = tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      final updatedTask = tasks[taskIndex].copyWith(
        isCompleted: !tasks[taskIndex].isCompleted,
      );
      tasks[taskIndex] = updatedTask;
      tasks.refresh();
    }
  }

  void addTask() => Get.dialog(_buildAddTaskDialog());

  // ================= SAVE & PUBLISH =================
  Future<void> publish() async {
    _logger.i('Publishing shift...');

    if (shiftTitleController.text.isEmpty ||
        jobController.text.isEmpty ||
        locationController.text.isEmpty ||
        selectedProjectId.value.isEmpty) {
      EasyLoading.showError('Please fill all required fields');
      return;
    }

    try {
      EasyLoading.show(status: 'Publishing...');
      final String? token = await StorageService.getAuthToken();

      DateTime startDateTime;
      DateTime endDateTime;

      if (!isAllDay.value) {
        startDateTime = _parseTimeStringToDateTime(
          startTime.value,
          selectedDate.value,
        );
        endDateTime = _parseTimeStringToDateTime(
          endTime.value,
          selectedDate.value,
        );

        if (endDateTime.isBefore(startDateTime)) {
          EasyLoading.dismiss();
          EasyLoading.showError("End time must be after start time");
          return;
        }
      } else {
        // Default all-day shift range (08:00–17:00)
        startDateTime = DateTime(
          selectedDate.value.year,
          selectedDate.value.month,
          selectedDate.value.day,
          8,
          0,
        );
        endDateTime = DateTime(
          selectedDate.value.year,
          selectedDate.value.month,
          selectedDate.value.day,
          17,
          0,
        );
      }

      final Map<String, dynamic> requestBody = {
        "currentProjectId": selectedProjectId.value,
        "date": DateFormat("yyyy-MM-dd").format(selectedDate.value),
        "shiftStatus": "PUBLISHED",
        "startTime": startDateTime.toUtc().toIso8601String(),
        "endTime": endDateTime.toUtc().toIso8601String(),
        "shiftTitle": shiftTitleController.text,
        "allDay": isAllDay.value,
        "job": jobController.text,
        "userIds": selectedUserIds.toList(),
        "taskIds": selectedTaskIds.toList(),
        "location": locationController.text,
        "locationLat": latitude ?? 23.8103,
        "locationLng": longitude ?? 90.4125,
        "note": noteController.text,
      };

      final String url = '${ApiConstants.baseurl}${ApiConstants.createShift}';

      final ResponseData response = await _networkCaller.postRequest(
        url,
        body: requestBody,
        token: token != null ? 'Bearer $token' : null,
      );
      EasyLoading.dismiss();

      if (response.isSuccess) {
        final data = response.responseData;
        if (data["success"] == true) {
          EasyLoading.showSuccess(data["message"] ?? "Shift published");

          // Navigate to assign employee screen after successful publish
          SchedulingRoutes.toAssignEmployee();
        } else {
          EasyLoading.showError(data["message"] ?? "Publish failed");
        }
      } else {
        EasyLoading.showError("Failed: ${response.errorMessage}");
      }
    } catch (e) {
      EasyLoading.dismiss();
      _logger.e("Error publishing shift: $e");
      EasyLoading.showError("Failed to publish shift");
    }
  }

  // ================= HELPERS =================
  void goBack() => SchedulingRoutes.back();

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'am' : 'pm';
    return '$hour:$minute $period';
  }

  DateTime _parseTimeStringToDateTime(String timeString, DateTime baseDate) {
    final format = DateFormat("h:mm a");
    final parsedTime = format.parse(timeString);
    return DateTime(
      baseDate.year,
      baseDate.month,
      baseDate.day,
      parsedTime.hour,
      parsedTime.minute,
    );
  }

  void _calculateDuration() {
    try {
      final startDateTime = _parseTimeStringToDateTime(
        startTime.value,
        selectedDate.value,
      );
      final endDateTime = _parseTimeStringToDateTime(
        endTime.value,
        selectedDate.value,
      );

      if (endDateTime.isBefore(startDateTime)) {
        duration.value = "Invalid range";
        return;
      }

      final diff = endDateTime.difference(startDateTime);
      final hours = diff.inHours;
      final minutes = diff.inMinutes.remainder(60);

      duration.value =
          "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} Hours";
    } catch (e) {
      duration.value = "00:00 Hours";
    }
  }

  Future<void> pickCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        EasyLoading.showError('Location permission denied forever');
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      latitude = isEditable ? latitude : position.latitude;
      longitude = isEditable ? longitude : position.longitude;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude!,
        longitude!,
      );
      Placemark place = placemarks[0];
      locationController.text =
          '${place.name}, ${place.locality}, ${place.country}';

      // Show map after picking location
      showMap.value = true;

      EasyLoading.showSuccess('Location picked successfully');
    } catch (error) {
      EasyLoading.showError('Failed to pick location');
    }
  }

  /// Search for location based on typed text
  Future<void> searchLocation(String query) async {
    // Cancel previous timer
    _searchTimer?.cancel();

    if (query.isEmpty || query.length < 3) {
      locationSuggestions.clear();
      showMap.value = false;
      isSearching.value = false;
      return;
    }

    // Show searching indicator immediately
    isSearching.value = true;

    // Set a timer to debounce the search
    _searchTimer = Timer(const Duration(milliseconds: 800), () async {
      await _performLocationSearch(query);
    });
  }

  /// Perform the actual location search
  Future<void> _performLocationSearch(String query) async {
    try {
      // Use geocoding to search for locations
      List<Location> locations = await locationFromAddress(query);

      if (locations.isNotEmpty) {
        // Take the first result
        Location location = locations.first;
        latitude = location.latitude;
        longitude = location.longitude;

        // Get place details for the found location
        List<Placemark> placemarks = await placemarkFromCoordinates(
          latitude!,
          longitude!,
        );

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;

          // Update location field with formatted address
          String formattedAddress = '';
          if (place.name != null && place.name!.isNotEmpty) {
            formattedAddress += place.name!;
          }
          if (place.locality != null && place.locality!.isNotEmpty) {
            if (formattedAddress.isNotEmpty) formattedAddress += ', ';
            formattedAddress += place.locality!;
          }
          if (place.country != null && place.country!.isNotEmpty) {
            if (formattedAddress.isNotEmpty) formattedAddress += ', ';
            formattedAddress += place.country!;
          }

          // Show map with found location
          showMap.value = true;
        }
      } else {
        // No location found
        showMap.value = false;
      }
    } catch (error) {
      _logger.w('Location search failed: $error');
      showMap.value = false;
      // Don't show error for search failures as user might still be typing
    } finally {
      isSearching.value = false;
    }
  }

  /// Select a location from coordinates
  Future<void> selectLocation(double lat, double lng) async {
    try {
      latitude = lat;
      longitude = lng;

      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        locationController.text =
            '${place.name}, ${place.locality}, ${place.country}';
        showMap.value = true;
      }
    } catch (error) {
      EasyLoading.showError('Failed to get location details');
    }
  }

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
                    onPressed: () => SchedulingRoutes.back(),
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
                        selectedTaskIds.add(
                          newTask.id,
                        ); // ✅ add taskId for publish
                        SchedulingRoutes.back();
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
    _searchTimer?.cancel();
    shiftTitleController.dispose();
    jobController.dispose();
    usersController.dispose();
    locationController.dispose();
    noteController.dispose();
    selectedDate.close();
    isAllDay.close();
    startTime.close();
    endTime.close();
    duration.close();
    tasks.close();
    activities.close();
    selectedProjectId.close();
    selectedUserIds.clear();
    selectedTaskIds.close();
    locationSuggestions.close();
    isSearching.close();
    showMap.close();
    super.onClose();
  }
}
