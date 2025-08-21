import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/time_off_request/time_off_request_user_screen/controller/time_of_request_user_screen_controller.dart';
import 'package:jesusvlsco/features/time_off_request/time_off_request_user_screen/widget/request_user_container.dart';

// ignore: must_be_immutable
class TimeOffRequestUserScreen extends StatelessWidget {
  TimeOfRequestUserScreenController controller = Get.put(TimeOfRequestUserScreenController());
   TimeOffRequestUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Time-Off Request',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0XFF4E53B1),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.pickDate(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF4E53B1), width: 1),
                        //color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month, color: Color(0xFF4E53B1)),
                          SizedBox(width: 8),
                          Container(
                            width: 1,
                            height: 24,
                            color: Color(0xFF4E53B1),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Color(0xFF4E53B1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 19,
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFF4E53B1), width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Refresh",
                      style: TextStyle(color: Color(0xFF4E53B1)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28),
              RequestUserContainer(
                buttonBGColor: Color(0xFF4E53B1),
                buttonName: 'Approved',
                buttonIcon: Icon(Icons.check_circle_outline_outlined),
              ),
              SizedBox(height: 16),
              RequestUserContainer(
                buttonBGColor: Colors.red,
                buttonName: 'Cancelled',
                buttonIcon: Icon(Icons.cancel_outlined),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
