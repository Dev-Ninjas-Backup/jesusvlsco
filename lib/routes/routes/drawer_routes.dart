import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/features/dashboard/admin_dashboard/widgets/dashboard_drawer.dart';
import 'package:jesusvlsco/routes/config/route_constants.dart';

class DrawerRoutes {
  DrawerRoutes._();

  static final List<RouteBase> routes = [
    GoRoute(
      path: RoutePaths.drawer,
      name: RouteNames.drawer,
      builder: (context, state) => const CustomDrawer(),
    ),
  ];
}
