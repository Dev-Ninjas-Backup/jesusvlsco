import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/features/user/screen/user_user_info_screen.dart';

// import '../../features/test/home_page.dart';
import '../config/route_constants.dart';

/// Home section routes with all sub-routes
///
/// This module handles all routes related to the home section,
/// including the main home page and all its sub-pages.
class UsersRoutes {
  UsersRoutes._();

  /// Home section branch for the main shell
  static final StatefulShellBranch branch = StatefulShellBranch(
    navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'users'),
    routes: [
      GoRoute(
        path: RoutePaths.users,
        name: RouteNames.users,
        // builder: (context, state) => const UsersScreen(),
        routes: [
          // User info/details page (opened as /users/info)
          GoRoute(
            path: 'info',
            name: 'user-info',
            builder: (context, state) {
              final extra = state.extra;
              return UserUserInfoScreen(userArg: extra);
            },
          ),
          // Users details page
          // GoRoute(
          //   path: 'details',
          //   name: RouteNames.homeDetails,
          //   builder: (context, state) => const HomeDetailsPage(),
          // ),

          // // Home notifications page
          // GoRoute(
          //   path: 'notifications',
          //   name: RouteNames.homeNotifications,
          //   builder: (context, state) => const HomeNotificationsPage(),
          // ),

          // // Home favorites page
          // GoRoute(
          //   path: 'favorites',
          //   name: RouteNames.homeFavorites,
          //   builder: (context, state) => const HomeFavoritesPage(),
          // ),
        ],
      ),
    ],
  );
}
