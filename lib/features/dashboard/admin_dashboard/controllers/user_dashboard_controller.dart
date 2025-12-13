import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/services/network_caller.dart';
import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';
import 'package:jesusvlsco/features/user_profile/controller/user_profile_controller.dart';
import 'package:jesusvlsco/features/user_time_clock/controller/user_time_clock_controller.dart';

class UserDashboardController extends GetxController {
  final UserProfileController userProfileController = Get.put(
    UserProfileController(),
  );

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

  // Upcoming shifts from dashboard
  final RxList<Map<String, String>> upcomingShifts =
      <Map<String, String>>[].obs;

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
          'description': 'Badge received by You on June 17, 2025',
          'imagePath': 'assets/icons/crown.png',
        },
        {
          'title': 'Team Achievement: Project Alpha Completed',
          'description': 'Badge received by You on June 17, 2025',
          'imagePath': 'assets/icons/crown.png',
        },
        {
          'title': 'Innovation Award: Sarah Johnson',
          'description': 'Badge received by You on June 17, 2025',
          'imagePath': 'assets/icons/crown.png',
        },
        {
          'title': 'Customer Service Excellence: Mike Chen',
          'description': 'Badge received by You on June 17, 2025',
          'imagePath': 'assets/icons/crown.png',
        },
        {
          'title': 'Team Collaboration: Marketing Team',
          'description': 'Badge received by You on June 17, 2025',
          'imagePath': 'assets/icons/crown.png',
        },
      ].obs;

  // Active shift flag
  final RxBool hasActiveShift = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Load current clock/shift info for the user
    loadCurrentClock();
    // Load dashboard sections: upcoming tasks, company updates, recognitions
    loadDashboard();
  }

  /// Loads the current clock/shift info for the user. Updates UI observables.
  Future<void> loadCurrentClock() async {
    final token = StorageService.token;
    final caller = NetworkCaller();
    final url =
        '${ApiConstants.baseurl}${ApiConstants.currentClock}?date=${DateTime.now().toUtc().toIso8601String()}';

    final resp = await caller.getRequest(url, token: token);
    if (resp.isSuccess || resp.statusCode == 200) {
      final data = resp.responseData['data'];
      if (kDebugMode) {
        print("📌 DATA: $data");
      }
      if (kDebugMode) {
        print("📌 isClockedIn: ${data['isClockedIn']}");
      }
      if (data != null && data is Map) {
        if (!Get.isRegistered<UserTimeClockController>()) {
          Get.put(UserTimeClockController(), permanent: true);
        }
        try {
          final utc = Get.find<UserTimeClockController>();
          utc.isClockedIn.value = (data['isClockedIn'] == true);
          if (kDebugMode) {
            print("DEBUG: UTC isClockedIn = ${utc.isClockedIn.value}");
            print("DEBUG: Dashboard isClockedIn = ${utc.isClockedIn}");
          }

          final shift = data['shift'];

          if (shift != null && shift is Map) {
            // parse start/end times
            final startStr = shift['startTime'] ?? shift['start'] ?? '';
            final endStr = shift['endTime'] ?? shift['end'] ?? '';
            DateTime? startDt;
            DateTime? endDt;
            try {
              if (startStr != null && startStr.toString().isNotEmpty) {
                startDt = DateTime.parse(startStr.toString()).toLocal();
              }
            } catch (_) {}
            try {
              if (endStr != null && endStr.toString().isNotEmpty) {
                endDt = DateTime.parse(endStr.toString()).toLocal();
              }
            } catch (_) {}

            if (startDt != null && endDt != null) {
              shiftTime.value =
                  '${_formatTime(startDt)} - ${_formatTime(endDt)}';
            } else if (startDt != null) {
              shiftTime.value = _formatTime(startDt);
            }

            if (shift['date'] != null) {
              try {
                final dateDt = DateTime.parse(
                  shift['date'].toString(),
                ).toLocal();
                shiftDate.value = _formatDate(dateDt);
              } catch (_) {
                shiftDate.value = shift['date'].toString();
              }
            }

            final location = shift['location'] ?? shift['locationName'] ?? '';
            if (location != null && location.toString().isNotEmpty) {
              shiftLocation.value = location.toString();
            }

            // teamMembers from response
            final tm = data['teamMembers'];
            if (tm != null && tm is List) {
              teamMembers.clear();
              for (final m in tm) {
                if (m is Map) {
                  final fn = (m['firstName'] ?? '') as String;
                  final ln = (m['lastName'] ?? '') as String;
                  String initial = '?';
                  if (fn.isNotEmpty) {
                    initial = fn[0].toUpperCase();
                  } else if (ln.isNotEmpty)
                    // ignore: curly_braces_in_flow_control_structures
                    initial = ln[0].toUpperCase();
                  teamMembers.add({
                    'initial': initial,
                    'name': '$fn $ln'.trim(),
                  });
                }
              }
            }

            hasActiveShift.value = true;
          } else {
            hasActiveShift.value = false;
          }
        } catch (e) {
          // If shape unexpected, keep defaults and mark no active shift
          hasActiveShift.value = false;
        }
      } else {
        hasActiveShift.value = false;
      }
    } else {
      // Not found or other error
      hasActiveShift.value = false;
    }
  }

  /// Loads dashboard sections (upcoming tasks, company updates, recognitions)
  Future<void> loadDashboard() async {
    final token = StorageService.token;
    final caller = NetworkCaller();
    final url = '${ApiConstants.baseurl}${ApiConstants.employeeDashboard}';

    final resp = await caller.getRequest(url, token: token);
    if (resp.isSuccess) {
      final data = resp.responseData['data'];
      if (data != null && data is Map) {
        // upcomingTasks
        final uts = data['upcomingTasks'];
        if (uts != null && uts is List) {
          upcomingTasks.clear();
          for (final t in uts) {
            if (t is Map) {
              final title = (t['title'] ?? '') as String;
              final start = t['startTime'];
              final end = t['endTime'];
              final isToday = _isToday(start);
              final dueDate = _formatDueDate(start, end);
              upcomingTasks.add({
                'title': title,
                'dueDate': dueDate,
                'isToday': isToday,
              });
            }
          }
        }

        // upcomingShifts
        final us = data['upcomingShifts'];
        if (us != null && us is List) {
          upcomingShifts.clear();
          for (final sh in us) {
            if (sh is Map) {
              final start = sh['startTime'];
              final end = sh['endTime'];
              String time = '';
              try {
                if (start != null && end != null) {
                  final sdt = DateTime.parse(start.toString()).toLocal();
                  final edt = DateTime.parse(end.toString()).toLocal();
                  time = '${_formatTime(sdt)} - ${_formatTime(edt)}';
                }
              } catch (_) {}

              final location = (sh['location'] ?? '') as String;

              // team: if controller.teamMembers was loaded from currentClock, use that; otherwise build from shift.teamMembers if provided
              String teamStr = '';
              if (teamMembers.isNotEmpty) {
                teamStr = teamMembers
                    .map((e) => e['name'])
                    .whereType<String>()
                    .join(', ');
              } else if (sh['teamMembers'] != null &&
                  sh['teamMembers'] is List) {
                final list = <String>[];
                for (final m in sh['teamMembers']) {
                  if (m is Map) {
                    final fn = (m['firstName'] ?? '') as String;
                    final ln = (m['lastName'] ?? '') as String;
                    final name = '$fn $ln'.trim();
                    if (name.isNotEmpty) list.add(name);
                  }
                }
                teamStr = list.join(', ');
              }

              upcomingShifts.add({
                'time': time,
                'location': location,
                'team': teamStr,
              });
            }
          }
        }

        // companyUpdates
        final cus = data['companyUpdates'];
        if (cus != null && cus is List) {
          companyUpdates.clear();
          for (final u in cus) {
            if (u is Map) {
              final type = (u['type'] ?? '') as String;
              final title = (u['title'] ?? '') as String;
              final message = (u['message'] ?? '') as String;
              final publishedAt =
                  (u['meta'] != null && u['meta']['publishedAt'] != null)
                  ? u['meta']['publishedAt'].toString()
                  : (u['createdAt'] ?? '').toString();
              companyUpdates.add({
                'department': type,
                'departmentName': title,
                'message': message,
                'timeAgo': publishedAt,
              });
            }
          }
        }

        // recognitions -> recognitionEngagement
        final recs = data['recognitions'];
        if (recs != null && recs is List) {
          recognitionEngagement.clear();
          for (final r in recs) {
            if (r is Map) {
              final title = (r['title'] ?? '') as String;
              final message = (r['message'] ?? '') as String;
              // performedBy or meta info could be used for image path later
              recognitionEngagement.add({
                'title': title,
                'description': message,
                'imagePath': 'assets/icons/crown.png',
              });
            }
          }
        }
      }
    }
  }

  bool _isToday(dynamic isoString) {
    try {
      if (isoString == null) return false;
      final dt = DateTime.parse(isoString.toString()).toLocal();
      final now = DateTime.now();
      return dt.year == now.year && dt.month == now.month && dt.day == now.day;
    } catch (_) {
      return false;
    }
  }

  String _formatDueDate(dynamic startIso, dynamic endIso) {
    try {
      if (startIso == null) return '';
      final start = DateTime.parse(startIso.toString()).toLocal();
      final now = DateTime.now();
      if (start.year == now.year &&
          start.month == now.month &&
          start.day == now.day) {
        return 'Today';
      }
      final diff = start.difference(now);
      if (diff.inDays == 1) return 'Tomorrow';
      return '${start.month}/${start.day}';
    } catch (_) {
      return '';
    }
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $ampm';
  }

  String _formatDate(DateTime dt) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final wd = weekdays[(dt.weekday - 1) % 7];
    final mn = months[dt.month - 1];
    return '$wd, $mn ${dt.day}';
  }

  /// Sends a clock action to the server. action should be 'CLOCK_IN' or 'CLOCK_OUT'.
  Future<void> processClock(
    String action, {
    double lat = 0.0,
    double lng = 0.0,
  }) async {
    final token = StorageService.token;
    final caller = NetworkCaller();
    final url = '${ApiConstants.baseurl}${ApiConstants.processClock}';

    final body = {'lat': lat, 'lng': lng, 'action': action};

    final resp = await caller.postRequest(url, body: body, token: token);

    if (resp.isSuccess) {
      Get.snackbar(
        'Success',
        resp.responseData['message'] ?? 'Clock processed',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      final err =
          resp.responseData != null && resp.responseData['message'] != null
          ? resp.responseData['message']
          : resp.errorMessage;
      Get.snackbar(
        'Error',
        err is String ? err : err?.toString() ?? 'Failed to process clock',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> clockIn({double lat = 0.0, double lng = 0.0}) async {
    await processClock('CLOCK_IN', lat: lat, lng: lng);
    await loadCurrentClock();
  }

  Future<void> clockOut({double lat = 0.0, double lng = 0.0}) async {
    await processClock('CLOCK_OUT', lat: lat, lng: lng);
    await loadCurrentClock();
  }
}
