import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'config/router_config.dart' as app_config;
import 'guards/auth_guard.dart';
import 'routes/auth_routes.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  static const bool isTestingAdmin = true;
  static GoRouter get router => _router;
  static GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;
  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: app_config.RouterConfig.initialRoute,
    debugLogDiagnostics: app_config.RouterConfig.debugMode,

    redirect: (context, state) => AuthGuard.redirect(context, state),

    errorBuilder: (context, state) =>
        app_config.RouterConfig.errorPage(state.error),

    routes: [
      ...AuthRoutes.routes,

      // if (isTestingAdmin) AdminShellRoutes.shell else MainShellRoutes.shell,
      // ...DrawerRoutes.routes,
    ],
  );
}
