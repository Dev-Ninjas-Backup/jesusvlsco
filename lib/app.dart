import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/bindings/controller_binder.dart';
import 'package:jesusvlsco/routes/routing.dart';

import 'core/utils/theme/theme.dart';

class Jesusvlsco extends StatelessWidget {
  const Jesusvlsco({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jesus VLSCO',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialBinding: ControllerBinder(),

      // GetX specific configurations
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
      enableLog: true,

      // Use GoRouter with GetX
      home: Router.withConfig(config: AppRouter.router),

      // Alternative: You can also use this approach
      // builder: (context, child) {
      //   return Router.withConfig(config: AppRouter.router);
      // },
      logWriterCallback: (String text, {bool isError = false}) {
        // Custom logging for GetX (optional)
        if (isError) {
          print('GetX Error: $text');
        } else {
          print('GetX Log: $text');
        }
      },
    );
  }
}
