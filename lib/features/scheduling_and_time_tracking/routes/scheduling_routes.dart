import 'package:get/get.dart';
import '../screens/views/shift_scheduling_screen.dart';
import '../screens/views/add_project_screen.dart';
import '../screens/views/access_schedule_screen.dart';
import '../screens/views/assign_employee_screen.dart';
import '../screens/views/shift_details_screen.dart';
import '../screens/views/shift_template_screen.dart';
import '../controllers/shift_scheduling_controller.dart';
import '../controllers/add_project_controller.dart';
import '../controllers/access_schedule_controller.dart';
import '../controllers/assign_employee_controller.dart';
import '../controllers/shift_details_controller.dart';
import '../controllers/shift_template_controller.dart';

/// GetX Routes for Scheduling and Time Tracking module
///
/// This class defines all routes and their bindings for the scheduling feature.
/// All navigation within this module will use GetX instead of GoRouter.
class SchedulingRoutes {
  SchedulingRoutes._();

  /// Route names - used for GetX navigation
  static const String timeSheet = '/scheduling/time-sheet';
  static const String addProject = '/scheduling/add-project';
  static const String accessSchedule = '/scheduling/access-schedule';
  static const String assignEmployee = '/scheduling/assign-employee';
  static const String shiftDetails = '/scheduling/shift-details';
  static const String shiftTemplate = '/scheduling/shift-template';

  /// GetX Pages configuration for scheduling module
  static List<GetPage> pages = [
    // Time Sheet Screen (Main scheduling screen)
    GetPage(
      name: timeSheet,
      page: () => TimeSheetScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<TimeSheetController>(() => TimeSheetController());
      }),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Add Project Screen
    GetPage(
      name: addProject,
      page: () => const AddProjectScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AddProjectController>(() => AddProjectController());
      }),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Access Schedule Screen
    GetPage(
      name: accessSchedule,
      page: () => const AccessScheduleScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AccessScheduleController>(() => AccessScheduleController());
      }),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Assign Employee Screen
    GetPage(
      name: assignEmployee,
      page: () => const AssignEmployeeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AssignEmployeeController>(() => AssignEmployeeController());
      }),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Shift Details Screen
    GetPage(
      name: shiftDetails,
      page: () => const ShiftDetailsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ShiftDetailsController>(() => ShiftDetailsController());
      }),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Shift Template Screen
    GetPage(
      name: shiftTemplate,
      page: () => const ShiftTemplateScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ShiftTemplateController>(() => ShiftTemplateController());
      }),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];

  /// Helper methods for navigation within the scheduling module

  /// Navigate to Time Sheet screen
  static void toTimeSheet() {
    Get.toNamed(timeSheet);
  }

  /// Navigate to Add Project screen
  static void toAddProject() {
    Get.toNamed(addProject);
  }

  /// Navigate to Access Schedule screen with arguments
  static void toAccessSchedule({Map<String, dynamic>? arguments}) {
    Get.toNamed(accessSchedule, arguments: arguments);
  }

  /// Navigate to Assign Employee screen
  static void toAssignEmployee() {
    Get.toNamed(assignEmployee);
  }

  /// Navigate to Shift Details screen with arguments
  static void toShiftDetails({Map<String, dynamic>? arguments}) {
    Get.toNamed(shiftDetails, arguments: arguments);
  }

  /// Navigate to Shift Template screen
  static void toShiftTemplate() {
    Get.toNamed(shiftTemplate);
  }

  /// Go back to previous screen
  static void back() {
    Get.back();
  }

  /// Close current screen and go back
  static void close() {
    Get.back();
  }

  /// Navigate and remove all previous routes
  static void offAllToTimeSheet() {
    Get.offAllNamed(timeSheet);
  }
}
