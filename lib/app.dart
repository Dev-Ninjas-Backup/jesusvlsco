import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/bindings/controller_binder.dart';
import 'package:jesusvlsco/core/utils/context/app_context.dart';
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

      localizationsDelegates: const [
        DefaultCupertinoLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],

      home: Router.withConfig(config: AppRouter.router),
    );
  }
}
