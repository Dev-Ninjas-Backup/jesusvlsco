import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/features/time&clock/controller/date_pick_controller.dart';
import 'package:jesusvlsco/features/time&clock/widget/custom_time_button.dart';
import 'package:jesusvlsco/features/time&clock/widget/date_picker_container.dart';
import 'package:jesusvlsco/features/time&clock/widget/time_counter.dart';

class TimeSheetScreen extends StatelessWidget {
  const TimeSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Time Period:'),
                SizedBox(width: 10),
                DatePickerContainer(),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.all(8),
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Text(
                            '1',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Text(
                          'Pending Req.',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            CustomTimeCounter(),
          ],
        ),
      ),
    );
  }
}
