import 'package:get/get.dart';

class LoginController extends GetxController {
  //
  bool isLoading = false;

  void login() {
    isLoading = true;
    update();
  }
}
