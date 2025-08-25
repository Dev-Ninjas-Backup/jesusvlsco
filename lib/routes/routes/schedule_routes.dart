import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/views/shift_scheduling_screen.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/views/add_project_screen.dart';
import 'package:jesusvlsco/routes/config/route_constants.dart';

/// Schedule section routes with all sub-routes
///
/// This module handles all routes related to the schedule section,
/// including TimeSheet and Add Project functionality.
class ScheduleRoutes {
  ScheduleRoutes._();

  /// Schedule section branch for the main shell
  static final StatefulShellBranch branch = StatefulShellBranch(
    navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'Schedule'),
    routes: [
      GoRoute(
        path: RoutePaths.schedule,
        name: RouteNames.schedule,
        builder: (context, state) => TimeSheetScreen(),
        routes: [
          // Add Project page
          GoRoute(
            path: 'add-project',
            name: RouteNames.addProject,
            builder: (context, state) => const AddProjectScreen(),
          ),
        ],
      ),
    ],
  );
}
