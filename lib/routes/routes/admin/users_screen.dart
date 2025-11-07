import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/features/user/screen/employee_list_screen.dart';

import '../../config/route_constants.dart';

/// Admin Users section routes with all sub-routes
///
/// This module handles all routes related to the admin users management section,
/// including the main admin users page and all its sub-pages.
class AdminUsersRoutes {
  AdminUsersRoutes._();

  /// Admin Users section branch for the main shell
  static final StatefulShellBranch branch = StatefulShellBranch(
    navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'admin_users'),
    routes: [
      GoRoute(
        path: RoutePaths.adminUsers,
        name: RouteNames.adminUsers,
        builder: (context, state) =>  EmployeeListScreen(),
        routes: [
          // Admin Users details page
          // GoRoute(
          //   path: 'details',
          //   name: RouteNames.adminUsersDetails,
          //   builder: (context, state) => const AdminUsersDetailsPage(),
          // ),

          // // Admin Users create page
          // GoRoute(
          //   path: 'create',
          //   name: RouteNames.adminUsersCreate,
          //   builder: (context, state) => const AdminUsersCreatePage(),
          // ),

          // // Admin Users edit page
          // GoRoute(
          //   path: 'edit/:userId',
          //   name: RouteNames.adminUsersEdit,
          //   builder: (context, state) => AdminUsersEditPage(
          //     userId: state.pathParameters['userId']!,
          //   ),
          // ),
        ],
      ),
    ],
  );
}
