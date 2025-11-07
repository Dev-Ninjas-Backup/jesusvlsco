import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/features/taskmanagement/screens/taskmanagement_dashboard.dart';

import '../../config/route_constants.dart';

/// Admin Projects section routes with all sub-routes
///
/// This module handles all routes related to the admin projects management section,
/// including the main admin projects page and all its sub-pages.
class AdminProjectsRoutes {
  AdminProjectsRoutes._();

  /// Admin Projects section branch for the main shell
  static final StatefulShellBranch branch = StatefulShellBranch(
    navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'admin_projects'),
    routes: [
      GoRoute(
        path: RoutePaths.adminProjects,
        name: RouteNames.adminProjects,
        builder: (context, state) => const TaskmanagementDashboard(),
        routes: [
          // Admin Projects details page
          // GoRoute(
          //   path: 'details',
          //   name: RouteNames.adminProjectsDetails,
          //   builder: (context, state) => const AdminProjectsDetailsPage(),
          // ),

          // // Admin Projects create page
          // GoRoute(
          //   path: 'create',
          //   name: RouteNames.adminProjectsCreate,
          //   builder: (context, state) => const AdminProjectsCreatePage(),
          // ),

          // // Admin Projects management page
          // GoRoute(
          //   path: 'manage',
          //   name: RouteNames.adminProjectsManage,
          //   builder: (context, state) => const AdminProjectsManagePage(),
          // ),
        ],
      ),
    ],
  );
}
