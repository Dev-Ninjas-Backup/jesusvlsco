import 'package:go_router/go_router.dart';

import '../../features/bottom_navigation/screen/bottom_navigation_scaffold.dart';
import 'home_routes.dart';
import 'profile_routes.dart';
import 'settings_routes.dart';

/// Main shell routes configuration
///
/// This module handles the main application shell with bottom navigation
/// and combines all feature-specific route branches.
class MainShellRoutes {
  MainShellRoutes._();

  /// Main application shell with bottom navigation
  static final StatefulShellRoute shell = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return BottomNavigationScaffold(navigationShell: navigationShell);
    },
    branches: [
      // Home section branch
      HomeRoutes.branch,

      // Settings section branch
      SettingsRoutes.branch,

      // Profile section branch
      ProfileRoutes.branch,
    ],
  );
}
