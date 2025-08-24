import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/features/bottom_navigation/screen/admin_bottom_navigation_scaffold.dart';
import 'package:jesusvlsco/routes/routes/admin/home_routes.dart';
import 'package:jesusvlsco/routes/routes/admin/chat_routes.dart';
import 'package:jesusvlsco/routes/routes/admin/users_screen.dart';
import 'package:jesusvlsco/routes/routes/admin/schedule_routes.dart';
import 'package:jesusvlsco/routes/routes/admin/projects_routes.dart';

/// Admin shell routes configuration
class AdminShellRoutes {
  AdminShellRoutes._();

  /// Admin application shell with bottom navigation
  static final StatefulShellRoute shell = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return AdminBottomNavigationScaffold();
    },
    branches: [
      // Admin Home section branch
      AdminHomeRoutes.branch,
      // Admin Chat section branch
      AdminChatRoutes.branch,
      // Admin Users section branch
      AdminUsersRoutes.branch,
      // Admin Schedule section branch
      AdminScheduleRoutes.branch,
      // Admin Projects section branch
      AdminProjectsRoutes.branch,
    ],
  );
}
