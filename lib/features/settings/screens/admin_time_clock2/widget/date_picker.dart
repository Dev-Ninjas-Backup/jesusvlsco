import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/date_pick_controller.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TimeSheetController());
    return Expanded(
      child: Obx(
        () => GestureDetector(
          onTap: () => controller.pickDate(context),
          child: Container(
            height: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    controller.selectedDate.value,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_outlined),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
