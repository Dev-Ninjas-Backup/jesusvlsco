import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jesusvlsco/core/bindings/controller_binder.dart';
import 'package:jesusvlsco/core/utils/context/app_context.dart';
import 'package:jesusvlsco/routes/app_router.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/routes/scheduling_routes.dart';

class Jesusvlsco extends StatelessWidget {
  const Jesusvlsco({super.key});

  @override
  Widget build(BuildContext context) {
    AppContext.init(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LGC Global',
      initialBinding: ControllerBinder(),
      getPages: SchedulingRoutes.pages,
      localizationsDelegates: const [
        DefaultCupertinoLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      builder: EasyLoading.init(),
      home: Router.withConfig(config: AppRouter.router),
    );
  }
}
