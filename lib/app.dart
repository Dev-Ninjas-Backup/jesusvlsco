import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/bindings/controller_binder.dart';
import 'package:jesusvlsco/core/utils/context/app_context.dart';
import 'package:jesusvlsco/features/recognition/screens/create_bridge.dart';
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
      home: CreateBridge(),

      localizationsDelegates: const [
        DefaultCupertinoLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],

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
