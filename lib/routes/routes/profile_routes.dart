// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import '../../features/test/profile_page.dart';
// import '../config/route_constants.dart';

// /// Profile section routes
// ///
// /// This module handles all routes related to the profile section,
// /// including the main profile page and future sub-pages.
// class ProfileRoutes {
//   ProfileRoutes._();

//   /// Profile section branch for the main shell
//   static final StatefulShellBranch branch = StatefulShellBranch(
//     navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'profile'),
//     routes: [
//       GoRoute(
//         path: RoutePaths.profile,
//         name: RouteNames.profile,
//         builder: (context, state) => const ProfilePage(),
//         routes: [
//           // Future profile sub-routes can be added here
//           // Example:
//           // GoRoute(
//           //   path: 'edit',
//           //   name: RouteNames.profileEdit,
//           //   builder: (context, state) => const ProfileEditPage(),
//           // ),
//           // GoRoute(
//           //   path: 'security',
//           //   name: RouteNames.profileSecurity,
//           //   builder: (context, state) => const ProfileSecurityPage(),
//           // ),
//         ],
//       ),
//     ],
//   );
// }
