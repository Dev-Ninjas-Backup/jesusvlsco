import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeIndex(int index) {
    if (currentIndex.value == index) return;
    currentIndex.value = index;
  }

  void resetToHome() {
    currentIndex.value = 0;
  }
}
