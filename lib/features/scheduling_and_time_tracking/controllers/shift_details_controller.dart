// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:logger/logger.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;

// import '../../../core/utils/constants/sizer.dart';
// import '../../../core/utils/constants/colors.dart';
// import '../../../core/common/styles/global_text_style.dart';
// import '../../../core/services/storage_service.dart';
// import '../models/task_model.dart';
// import '../models/activity_model.dart';
// import '../screens/widgets/shift_emplate_widgets/add_user_dialog.dart';
// import '../routes/scheduling_routes.dart';
// import '../../../core/common/widgets/custom_date_picker_widget.dart';

// class ShiftDetailsController extends GetxController {
//   final Logger _logger = Logger();

//   // Form controllers
//   final shiftTitleController = TextEditingController();
//   final jobController = TextEditingController();
//   final usersController = TextEditingController();
//   final locationController = TextEditingController();
//   final noteController = TextEditingController();

//   // Observable variables for date and time
//   var selectedDate = DateTime.now().obs;
//   var selectedDateFormatted = ''.obs;
//   var isAllDay = true.obs;
//   var startTime = '9:00 am'.obs;
//   var endTime = '5:00 pm'.obs;
//   var duration = '08:00 Hours'.obs;

//   // Tasks and activities lists
//   var tasks = <TaskModel>[].obs;
//   var activities = <ActivityModel>[].obs;

//   // Location lat/lng
//   double? latitude;
//   double? longitude;

//   @override
//   void onInit() {
//     super.onInit();
//     _loadMockData();
//     _logger.i('ShiftDetailsController initialized');

//     selectedDateFormatted.value = DateFormat(
//       'dd/MM/yyyy',
//     ).format(selectedDate.value);
//   }

//   void _loadMockData() {
//     tasks.value = [
//       const TaskModel(
//         id: '1',
//         title: 'Metro Shopping Center',
//         isCompleted: true,
//       ),
//       const TaskModel(
//         id: '2',
//         title: 'City Bridge Renovations',
//         isCompleted: false,
//       ),
//     ];

//     activities.value = [
//       ActivityModel(
//         id: '1',
//         userName: 'Emma Willson',
//         userAvatar: 'https://i.pravatar.cc/150?img=1',
//         action: 'Shift published by',
//         timestamp: DateTime.now().subtract(const Duration(hours: 2)),
//       ),
//     ];
//   }

//   // ================= DATE & TIME =================
//   Future<void> selectDate() async {
//     try {
//       final DateTime? picked = await CustomDatePicker.show(
//         context: Get.context!,
//         initialDate: selectedDate.value,
//       );

//       if (picked != null) {
//         selectedDate.value = picked;
//         selectedDateFormatted.value = DateFormat('dd/MM/yyyy').format(picked);
//       }
//     } catch (error) {
//       EasyLoading.showError('Failed to show date picker');
//     }
//   }

//   void selectStartTime() async {
//     final TimeOfDay? picked = await Get.dialog<TimeOfDay>(
//       _buildTimePicker(startTime.value),
//     );
//     if (picked != null) {
//       startTime.value = _formatTimeOfDay(picked);
//       _calculateDuration();
//     }
//   }

//   void selectEndTime() async {
//     final TimeOfDay? picked = await Get.dialog<TimeOfDay>(
//       _buildTimePicker(endTime.value),
//     );
//     if (picked != null) {
//       endTime.value = _formatTimeOfDay(picked);
//       _calculateDuration();
//     }
//   }

//   void toggleAllDay() {
//     isAllDay.value = !isAllDay.value;
//   }

//   // ================= TASK =================
//   void toggleTask(String taskId) {
//     final taskIndex = tasks.indexWhere((task) => task.id == taskId);
//     if (taskIndex != -1) {
//       final updatedTask = tasks[taskIndex].copyWith(
//         isCompleted: !tasks[taskIndex].isCompleted,
//       );
//       tasks[taskIndex] = updatedTask;
//       tasks.refresh();
//     }
//   }

//   void addTask() {
//     Get.dialog(_buildAddTaskDialog());
//   }

//   // ================= USER =================
//   Future<void> addUser() async {
//     final selectedUsers = await showDialog<List<UserModel>>(
//       context: Get.context!,
//       builder: (context) => const AddUserDialog(),
//     );

//     if (selectedUsers != null && selectedUsers.isNotEmpty) {
//       for (final user in selectedUsers) {
//         activities.add(
//           ActivityModel(
//             id: DateTime.now().millisecondsSinceEpoch.toString(),
//             userName: user.name,
//             userAvatar: user.avatar,
//             action: 'Added to shift',
//             timestamp: DateTime.now(),
//           ),
//         );
//       }
//       EasyLoading.showSuccess('${selectedUsers.length} user(s) added to shift');
//       update();
//     }
//   }

//   // ================= SAVE & PUBLISH =================
//   void saveAsTemplate() {
//     SchedulingRoutes.toShiftTemplate();
//   }

//   void saveDraft() {
//     EasyLoading.showSuccess('Shift saved as draft successfully');
//   }

//   /// Publish the shift (API integration)
//   Future<void> publish() async {
//     _logger.i('Publishing shift...');

//     if (shiftTitleController.text.isEmpty) {
//       EasyLoading.showError('Please enter shift title');
//       return;
//     }
//     if (jobController.text.isEmpty) {
//       EasyLoading.showError('Please enter job');
//       return;
//     }
//     if (locationController.text.isEmpty) {
//       EasyLoading.showError('Please enter location');
//       return;
//     }

//     try {
//       EasyLoading.show(status: 'Publishing...');

//       final token = StorageService.token ?? '';
//       print("DEBUG TOKEN: $token");

//       DateTime startDateTime;
//       DateTime endDateTime;

//       if (!isAllDay.value) {
//         startDateTime = _parseTimeStringToDateTime(
//           startTime.value,
//           selectedDate.value,
//         );
//         endDateTime = _parseTimeStringToDateTime(
//           endTime.value,
//           selectedDate.value,
//         );

//         if (endDateTime.isBefore(startDateTime)) {
//           EasyLoading.dismiss();
//           EasyLoading.showError("End time must be after start time");
//           return;
//         }
//       } else {
//         // Default all-day shift range (08:00–17:00)
//         startDateTime = DateTime(
//           selectedDate.value.year,
//           selectedDate.value.month,
//           selectedDate.value.day,
//           8,
//           0,
//         );
//         endDateTime = DateTime(
//           selectedDate.value.year,
//           selectedDate.value.month,
//           selectedDate.value.day,
//           17,
//           0,
//         );
//       }

//       final body = {
//         "currentProjectId": "824aa26d-e4af-4123-9873-4881023fa039",
//         "date": DateFormat("yyyy-MM-dd").format(selectedDate.value),
//         "shiftStatus": "PUBLISHED",
//         "startTime": startDateTime.toUtc().toIso8601String(),
//         "endTime": endDateTime.toUtc().toIso8601String(),
//         "shiftTitle": shiftTitleController.text,
//         "allDay": isAllDay.value,
//         "job": jobController.text,
//         "userIds": [],
//         "taskIds": tasks.map((t) => t.id).toList(),
//         "location": locationController.text,
//         "locationLat": latitude ?? 23.8103,
//         "locationLng": longitude ?? 90.4125,
//         "note": noteController.text,
//       };

//       final response = await http.post(
//         Uri.parse("https://lgcglobalcontractingltd.com/js/shift"),
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $token",
//         },
//         body: jsonEncode(body),
//       );

//       debugPrint("Response Status: ${response.statusCode}");
//       debugPrint("Response Body: ${response.body}");

//       EasyLoading.dismiss();

//       if (response.statusCode == 201) {
//         final data = jsonDecode(response.body);
//         if (data["success"] == true) {
//           EasyLoading.showSuccess("Shift published successfully");
//           _logger.i("Shift created: ${data["data"]["id"]}");
//         } else {
//           EasyLoading.showError(data["message"] ?? "Publish failed");
//         }
//       } else {
//         EasyLoading.showError("Failed: ${response.body}");
//       }
//     } catch (e) {
//       EasyLoading.dismiss();
//       _logger.e("Error publishing shift: $e");
//       EasyLoading.showError("Failed to publish shift");
//     }
//   }

//   // ================= HELPERS =================
//   void goBack() => SchedulingRoutes.back();

//   String _formatTimeOfDay(TimeOfDay time) {
//     final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
//     final minute = time.minute.toString().padLeft(2, '0');
//     final period = time.period == DayPeriod.am ? 'am' : 'pm';
//     return '$hour:$minute $period';
//   }

//   DateTime _parseTimeStringToDateTime(String timeString, DateTime baseDate) {
//     final format = DateFormat("h:mm a");
//     final parsedTime = format.parse(timeString);
//     return DateTime(
//       baseDate.year,
//       baseDate.month,
//       baseDate.day,
//       parsedTime.hour,
//       parsedTime.minute,
//     );
//   }

//   void _calculateDuration() {
//     try {
//       final startDateTime = _parseTimeStringToDateTime(
//         startTime.value,
//         selectedDate.value,
//       );
//       final endDateTime = _parseTimeStringToDateTime(
//         endTime.value,
//         selectedDate.value,
//       );

//       if (endDateTime.isBefore(startDateTime)) {
//         duration.value = "Invalid range";
//         return;
//       }

//       final diff = endDateTime.difference(startDateTime);
//       final hours = diff.inHours;
//       final minutes = diff.inMinutes.remainder(60);

//       duration.value =
//           "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} Hours";
//     } catch (e) {
//       duration.value = "00:00 Hours";
//     }
//   }

//   Future<void> pickCurrentLocation() async {
//     try {
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//       }
//       if (permission == LocationPermission.deniedForever) {
//         EasyLoading.showError('Location permission denied forever');
//         return;
//       }

//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best,
//       );

//       latitude = position.latitude;
//       longitude = position.longitude;

//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         latitude!,
//         longitude!,
//       );
//       Placemark place = placemarks[0];
//       locationController.text =
//           '${place.name}, ${place.locality}, ${place.country}';

//       EasyLoading.showSuccess('Location picked successfully');
//     } catch (error) {
//       EasyLoading.showError('Failed to pick location');
//     }
//   }

//   Widget _buildTimePicker(String currentTime) {
//     return Dialog(
//       child: Container(
//         margin: EdgeInsets.only(top: Sizer.hp(20)),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Select Time',
//               style: AppTextStyle.f18W600().copyWith(color: AppColors.primary),
//             ),
//             SizedBox(height: Sizer.hp(20)),
//             TimePickerDialog(initialTime: TimeOfDay.now()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAddTaskDialog() {
//     final taskController = TextEditingController();

//     return Dialog(
//       child: Container(
//         padding: EdgeInsets.all(Sizer.wp(20)),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Add New Task',
//               style: AppTextStyle.f18W600().copyWith(color: AppColors.primary),
//             ),
//             SizedBox(height: Sizer.hp(20)),
//             TextField(
//               controller: taskController,
//               decoration: const InputDecoration(
//                 hintText: 'Enter task title',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: Sizer.hp(20)),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextButton(
//                     onPressed: () => SchedulingRoutes.back(),
//                     child: const Text('Cancel'),
//                   ),
//                 ),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (taskController.text.isNotEmpty) {
//                         final newTask = TaskModel(
//                           id: DateTime.now().millisecondsSinceEpoch.toString(),
//                           title: taskController.text,
//                           isCompleted: false,
//                         );
//                         tasks.add(newTask);
//                         SchedulingRoutes.back();
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primary,
//                     ),
//                     child: const Text(
//                       'Add',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void onClose() {
//     shiftTitleController.dispose();
//     jobController.dispose();
//     usersController.dispose();
//     locationController.dispose();
//     noteController.dispose();
//     super.onClose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/constants/sizer.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/common/styles/global_text_style.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/api_constants.dart';
import '../../../core/models/response_data.dart';
import '../models/task_model.dart';
import '../models/activity_model.dart';
import '../screens/widgets/shift_emplate_widgets/add_user_dialog.dart';
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

  // Tasks and activities lists
  var tasks = <TaskModel>[].obs;
  var activities = <ActivityModel>[].obs;

  // Dynamic data
  var selectedProjectId = "".obs;
  var selectedUserIds = <String>[].obs;
  var selectedTaskIds = <String>[].obs;

  // Location lat/lng
  double? latitude;
  double? longitude;

  @override
  void onInit() {
    super.onInit();
    _loadMockData();
    _logger.i('ShiftDetailsController initialized');

    selectedDateFormatted.value = DateFormat(
      'dd/MM/yyyy',
    ).format(selectedDate.value);

    fetchProjects(); // ✅ auto project fetch
  }

  void _loadMockData() {
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
    ];

    activities.value = [
      ActivityModel(
        id: '1',
        userName: 'Emma Willson',
        userAvatar: 'https://i.pravatar.cc/150?img=1',
        action: 'Shift published by',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ];
  }

  // ================= FETCH PROJECT =================
  Future<void> fetchProjects() async {
    _logger.i("🔄 Fetching projects...");

    try {
      final String? token = await StorageService.getAuthToken();
      final String url =
          '${ApiConstants.baseurl}${ApiConstants.allAdminProjects}';

      _logger.i("🌐 Making request to: $url");

      final ResponseData response = await _networkCaller.getRequest(
        url,
        token: token != null ? 'Bearer $token' : null,
      );

      // Debug response
      _logger.i("Response Status: ${response.statusCode}");
      _logger.i("Response Body: ${response.responseData}");

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData;
        final projects = data["data"]["projects"] as List? ?? [];

        if (projects.isNotEmpty) {
          selectedProjectId.value = projects.first["id"];
          _logger.i("✅ Projects loaded: ${projects.length}");
          _logger.i("👉 Selected Project ID: ${selectedProjectId.value}");
        } else {
          _logger.w("⚠️ No projects found in API response");
        }
      } else {
        _logger.e("⛔ Failed to fetch projects: ${response.errorMessage}");
      }
    } catch (e) {
      _logger.e("💥 Error fetching projects: $e");
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

  // ================= USER =================
  Future<void> addUser() async {
    final selectedUsers = await showDialog<List<UserModel>>(
      context: Get.context!,
      builder: (context) => const AddUserDialog(),
    );

    if (selectedUsers != null && selectedUsers.isNotEmpty) {
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

        selectedUserIds.add(user.id); // ✅ add id for publish
      }
      EasyLoading.showSuccess('${selectedUsers.length} user(s) added to shift');
      update();
    }
  }

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

      _logger.i("🌐 Publishing shift to: $url");
      _logger.i("📤 Request body: $requestBody");

      final ResponseData response = await _networkCaller.postRequest(
        url,
        body: requestBody,
        token: token != null ? 'Bearer $token' : null,
      );

      _logger.i("Response Status: ${response.statusCode}");
      _logger.i("Response Body: ${response.responseData}");

      EasyLoading.dismiss();

      if (response.isSuccess) {
        final data = response.responseData;
        if (data["success"] == true) {
          EasyLoading.showSuccess("Shift published successfully");
          _logger.i("Shift created: ${data["data"]["id"]}");
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

      latitude = position.latitude;
      longitude = position.longitude;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude!,
        longitude!,
      );
      Placemark place = placemarks[0];
      locationController.text =
          '${place.name}, ${place.locality}, ${place.country}';

      EasyLoading.showSuccess('Location picked successfully');
    } catch (error) {
      EasyLoading.showError('Failed to pick location');
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
    shiftTitleController.dispose();
    jobController.dispose();
    usersController.dispose();
    locationController.dispose();
    noteController.dispose();
    super.onClose();
  }
}
