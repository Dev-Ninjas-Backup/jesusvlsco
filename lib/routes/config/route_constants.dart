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
  static const String drawer = '/drawer';
  static const String chat = '/chat';
  static const String users = '/users';
  static const String schedule = '/schedule';
  static const String projects = '/projects';
  static const String settings = '/settings';
  static const String profile = '/profile';

  // Schedule section paths
  static const String timeSheet = '/schedule/timesheet';
  static const String addProject = '/schedule/add-project';
  static const String accessSchedule = '/schedule/access-schedule';

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

  // ADMIN ROUTES
  // Admin main shell paths
  static const String adminHome = '/admin/home';
  static const String adminDrawer = '/admin/drawer';
  static const String adminChat = '/admin/chat';
  static const String adminUsers = '/admin/users';
  static const String adminSchedule = '/admin/schedule';
  static const String adminProjects = '/admin/projects';
  static const String adminSettings = '/admin/settings';
  static const String adminProfile = '/admin/profile';

  // Admin Home section paths
  static const String adminHomeDetails = '/admin/home/details';
  static const String adminHomeNotifications = '/admin/home/notifications';
  static const String adminHomeAnalytics = '/admin/home/analytics';
  static const String adminHomeDashboard = '/admin/home/dashboard';

  // Admin Users management paths
  static const String adminUsersDetails = '/admin/users/details';
  static const String adminUsersCreate = '/admin/users/create';
  static const String adminUsersEdit = '/admin/users/edit';
  static const String adminUsersManage = '/admin/users/manage';

  // Admin Schedule management paths
  static const String adminScheduleDetails = '/admin/schedule/details';
  static const String adminScheduleCreate = '/admin/schedule/create';
  static const String adminScheduleManage = '/admin/schedule/manage';
  static const String adminAccessSchedule = '/admin/schedule/access-schedule';
  static const String adminAssignEmployee = '/admin/schedule/assign-employee';
  static const String adminAddProject = '/admin/schedule/add-project';

  // Admin Projects management paths
  static const String adminProjectsDetails = '/admin/projects/details';
  static const String adminProjectsCreate = '/admin/projects/create';
  static const String adminProjectsManage = '/admin/projects/manage';

  // Admin Chat management paths
  static const String adminChatDetails = '/admin/chat/details';
  static const String adminChatSettings = '/admin/chat/settings';
  static const String adminChatModeration = '/admin/chat/moderation';

  // Admin Settings section paths
  static const String adminSettingsAccount = '/admin/settings/account';
  static const String adminSettingsPreferences = '/admin/settings/preferences';
  static const String adminSettingsPrivacy = '/admin/settings/privacy';
  static const String adminSettingsSystem = '/admin/settings/system';

  // Admin Profile section paths
  static const String adminProfileEdit = '/admin/profile/edit';
  static const String adminProfileSecurity = '/admin/profile/security';
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

  // Schedule section route names
  static const String timeSheet = 'timesheet';
  static const String addProject = 'add-project';
  static const String accessSchedule = 'access-schedule';

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

  //for dashbaord drawer
  static const String drawer = 'drawer';

  // ADMIN ROUTE NAMES
  // Admin dashboard route names
  static const String admindashboard = 'admin-dashboard';

  // Admin main shell route names
  static const String adminHome = 'admin-home';
  static const String adminChat = 'admin-chat';
  static const String adminUsers = 'admin-users';
  static const String adminSchedule = 'admin-schedule';
  static const String adminProjects = 'admin-projects';
  static const String adminSettings = 'admin-settings';
  static const String adminProfile = 'admin-profile';

  // Admin Home section route names
  static const String adminHomeDetails = 'admin-home-details';
  static const String adminHomeNotifications = 'admin-home-notifications';
  static const String adminHomeAnalytics = 'admin-home-analytics';
  static const String adminHomeDashboard = 'admin-home-dashboard';

  // Admin Users management route names
  static const String adminUsersDetails = 'admin-users-details';
  static const String adminUsersCreate = 'admin-users-create';
  static const String adminUsersEdit = 'admin-users-edit';
  static const String adminUsersManage = 'admin-users-manage';

  // Admin Schedule management route names
  static const String adminScheduleDetails = 'admin-schedule-details';
  static const String adminScheduleCreate = 'admin-schedule-create';
  static const String adminScheduleManage = 'admin-schedule-manage';
  static const String adminAccessSchedule = 'admin-schedule-access-schedule';
  static const String adminAssignEmployee = 'admin-schedule-assign-employee';
  static const String adminAddProject = 'admin-schedule-add-project';

  // Admin Projects management route names
  static const String adminProjectsDetails = 'admin-projects-details';
  static const String adminProjectsCreate = 'admin-projects-create';
  static const String adminProjectsManage = 'admin-projects-manage';

  // Admin Chat management route names
  static const String adminChatDetails = 'admin-chat-details';
  static const String adminChatSettings = 'admin-chat-settings';
  static const String adminChatModeration = 'admin-chat-moderation';

  // Admin Settings section route names
  static const String adminSettingsAccount = 'admin-settings-account';
  static const String adminSettingsPreferences = 'admin-settings-preferences';
  static const String adminSettingsPrivacy = 'admin-settings-privacy';
  static const String adminSettingsSystem = 'admin-settings-system';

  // Admin Profile section route names
  static const String adminProfileEdit = 'admin-profile-edit';
  static const String adminProfileSecurity = 'admin-profile-security';

  // for admin dashboard drawer
  static const String adminDrawer = 'admin-drawer';
}
