import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_users_controller.dart';

class UserUserInfoController extends GetxController {
  final Rxn<UserModel> user = Rxn<UserModel>();

  void init(UserModel? u) {
    if (u != null) {
      user.value = u;
    } else if (Get.arguments != null && Get.arguments is UserModel) {
      user.value = Get.arguments as UserModel;
    }
  }

  void chat() {
    final u = user.value;
    if (u == null) return;
    debugPrint('Open chat with ${u.name}');
  }

  void email() {
    final u = user.value;
    if (u == null) return;
    debugPrint('Compose email to ${u.name}');
  }

  void call() {
    final u = user.value;
    if (u == null) return;
    debugPrint('Call ${u.name}');
  }
}
