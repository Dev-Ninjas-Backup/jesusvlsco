/// Route path constants
///
/// This file contains all route paths used throughout the application.
/// Organized by feature/section for better maintainability.
class RoutePaths {
  RoutePaths._();

  // Root and authentication paths
  static const String root = '/';
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String onboarding = '/onboarding';


//Auth Routes

//For phone
  static const String verifyMethod = '/verify-method';
  static const String loginwithphone = '/loginwithphone';
  static const String loginphoneotp = '/loginphoneotp';
  static const String verifycomplete = '/verifycomplete';

//For email

  static const String loginwithemail = '/loginwithemail';
  static const String loginemailotp = '/loginemailotp';




  // Main shell paths
  static const String home = '/home';
  static const String chat = '/chat';
  static const String users = '/users';
  static const String schedule = '/schedule';
  static const String projects = '/projects';
  static const String settings = '/settings';
  static const String profile = '/profile';

  // Home section paths
  static const String homeDetails = '/home/details';
  static const String homeNotifications = '/home/notifications';
  static const String homeFavorites = '/home/favorites';

  // Settings section paths
  static const String settingsAccount = '/settings/account';
  static const String settingsPreferences = '/settings/preferences';
  static const String settingsPrivacy = '/settings/privacy';

  // Profile section paths (for future expansion)
  static const String profileEdit = '/profile/edit';
  static const String profileSecurity = '/profile/security';
}

/// Route name constants
///
/// This file contains all route names used for navigation.
/// Names should be descriptive and follow kebab-case convention.
class RouteNames {
  RouteNames._();

  // Authentication route names
  static const String splash = 'splash';
  static const String login = 'login';
  static const String register = 'register';
  static const String forgotPassword = 'forgot-password';
  static const String onboarding = 'onboarding';
  static const String verifyMethod = 'verify-method';
  static const String loginwithphone = 'loginwithphone';
  static const String loginphoneotp = 'loginphoneotp';
  static const String verifycomplete = 'verifycomplete';
  static const String loginwithemail = 'loginwithemail';
  static const String loginemailotp = 'loginemailotp';
 

 //users route names
   static const String userdashboard = 'userdashboard';



  // Main shell route names
  static const String home = 'home';
  static const String chat = 'chat';
  static const String users = 'users';
  static const String schedule = 'schedule';
  static const String projects = 'projects';
  static const String settings = 'settings';
  static const String profile = 'profile';

  // Home section route names
  static const String homeDetails = 'home-details';
  static const String homeNotifications = 'home-notifications';
  static const String homeFavorites = 'home-favorites';

  // Settings section route names
  static const String settingsAccount = 'settings-account';
  static const String settingsPreferences = 'settings-preferences';
  static const String settingsPrivacy = 'settings-privacy';

  // Profile section route names (for future expansion)
  static const String profileEdit = 'profile-edit';
  static const String profileSecurity = 'profile-security';





  
}
