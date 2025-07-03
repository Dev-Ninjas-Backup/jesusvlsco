import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/core/controllers/app_controller.dart';
import 'package:jesusvlsco/routes/routing.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the AppController instance
    final AppController appController = Get.find<AppController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
        actions: [
          // Theme toggle button using GetX
          Obx(
            () => IconButton(
              icon: Icon(
                appController.isDarkMode.value
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () => appController.toggleTheme(),
            ),
          ),

          // Notification badge using GetX
          Obx(
            () => Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () =>
                      context.goNamed(RouteNames.homeNotifications),
                ),
                if (appController.notificationCount.value > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        '${appController.notificationCount.value}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome message using GetX state
            Obx(
              () => Text(
                'Welcome, ${appController.userDisplayName}!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Login/Logout button using GetX
            Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (appController.isLoggedIn) {
                    appController.logoutUser();
                  } else {
                    _showLoginDialog(context, appController);
                  }
                },
                child: Text(appController.isLoggedIn ? 'Logout' : 'Login'),
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              'Navigate to sub-pages:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Navigation Cards
            Card(
              child: ListTile(
                leading: const Icon(Icons.info, color: Colors.blue),
                title: const Text('Home Details'),
                subtitle: const Text('View detailed information'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => context.goNamed(RouteNames.homeDetails),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.notifications, color: Colors.orange),
                title: const Text('Notifications'),
                subtitle: Obx(
                  () => Text(
                    'Check your ${appController.notificationCount.value} notifications',
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => context.goNamed(RouteNames.homeNotifications),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.favorite, color: Colors.red),
                title: const Text('Favorites'),
                subtitle: const Text('Manage your favorites'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => context.goNamed(RouteNames.homeFavorites),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLoginDialog(BuildContext context, AppController controller) {
    final TextEditingController usernameController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Login'),
        content: TextField(
          controller: usernameController,
          decoration: const InputDecoration(
            labelText: 'Username',
            hintText: 'Enter your username',
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () {
                      if (usernameController.text.isNotEmpty) {
                        controller.loginUser(usernameController.text);
                        Get.back();
                      }
                    },
              child: controller.isLoading.value
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}
