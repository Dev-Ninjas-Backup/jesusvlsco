import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/features/user/controller/action_button_controller.dart';

class ActionButtonsRow extends StatelessWidget {
  
  ActionButtonsRow({super.key});

  final ActionButtonsController controller = Get.put(ActionButtonsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: List.generate(controller.buttons.length, (index) {
          final isSelected = controller.selectedIndex.value == index;
          final data = controller.buttons[index];
          return Padding(
            padding: index == 3 ? EdgeInsets.zero : const EdgeInsets.only(right: 12.0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: isSelected ? AppColors.primary : Colors.white,
                foregroundColor: isSelected ? Colors.white : AppColors.primary,
                side: BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () => controller.selectButton(index),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // center content
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(data.icon, size: 18),
                  if (data.label.isNotEmpty) ...[
                    const SizedBox(width: 6),
                    Flexible(
                      // ensures text doesn't overflow
                      child: Text(
                        data.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                  if (data.hasDropdown) ...[
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_drop_down, size: 18),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ButtonData {
  final IconData icon;
  final String label;
  final bool hasDropdown;

  ButtonData({
    required this.icon,
    required this.label,
    this.hasDropdown = false,
  });
}
