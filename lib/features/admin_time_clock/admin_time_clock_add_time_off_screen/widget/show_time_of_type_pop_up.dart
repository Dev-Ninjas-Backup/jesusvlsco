import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_add_time_off_screen/controller/admin_time_clock_add_time_off_screen_controller.dart';

void showTimeOffTimePopUp (BuildContext context, AdminTimeClockAddTimeOffScreenController controller) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8),
            ...controller.timeOfTime.map((label) => TextButton(
              onPressed: () {
                controller.selectedTimeOfType(label);
                //Navigator.pop(context);
                Get.back();
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            )),
          ],
        ),
      ),
    ),
  );
}
