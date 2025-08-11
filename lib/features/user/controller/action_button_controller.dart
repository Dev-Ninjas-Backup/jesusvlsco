import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/user/widget/action_button_row.dart';

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
  }
}
