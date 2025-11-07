import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/features/auth/controller/login_controller.dart';
import 'package:jesusvlsco/routes/app_router.dart';

/// Authentication guard for protecting routes
class AuthGuard {
  AuthGuard._();

  /// Mock authentication state - replace with your actual auth logic
  static bool get _isAuthenticated {
    // Example: return AuthService.instance.isLoggedIn;
    bool isAuthenticated = Get.find<LoginController>().isLoading.value; // Example check
    // For demo purposes
    return isAuthenticated;
  }

  /// Mock user onboarding state
  static bool get _hasCompletedOnboarding {
    // Example: return UserPreferences.hasCompletedOnboarding;
    return true; // For demo purposes
  }

  /// Redirect logic for authentication
  static String? redirect(BuildContext context, GoRouterState state) {
    final isAuthRoute = _isAuthenticationRoute(state.matchedLocation);
    final isOnboardingRoute = _isOnboardingRoute(state.matchedLocation);

    // Allow access to splash screen always
    if (state.matchedLocation == '/') {
      return null;
    }

    // If user is not authenticated and trying to access protected routes
    if (!_isAuthenticated && !isAuthRoute) {
      return '/login';
    }

    // If user is authenticated but hasn't completed onboarding
    if (_isAuthenticated && !_hasCompletedOnboarding && !isOnboardingRoute) {
      return '/onboarding';
    }

    // If user is authenticated and trying to access auth routes, redirect to home
    if (_isAuthenticated && isAuthRoute) {
      // Dynamic redirect based on current mode
      return AppRouter.isTestingAdmin ? '/admin/home' : '/home';
    }

    return null; // No redirect needed
  }

  /// Check if current route is an authentication route
  static bool _isAuthenticationRoute(String location) {
    const authRoutes = ['/login', '/register', '/forgot-password'];
    return authRoutes.contains(location);
  }

  /// Check if current route is an onboarding route
  static bool _isOnboardingRoute(String location) {
    const onboardingRoutes = ['/onboarding'];
    return onboardingRoutes.contains(location);
  }

  /// Check if user can access a specific route
  static bool canAccess(String routeName) {
    // Add custom access control logic here
    switch (routeName) {
      case 'admin':
        return _isAuthenticated && _hasAdminRole();
      case 'premium':
        return _isAuthenticated && _hasPremiumAccess();
      default:
        return _isAuthenticated;
    }
  }

  /// Mock admin role check
  static bool _hasAdminRole() {
    return false;
  }

  /// Mock premium access check
  static bool _hasPremiumAccess() {
    return false;
  }

  /// Show access denied dialog
  static void showAccessDenied(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Access Denied'),
        content: const Text(
          'You do not have permission to access this feature.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
