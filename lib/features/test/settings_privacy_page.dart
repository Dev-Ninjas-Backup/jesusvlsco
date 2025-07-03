import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsPrivacyPage extends StatefulWidget {
  const SettingsPrivacyPage({super.key});

  @override
  State<SettingsPrivacyPage> createState() => _SettingsPrivacyPageState();
}

class _SettingsPrivacyPageState extends State<SettingsPrivacyPage> {
  bool _dataCollection = true;
  bool _analytics = false;
  bool _crashReports = true;
  bool _locationTracking = false;
  bool _advertisingId = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Security'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Privacy Settings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Control how your data is collected and used',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),

          // Data Collection
          Card(
            child: SwitchListTile(
              title: const Text('Data Collection'),
              subtitle: const Text('Allow app to collect usage data'),
              value: _dataCollection,
              onChanged: (value) {
                setState(() {
                  _dataCollection = value;
                });
              },
              secondary: const Icon(Icons.data_usage),
            ),
          ),

          // Analytics
          Card(
            child: SwitchListTile(
              title: const Text('Analytics'),
              subtitle: const Text('Help improve the app with analytics'),
              value: _analytics,
              onChanged: (value) {
                setState(() {
                  _analytics = value;
                });
              },
              secondary: const Icon(Icons.analytics),
            ),
          ),

          // Crash Reports
          Card(
            child: SwitchListTile(
              title: const Text('Crash Reports'),
              subtitle: const Text('Send crash reports to help fix issues'),
              value: _crashReports,
              onChanged: (value) {
                setState(() {
                  _crashReports = value;
                });
              },
              secondary: const Icon(Icons.bug_report),
            ),
          ),

          // Location Tracking
          Card(
            child: SwitchListTile(
              title: const Text('Location Tracking'),
              subtitle: const Text('Track location for personalized content'),
              value: _locationTracking,
              onChanged: (value) {
                setState(() {
                  _locationTracking = value;
                });
              },
              secondary: const Icon(Icons.location_on),
            ),
          ),

          // Advertising ID
          Card(
            child: SwitchListTile(
              title: const Text('Advertising ID'),
              subtitle: const Text('Use advertising ID for personalized ads'),
              value: _advertisingId,
              onChanged: (value) {
                setState(() {
                  _advertisingId = value;
                });
              },
              secondary: const Icon(Icons.ads_click),
            ),
          ),

          const SizedBox(height: 24),

          // Privacy Policy & Terms
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.policy),
                  title: const Text('Privacy Policy'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Opening Privacy Policy...'),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('Terms of Service'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Opening Terms of Service...'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Delete Account
          Card(
            child: ListTile(
              leading: const Icon(Icons.delete_forever, color: Colors.red),
              title: const Text(
                'Delete Account',
                style: TextStyle(color: Colors.red),
              ),
              subtitle: const Text('Permanently delete your account and data'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Account'),
                    content: const Text(
                      'Are you sure you want to delete your account? This action cannot be undone.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Account deletion process would start here',
                              ),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
