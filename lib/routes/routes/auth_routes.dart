import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/features/auth/screen/Phone_verifymethod.dart';
import 'package:jesusvlsco/features/auth/screen/email_otpverfication.dart';
import 'package:jesusvlsco/features/auth/screen/email_verifymethod.dart';
import 'package:jesusvlsco/features/auth/screen/login_screen.dart';
import 'package:jesusvlsco/features/auth/screen/verification_complete.dart';
import 'package:jesusvlsco/features/auth/screen/verify_method.dart';

import '../../features/splasho_screen/screen/splasho_screen.dart';
import '../config/route_constants.dart';

/// Authentication and onboarding routes
///
/// This module handles all routes related to user authentication,
/// including splash, login, register, and onboarding screens.
class AuthRoutes {
  AuthRoutes._();

  /// List of authentication routes
  static final List<RouteBase> routes = [
    // Splash screen
    GoRoute(
      path: RoutePaths.splash,
      name: RouteNames.splash,
      builder: (context, state) => const SplashoScreen(),
    ),

    // Login screen
    GoRoute(
      path: RoutePaths.login,
      name: RouteNames.login,
      builder: (context, state) {
        return const LoginScreen();
      },
    ),

    GoRoute(
      path: RoutePaths.verifyMethod,
      name: RouteNames.verifyMethod,
      builder: (context, state) {
        return const VerifyMethodScreen();
      },
    ),

    // Login with Phone Method
    GoRoute(
      path: RoutePaths.loginwithphone,
      name: RouteNames.loginwithphone,
      builder: (context, state) {
        return const Phoneverifymethod();
      },
    ),

    //login with OTP
    // GoRoute(
    //   path: RoutePaths.loginphoneotp,
    //   name: RouteNames.loginphoneotp,
    //   builder: (context, state) {
    //     return  Phoneotpverify();
    //   },
    // ),

    //verification Complete
    GoRoute(
      path: RoutePaths.verifycomplete,
      name: RouteNames.verifycomplete,
      builder: (context, state) {
        return const VerificationComplete();
      },
    ),

    //Email Verify method
    GoRoute(
      path: RoutePaths.loginwithemail,
      name: RouteNames.loginwithemail,
      builder: (context, state) {
        return const EmailotpverifyMethod();
      },
    ),

    //Email OTP Verify
    GoRoute(
      path: RoutePaths.loginemailotp,
      name: RouteNames.loginemailotp,
      builder: (context, state) {
        return const EmailOtpverfication();
      },
    ),
  ];
}
