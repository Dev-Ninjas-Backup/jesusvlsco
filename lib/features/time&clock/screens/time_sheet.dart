import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/core/common/widgets/custom_button.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/communication/widgets/common_button.dart';
import 'package:jesusvlsco/features/time&clock/controller/date_pick_controller.dart';
import 'package:jesusvlsco/features/time&clock/widget/custom_time_button.dart';

class TimeSheetScreen extends StatelessWidget {
  const TimeSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TimeSheetController());

    return Scaffold(
      appBar: Custom_appbar(title: "Time Sheet"),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30.0,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTimeButton(
                    height: 40,
                    text: 'Timesheet',
                    textcolor: Colors.white,
                    brColor: Color(0xFF4A55A2),
                    bgColor: Color(0xFF4A55A2),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomTimeButton(
                    height: 40,
                    text: 'Payroll',
                    textcolor: Color(0xFF4A55A2),
                    brColor: Color(0xFF4A55A2),
                  ),
                ),
              ],
            ),
            Row(children: [Text('Time Period')]),
            SizedBox(height: 10),

            /// 👇 DATE PICKER ROW
            Obx(
              () => GestureDetector(
                onTap: () => controller.pickDate(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
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
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
