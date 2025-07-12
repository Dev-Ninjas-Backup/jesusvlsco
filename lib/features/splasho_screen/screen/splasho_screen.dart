import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/routes/app_router.dart';

class SplashoScreen extends StatefulWidget {
  const SplashoScreen({super.key});

  @override
  State<SplashoScreen> createState() => _SplashoScreenState();
}

class _SplashoScreenState extends State<SplashoScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      // Navigate based on admin/user condition
      if (AppRouter.isTestingAdmin) {
        context.goNamed('admin-home'); // Navigate to admin home
      } else {
        context.goNamed('home'); // Navigate to user home
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Splasho Screen')));
  }
}
