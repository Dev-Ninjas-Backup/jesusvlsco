import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/dashboard/admin_dashboard/screens/user_dashboard_screen.dart';

class BottomNavigationScaffoldController extends GetxController {
  final List<Widget> screens = [
    UserDashboardScreen(),
    const ChatScreen(),
    const UsersScreen(),
    const ScheduleScreen(),
    const ProjectsScreen(),
  ];
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: Text('Home Screen'));
//   }
// }

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Chat Screen'));
  }
}

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Users Screen'));
  }
}

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Schedule Screen'));
  }
}

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Projects Screen'));
  }
}
