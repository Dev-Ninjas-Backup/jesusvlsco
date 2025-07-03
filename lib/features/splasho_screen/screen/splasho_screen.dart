import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      context.goNamed('home'); // Adjust the route as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Splasho Screen')));
  }
}
