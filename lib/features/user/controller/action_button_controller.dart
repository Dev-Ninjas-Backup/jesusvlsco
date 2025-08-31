import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/user/screen/add_user_screen.dart';
import 'package:jesusvlsco/features/user/widget/action_button_row.dart';
import 'package:jesusvlsco/features/user/widget/employee_list_filter_dialog.dart';

class ActionButtonsController extends GetxController {
  var selectedIndex = 0.obs;

  final List<ButtonData> buttons = [
    ButtonData(icon: Icons.add, label: "Add"),
    ButtonData(icon: Icons.filter_list, label: "Filter"),
    ButtonData(icon: Icons.calendar_today, label: "Date", hasDropdown: true),
    ButtonData(icon: Icons.more_vert, label: ""),
  ];

  void selectButton(int index) {
    selectedIndex.value = index;

    switch (index) {
      case 0:
        Get.to(AddUserScreen());
        break;
      case 1:
        Get.dialog(
          const EmployeeListFilterDialog(),
          barrierDismissible: true, // tap outside to close
        );
        // Get.snackbar(
        //   'Action',
        //   'Filter button pressed',
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: const Color(0xFF6366F1),
        //   colorText: Colors.white,
        //   duration: const Duration(seconds: 2),
        // );
        break;
      case 2:
        Get.snackbar(
          'Action',
          'Date button pressed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF6366F1),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        break;
      case 3:
        Get.snackbar(
          'Action',
          'More options button pressed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF6366F1),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        break;
    }
  }
}
