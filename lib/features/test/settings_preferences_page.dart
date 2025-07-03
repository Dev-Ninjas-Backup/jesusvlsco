import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsPreferencesPage extends StatefulWidget {
  const SettingsPreferencesPage({super.key});

  @override
  State<SettingsPreferencesPage> createState() =>
      _SettingsPreferencesPageState();
}

class _SettingsPreferencesPageState extends State<SettingsPreferencesPage> {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  bool _locationEnabled = false;
  String _selectedLanguage = 'English';
  double _fontSize = 16.0;

  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'App Preferences',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Dark Mode
          Card(
            child: SwitchListTile(
              title: const Text('Dark Mode'),
              subtitle: const Text('Enable dark theme'),
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              secondary: const Icon(Icons.dark_mode),
            ),
          ),

          // Notifications
          Card(
            child: SwitchListTile(
              title: const Text('Notifications'),
              subtitle: const Text('Enable push notifications'),
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              secondary: const Icon(Icons.notifications),
            ),
          ),

          // Location
          Card(
            child: SwitchListTile(
              title: const Text('Location Services'),
              subtitle: const Text('Allow location access'),
              value: _locationEnabled,
              onChanged: (value) {
                setState(() {
                  _locationEnabled = value;
                });
              },
              secondary: const Icon(Icons.location_on),
            ),
          ),

          const SizedBox(height: 16),

          // Language Selection
          Card(
            child: ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              subtitle: Text(_selectedLanguage),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Select Language'),
                    content: SizedBox(
                      width: double.maxFinite,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _languages.length,
                        itemBuilder: (context, index) {
                          return RadioListTile<String>(
                            title: Text(_languages[index]),
                            value: _languages[index],
                            groupValue: _selectedLanguage,
                            onChanged: (value) {
                              setState(() {
                                _selectedLanguage = value!;
                              });
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Font Size
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.text_fields),
                      const SizedBox(width: 16),
                      const Text('Font Size'),
                      const Spacer(),
                      Text('${_fontSize.round()}px'),
                    ],
                  ),
                  Slider(
                    value: _fontSize,
                    min: 12.0,
                    max: 24.0,
                    divisions: 12,
                    onChanged: (value) {
                      setState(() {
                        _fontSize = value;
                      });
                    },
                  ),
                  Text(
                    'Sample text at selected size',
                    style: TextStyle(fontSize: _fontSize),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
