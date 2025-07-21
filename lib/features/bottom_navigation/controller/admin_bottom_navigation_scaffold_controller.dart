import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/dashboard/admin_dashboard/screens/admin_dashboard_screen.dart';

class AdminBottomNavigationScaffoldController extends GetxController {
  final List<Widget> screens = [
    AdminDashboardScreen(),
    const AdminChatScreen(),
    const AdminUsersScreen(),
    const AdminScheduleScreen(),
    const AdminProjectsScreen(),
  ];
}

class AdminChatScreen extends StatelessWidget {
  const AdminChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Admin Chat Screen'));
  }
}

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Admin Users Management Screen'));
  }
}

class AdminScheduleScreen extends StatelessWidget {
  const AdminScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Admin Schedule Management Screen'));
  }
}

class AdminProjectsScreen extends StatelessWidget {
  const AdminProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Admin Projects Management Screen'));
  }
}
