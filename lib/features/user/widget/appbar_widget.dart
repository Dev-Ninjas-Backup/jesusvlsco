import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget buildAppBar() {
  return AppBar(
    backgroundColor: const Color(0xFFF8F9FA),
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () => Get.back(),
    ),
    title: const Text(
      'Add user',
      style: TextStyle(
        color: Color(0xFF6366F1),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    centerTitle: true,
  );
}
