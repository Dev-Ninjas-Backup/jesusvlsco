// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/recognition/controllers/badge_controller.dart';
import 'package:jesusvlsco/features/recognition/widgets/dashboard_card.dart';

class gridview_card extends StatelessWidget {
  const gridview_card({super.key});

  @override
  Widget build(BuildContext context) {
    final BadgeController badgeController = Get.put(BadgeController());
    return SizedBox(
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.95,
        ),
        itemCount: badgeController.items.length,
        itemBuilder: (context, index) {
          final item = badgeController.items[index];

          return GestureDetector(
            onTap: () {
              badgeController.selectedIndex(index); // Update selected badge
            },
            child: Obx(() {
              // Highlight selected item
              bool isSelected = badgeController.selectedIndex.value == index;
              return DashboardCard(item: item, isSelected: isSelected);
            }),
          );
        },
      ),
    );
  }
}
