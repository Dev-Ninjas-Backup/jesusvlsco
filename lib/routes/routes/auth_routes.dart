import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/features/auth/screen/Phone_verifymethod.dart';
import 'package:jesusvlsco/features/auth/screen/email_otpverfication.dart';
import 'package:jesusvlsco/features/auth/screen/email_verifymethod.dart';
import 'package:jesusvlsco/features/auth/screen/login_screen.dart';
import 'package:jesusvlsco/features/auth/screen/phone_otpverify.dart';
import 'package:jesusvlsco/features/auth/screen/verification_complete.dart';
import 'package:jesusvlsco/features/auth/screen/verify_method.dart';

import '../../features/splasho_screen/screen/splasho_screen.dart';
import '../config/route_constants.dart';
import '../config/router_config.dart' as app_router;

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
    // GoRoute(
    //   path: RoutePaths.login,
    //   name: RouteNames.login,
    //   pageBuilder: (context, state) => CustomTransitionPage<void>(
    //     key: state.pageKey,
    //     child: const LoginScreen(),
    //     transitionsBuilder: app_router.RouterConfig.fadeTransition,
    //   ),
    // ),

    // Register screen (placeholder)
    GoRoute(
      path: RoutePaths.register,
      name: RouteNames.register,
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const RegisterScreen(),
        transitionsBuilder: app_router.RouterConfig.slideTransition,
      ),
    ),

    //Authentication Routes
    //Verify Method
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
    GoRoute(
      path: RoutePaths.loginphoneotp,
      name: RouteNames.loginphoneotp,
      builder: (context, state) {
        return const Phoneotpverify();
      },
    ),

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

    // Forgot password screen (placeholder)
    // GoRoute(
    //   path: RoutePaths.forgotPassword,
    //   name: RouteNames.forgotPassword,
    //   builder: (context, state) => const ForgotPasswordScreen(),
    // ),

    // Onboarding screen (placeholder)
    // GoRoute(
    //   path: RoutePaths.onboarding,
    //   name: RouteNames.onboarding,
    //   builder: (context, state) => const OnboardingScreen(),
    // ),
  ];
}

/// Login Screen Widget
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//         automaticallyImplyLeading: false,
//       ),
//       body: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.login, size: 64),
//             SizedBox(height: 16),
//             Text(
//               'Login Screen',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text('Implement your login UI here'),
//           ],
//         ),
//       ),
//     );
//   }
// }

/// Register Screen Widget (Placeholder)
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_add, size: 64),
            SizedBox(height: 16),
            Text(
              'Register Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Implement your registration UI here'),
          ],
        ),
      ),
    );
  }
}

/// Forgot Password Screen Widget (Placeholder)
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_reset, size: 64),
            SizedBox(height: 16),
            Text(
              'Forgot Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Implement password reset UI here'),
          ],
        ),
      ),
    );
  }
}

/// Onboarding Screen Widget (Placeholder)
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 64),
            SizedBox(height: 16),
            Text(
              'Welcome!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Implement your onboarding flow here'),
          ],
        ),
      ),
    );
  }
}
