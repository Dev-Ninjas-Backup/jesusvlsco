import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/features/auth/controller/login_controller.dart';
import 'package:jesusvlsco/routes/routing.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Login Screen'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement login logic here
                loginController.login();
                context.goNamed(
                  RouteNames.home,
                ); // Navigate to home after login
              },
              child: Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
