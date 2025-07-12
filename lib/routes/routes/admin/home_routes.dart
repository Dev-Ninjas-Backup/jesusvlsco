import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/features/dashboard/admin_dashboard/screens/admin_dashboard_screen.dart';

class AdminHomeRoutes {
  AdminHomeRoutes._();

  static final StatefulShellBranch branch = StatefulShellBranch(
    navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'admin_home'),
    routes: [
      GoRoute(
        path: '/admin/home', // Hardcode this
        name: 'admin-home', // Hardcode this
        builder: (context, state) {
          print('🏠 Admin Home Route: path = /admin/home');
          print('🏠 Admin Home Route: name = admin-home');
          return AdminDashboardScreen();
        },
      ),
    ],
  );
}
