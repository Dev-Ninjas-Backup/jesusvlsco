import 'dart:ui';

import 'package:get/get.dart';
import 'package:jesusvlsco/features/recognition/widgets/dashboard_card.dart';

class BadgeController extends GetxController {
  // Track selected index as an RxInt
  RxInt selectedIndex = 0.obs;

  // Method to update the selected index
  void selectBadge(int index) {
    selectedIndex.value = index;
  }

  // List of items to be displayed
  final RxList<DashboardItem> items = <DashboardItem>[
    DashboardItem(
      icon: 'assets/icons/annouce.svg',
      title: 'Promotion',
      color: const Color(0xFF8B7CF6),
    ),
    DashboardItem(
      icon:  'assets/icons/likesanimate.svg',
      title: 'Well-Social',
      color: const Color(0xFFE0E7FF),
    ),
    DashboardItem(
      icon:  'assets/icons/creative.svg',
      title: 'Creative',
      color: const Color(0xFFFEF3C7),
    ),
    DashboardItem(
      icon:  'assets/icons/annouce.svg',
      title: 'Employee of\nthe month',
      color: const Color(0xFFDDD6FE),
    ),
    DashboardItem(
      icon:  'assets/icons/annouce.svg',
      title: 'Outstanding\nservices',
      color: const Color(0xFFFED7AA),
    ),
    DashboardItem(
      icon:  'assets/icons/annouce.svg',
      title: 'Top performer',
      color: const Color(0xFFFEF3C7),
    ),
    DashboardItem(
      icon:  'assets/icons/annouce.svg',
      title: 'Creative',
      color: const Color(0xFFFED7AA),
    ),
    DashboardItem(
      icon:  'assets/icons/annouce.svg',
      title: 'Happy Holiday',
      color: const Color(0xFFFFE4E6),
    ),
  ].obs; // RxList to make the list observable
}
