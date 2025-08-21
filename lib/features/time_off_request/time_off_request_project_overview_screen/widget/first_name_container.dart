import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/time_off_request/time_off_request_user_screen/screen/time_off_request_user_screen.dart';

class FirstNameContainer extends StatelessWidget {
  final String name;
  final String date;
  final String subjectType;
  final String statusText;
  final Color statusColor;
  final bool isPending;
  final VoidCallback? approveButtonAction;

  const FirstNameContainer({
    super.key,
    required this.name,
    required this.date,
    required this.subjectType,
    required this.statusText,
    required this.statusColor,
    required this.isPending,
    this.approveButtonAction,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isPending
          ? null // Disable tap for pending requests
          : () {
              // Handle tap for approved/declined requests
              Get.to(TimeOffRequestUserScreen());
            },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  statusText,
                  style: TextStyle(color: statusColor),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(date, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 8),
            Text(subjectType),
            SizedBox(height: 16),
            if (isPending)
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Handle approve
                    Get.snackbar("Approved", "Approved are construction");
                    },
                    child: Text("Approve"),
                  ),
                  SizedBox(width: 16),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Handle decline
                      Get.snackbar("Decline", "Decline are construction");
                    },
                    child: Text("Decline", style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}