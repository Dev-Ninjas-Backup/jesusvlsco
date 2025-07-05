import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Router configuration constants and settings
class RouterConfig {
  RouterConfig._();

  /// Initial route when app starts
  static const String initialRoute = '/';

  /// Enable debug logging in debug mode
  static bool get debugMode => kDebugMode;

  /// Default error page builder
  static Widget errorPage(Exception? error) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error'), backgroundColor: Colors.red),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Oops! Something went wrong',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (kDebugMode && error != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // In a real app, you might want to navigate back or to home
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  /// Animation duration for route transitions
  static const Duration transitionDuration = Duration(milliseconds: 300);

  /// Default page transition builder
  static Widget slideTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
      child: child,
    );
  }

  /// Fade transition builder
  static Widget fadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}
