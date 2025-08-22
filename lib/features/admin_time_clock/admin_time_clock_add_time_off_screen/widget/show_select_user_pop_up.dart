import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_add_time_off_screen/controller/admin_time_clock_add_time_off_screen_controller.dart';

void showSelectedUserPopUp (BuildContext context, AdminTimeClockAddTimeOffScreenController controller) {
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                ),
              ),
            ),
            
            SizedBox(height: 8),
            ...controller.projectList.map((label) => TextButton(
              onPressed: () {
                controller.selectProject(label);
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
