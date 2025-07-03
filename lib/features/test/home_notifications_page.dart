import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeNotificationsPage extends StatelessWidget {
  const HomeNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('${index + 1}'),
              ),
              title: Text('Notification ${index + 1}'),
              subtitle: Text(
                'This is the description for notification ${index + 1}',
              ),
              trailing: const Icon(Icons.notifications),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped notification ${index + 1}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
