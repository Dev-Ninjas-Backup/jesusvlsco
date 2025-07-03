import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/routes/routing.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings Page',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Configure your app settings:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Settings Categories
            Card(
              child: ListTile(
                leading: const Icon(Icons.account_circle, color: Colors.blue),
                title: const Text('Account Settings'),
                subtitle: const Text('Manage your account information'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => context.goNamed(RouteNames.settingsAccount),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.tune, color: Colors.green),
                title: const Text('Preferences'),
                subtitle: const Text('Customize app preferences'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => context.goNamed(RouteNames.settingsPreferences),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.security, color: Colors.orange),
                title: const Text('Privacy & Security'),
                subtitle: const Text('Privacy and security settings'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => context.goNamed(RouteNames.settingsPrivacy),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
