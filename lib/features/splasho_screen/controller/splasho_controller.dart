import 'package:get/get.dart';
import 'package:jesusvlsco/features/auth/screen/login_screen.dart';
import 'package:jesusvlsco/features/bottom_navigation/screen/admin_bottom_navigation_scaffold.dart';
import 'package:jesusvlsco/features/bottom_navigation/screen/user_bottom_navigation_scaffold.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkUserAndNavigate();
  }

  void _checkUserAndNavigate() async {
    // Show splash for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    // Check if user is authenticated
    bool isAuthenticated = await _checkAuthentication();

    if (isAuthenticated) {
      // Check user role and navigate accordingly
      String userRole = await _getUserRole();

      if (userRole == 'admin') {
        Get.offAll(() => AdminBottomNavigationScaffold());
      } else {
        Get.offAll(() => const UserBottomNavigationScaffold());
      }
    } else {
      // Navigate to login
      Get.offAll(LoginScreen());
    }
  }

  Future<bool> _checkAuthentication() async {
    // TODO: Replace with actual authentication check
    // Example:
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString('auth_token');
    // return token != null && token.isNotEmpty;

    // For testing - return true to skip auth
    return true;
  }

  Future<String> _getUserRole() async {
    // TODO: Replace with actual role check
    // Example:
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // return prefs.getString('user_role') ?? 'user';

    // For testing - change this to test different roles
    return 'admin'; // Change to 'admin' to test admin flow
  }
}
