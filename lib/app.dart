import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/bindings/controller_binder.dart';
import 'package:jesusvlsco/core/utils/context/app_context.dart';
import 'package:jesusvlsco/features/communication/screens/chat_screen.dart';
import 'package:jesusvlsco/features/recognition/screens/create_bridge.dart';
import 'package:jesusvlsco/features/recognition/screens/send_recognition.dart';
import 'package:jesusvlsco/features/taskmanagement/screens/activity_log.dart';
import 'package:jesusvlsco/features/taskmanagement/screens/add_moredetails.dart';
import 'package:jesusvlsco/features/taskmanagement/screens/add_task.dart';
import 'package:jesusvlsco/features/taskmanagement/screens/overduetask.dart';
import 'package:jesusvlsco/features/taskmanagement/screens/task_commnets.dart';
import 'package:jesusvlsco/features/taskmanagement/screens/task_details.dart';
import 'package:jesusvlsco/features/taskmanagement/screens/taskmanagement_dashboard.dart';
import 'package:jesusvlsco/routes/app_router.dart';



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
      home: ChatScreen(),


      // home: Router.withConfig(config: AppRouter.router),
      // home: AnnouncementDashboard(),
      localizationsDelegates: const [
        DefaultCupertinoLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],

      home: Router.withConfig(config: AppRouter.router),
      // home: AnnouncementDashboard(),

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
