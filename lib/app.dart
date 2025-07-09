import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/bindings/controller_binder.dart';
import 'package:jesusvlsco/core/utils/context/app_context.dart';
import 'package:jesusvlsco/features/user/screens/add_announcement.dart';
import 'package:jesusvlsco/features/user/screens/announcement_dashboard.dart';
import 'core/utils/theme/theme.dart';

class Jesusvlsco extends StatelessWidget {
  const Jesusvlsco({super.key});

  @override
  Widget build(BuildContext context) {
    AppContext.init(context); // Initialize AppContext with the current context
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jesus VLSCO',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialBinding: ControllerBinder(),
      // GetX specific configurations
      // defaultTransition: Transition.cupertino,
      // transitionDuration: const Duration(milliseconds: 300),
      // enableLog: true,
      // Use GoRouter with GetX
      // home: Router.withConfig(config: AppRouter.router),
home: AnnouncementDashboard(),
      // Alternative: You can also use this approach
      // builder: (context, child) {
      //   return Router.withConfig(config: AppRouter.router);
      // },
      // logWriterCallback: (String text, {bool isError = false}) {
      //   // Custom logging for GetX (optional)
      //   if (isError) {
      //     print('GetX Error: $text');
      //   } else {
      //     print('GetX Log: $text');
      //   }
      // },
    );
  }
}
