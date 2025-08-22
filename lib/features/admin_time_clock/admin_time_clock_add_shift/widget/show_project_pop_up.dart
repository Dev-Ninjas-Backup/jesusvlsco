import 'package:flutter/material.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_add_shift/controller/admin_time_clock_add_shift_controller.dart';

void showProjectPopup(BuildContext context, AdminTimeClockAddShiftController controller) {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Project',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            ...controller.projectList.map((label) => TextButton(
              onPressed: () {
                controller.selectProject(label);
                Navigator.pop(context);
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
