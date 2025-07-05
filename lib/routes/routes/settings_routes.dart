// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import '../../features/test/settings_account_page.dart';
// import '../../features/test/settings_page.dart';
// import '../../features/test/settings_preferences_page.dart';
// import '../../features/test/settings_privacy_page.dart';
// import '../config/route_constants.dart';

// /// Settings section routes with all sub-routes
// ///
// /// This module handles all routes related to the settings section,
// /// including the main settings page and all its sub-pages.
// class SettingsRoutes {
//   SettingsRoutes._();

//   /// Settings section branch for the main shell
//   static final StatefulShellBranch branch = StatefulShellBranch(
//     navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'settings'),
//     routes: [
//       GoRoute(
//         path: RoutePaths.settings,
//         name: RouteNames.settings,
//         builder: (context, state) => const SettingsPage(),
//         routes: [
//           // Account settings page
//           GoRoute(
//             path: 'account',
//             name: RouteNames.settingsAccount,
//             builder: (context, state) => const SettingsAccountPage(),
//           ),

//           // Preferences settings page
//           GoRoute(
//             path: 'preferences',
//             name: RouteNames.settingsPreferences,
//             builder: (context, state) => const SettingsPreferencesPage(),
//           ),

//           // Privacy settings page
//           GoRoute(
//             path: 'privacy',
//             name: RouteNames.settingsPrivacy,
//             builder: (context, state) => const SettingsPrivacyPage(),
//           ),
//         ],
//       ),
//     ],
//   );
// }
