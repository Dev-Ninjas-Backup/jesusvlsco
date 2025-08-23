import 'package:flutter/material.dart';

class SidePopupOptions extends StatelessWidget {
  const SidePopupOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text('Option 1'),
            onTap: () {
              Navigator.pop(context);
              print('Option 1 selected');
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Option 2'),
            onTap: () {
              Navigator.pop(context);
              print('Option 2 selected');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Option 3'),
            onTap: () {
              Navigator.pop(context);
              print('Option 3 selected');
            },
          ),
        ],
      ),
    );
  }
}
