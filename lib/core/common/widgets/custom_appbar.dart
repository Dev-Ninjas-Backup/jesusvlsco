// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/dashboard/admin_dashboard/widgets/dashboard_drawer.dart';

PreferredSizeWidget Custom_appbar({required String title}) {

  return AppBar(
    shadowColor: Colors.white,
    backgroundColor: Colors.white,
    elevation: 4,
    leading: IconButton(
      icon: Icon(
        CupertinoIcons.arrow_left,
        color: AppColors.backgroundDark,
        size: Sizer.wp(24),
      ),
      onPressed: () {
        Get.back();
      },
    ),
    title: Text(
      title,
      style: TextStyle(
        fontSize: Sizer.wp(20),
        color: AppColors.primary,
        fontWeight: FontWeight.w700,
      ),
    ),
    centerTitle: true,
    actions: [
      IconButton(
        icon: Icon(
          CupertinoIcons.bars,
          color: AppColors.backgroundDark,
          size: Sizer.wp(24),
        ),
        onPressed: () {
          Get.to(CustomDrawer());
        },
      ),
    ],
  );
}
