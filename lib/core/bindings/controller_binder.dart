import 'package:get/get.dart';
import 'package:jesusvlsco/core/controllers/app_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // Put the main app controller
    Get.put<AppController>(AppController(), permanent: true);

    // Lazy put other controllers (they will be created when first accessed)
    // Get.lazyPut<LogInController>(
    //   () => LogInController(),
    //   fenix: true,
    // );

    // You can add more controllers here as needed
    // Get.lazyPut<HomeController>(() => HomeController());
    // Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
