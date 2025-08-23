import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/routes/routes/chat_routes.dart';
import 'package:jesusvlsco/routes/routes/projects_routes.dart';
import 'package:jesusvlsco/routes/routes/schedule_routes.dart';
import 'package:jesusvlsco/routes/routes/users_screen.dart';

import '../../features/bottom_navigation/screen/user_bottom_navigation_scaffold.dart';
import 'home_routes.dart';

/// Main shell routes configuration
///
/// This module handles the main application shell with bottom navigation
/// and combines all feature-specific route branches.
class MainShellRoutes {
  MainShellRoutes._();

  /// Main application shell with bottom navigation
  static final StatefulShellRoute shell = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return UserBottomNavigationScaffold();
    },
    branches: [
      // Home section branch
      HomeRoutes.branch,
      // Home section branch
      ChatRoutes.branch,
      // Home section branch
      UsersRoutes.branch,
      // Home section branch
      ScheduleRoutes.branch,
      // Home section branch
      ProjectsRoutes.branch,

      // // Settings section branch
      // SettingsRoutes.branch,

      // // Profile section branch
      // ProfileRoutes.branch,
    ],
  );
}
