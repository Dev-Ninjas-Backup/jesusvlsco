import 'package:get/get.dart';
import 'package:jesusvlsco/core/controllers/app_controller.dart';
import 'package:jesusvlsco/features/auth/controller/login_controller.dart';
import 'package:jesusvlsco/features/bottom_navigation/controller/admin_bottom_navigation_scaffold_controller.dart';
import 'package:jesusvlsco/features/bottom_navigation/controller/bottom_navigation_scaffold_controller.dart';
import 'package:jesusvlsco/features/communication/controllers/private_chat_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(AppController(), permanent: true);
    Get.put(LoginController());
    Get.put(AdminBottomNavigationController());
    Get.put(BottomNavigationController());

    // Initialize communication controllers
    Get.lazyPut<PrivateChatController>(
      () => PrivateChatController(),
      fenix: true,
    );
  }
}
