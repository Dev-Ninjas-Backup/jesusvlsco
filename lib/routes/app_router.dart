/// Application router configuration
/// This is the main entry point for all routing in the application
library app_router;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'config/router_config.dart' as app_config;
import 'guards/auth_guard.dart';
import 'routes/auth_routes.dart';
import 'routes/main_shell_routes.dart';

/// Main application router
///
/// This class provides the centralized router configuration for the entire app.
/// It combines authentication routes and main shell routes with proper guards.
class AppRouter {
  AppRouter._();

  /// Global navigator key for root navigation
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  /// Main GoRouter instance
  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: app_config.RouterConfig.initialRoute,
    debugLogDiagnostics: app_config.RouterConfig.debugMode,

    // Global redirect logic
    redirect: (context, state) => AuthGuard.redirect(context, state),

    // Error handling
    errorBuilder: (context, state) =>
        app_config.RouterConfig.errorPage(state.error),

    routes: [
      // Authentication routes (splash, login, register, etc.)
      ...AuthRoutes.routes,

      // Main application shell with bottom navigation
      MainShellRoutes.shell,
    ],
  );

  /// Provides access to the router instance
  static GoRouter get router => _router;

  /// Get the root navigator key
  static GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;
}
