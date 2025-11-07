import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// import '../../features/test/home_page.dart';
import '../../features/user/screen/user_communication_screen.dart';
import '../config/route_constants.dart';

/// Home section routes with all sub-routes
///
/// This module handles all routes related to the home section,
/// including the main home page and all its sub-pages.
class ChatRoutes {
  ChatRoutes._();

  /// Home section branch for the main shell
  static final StatefulShellBranch branch = StatefulShellBranch(
    navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'chat'),
    routes: [
      GoRoute(
        path: RoutePaths.chat,
        name: RouteNames.chat,
        builder: (context, state) =>  UserCommunicationScreen(),
        routes: [
          // Chat details page
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
