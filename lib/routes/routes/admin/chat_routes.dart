import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/features/bottom_navigation/controller/admin_bottom_navigation_scaffold_controller.dart';

import '../../config/route_constants.dart';

/// Admin Chat section routes with all sub-routes
///
/// This module handles all routes related to the admin chat section,
/// including the main admin chat page and all its sub-pages.
class AdminChatRoutes {
  AdminChatRoutes._();

  /// Admin Chat section branch for the main shell
  static final StatefulShellBranch branch = StatefulShellBranch(
    navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'admin_chat'),
    routes: [
      GoRoute(
        path: RoutePaths.adminChat,
        name: RouteNames.adminChat,
        builder: (context, state) => const AdminChatScreen(),
        routes: [
          // Admin Chat details page
          // GoRoute(
          //   path: 'details',
          //   name: RouteNames.adminChatDetails,
          //   builder: (context, state) => const AdminChatDetailsPage(),
          // ),

          // // Admin Chat settings page
          // GoRoute(
          //   path: 'settings',
          //   name: RouteNames.adminChatSettings,
          //   builder: (context, state) => const AdminChatSettingsPage(),
          // ),

          // // Admin Chat moderation page
          // GoRoute(
          //   path: 'moderation',
          //   name: RouteNames.adminChatModeration,
          //   builder: (context, state) => const AdminChatModerationPage(),
          // ),
        ],
      ),
    ],
  );
}
