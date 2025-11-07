import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/features/settings/screens/admin_time_clock2/widget/second_date_picker/second_date_picker_controller.dart';

class SecondDatepicker extends StatelessWidget {
  final SecondDatePickerController controller = Get.put(
    SecondDatePickerController(),
  );

  SecondDatepicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final String formattedDate = DateFormat(
        'dd/MM',
      ).format(controller.selectedDate.value);

      return Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 10),
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_month_outlined, color: AppColors.primary),
                SizedBox(width: 10),
                Container(
                  height: 30,
                  width: 1,
                  decoration: BoxDecoration(color: AppColors.primary),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () => controller.pickDate(context),
                  child: const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 30,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
