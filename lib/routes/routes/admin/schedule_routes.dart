import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/views/shift_scheduling_screen.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/views/add_project_screen.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/views/access_schedule_screen.dart';

import '../../config/route_constants.dart';

/// Admin Schedule section routes with all sub-routes
///
/// This module handles all routes related to the admin schedule management section,
/// including the main admin schedule page and all its sub-pages.
class AdminScheduleRoutes {
  AdminScheduleRoutes._();

  /// Admin Schedule section branch for the main shell
  static final StatefulShellBranch branch = StatefulShellBranch(
    navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'admin_schedule'),
    routes: [
      GoRoute(
        path: RoutePaths.adminSchedule,
        name: RouteNames.adminSchedule,
        builder: (context, state) => TimeSheetScreen(),
        routes: [
          // Add Project route
          GoRoute(
            path: 'add-project',
            name: RouteNames.adminAddProject,
            builder: (context, state) => const AddProjectScreen(),
          ),

          // Access Schedule route
          GoRoute(
            path: 'access-schedule',
            name: RouteNames.adminAccessSchedule,
            builder: (context, state) => const AccessScheduleScreen(),
          ),

          // Assign Employee route
          // GoRoute(
          //   path: 'assign-employee',
          //   name: RouteNames.adminAssignEmployee,
          //   builder: (context, state) => const AssignEmployeeScreen(),
          // ),

          // Admin Schedule details page
          // GoRoute(
          //   path: 'details',
          //   name: RouteNames.adminScheduleDetails,
          //   builder: (context, state) => const AdminScheduleDetailsPage(),
          // ),

          // // Admin Schedule create page
          // GoRoute(
          //   path: 'create',
          //   name: RouteNames.adminScheduleCreate,
          //   builder: (context, state) => const AdminScheduleCreatePage(),
          // ),

          // // Admin Schedule management page
          // GoRoute(
          //   path: 'manage',
          //   name: RouteNames.adminScheduleManage,
          //   builder: (context, state) => const AdminScheduleManagePage(),
          // ),
        ],
      ),
    ],
  );
}
