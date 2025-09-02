import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_chat_screen/screen/time_clock_admin_chat_screen.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/custom_time_button.dart';

class PendingWidget extends StatelessWidget {
  const PendingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://www.adobe.com/uk/learn/photoshop/web/vector-objects',
              ),
              radius: 50,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Jone Cooper',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.message_outlined, color: AppColors.primary),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Get.to(TimeClockAdminChatScreen());
                },
                child: Text(
                  'Chat with user',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Text(
            'Shift added:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('18/06', style: TextStyle(fontSize: 16)),
                  Text('08:00', style: TextStyle(fontSize: 16)),
                  Text('(08:00 hours)', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                ],
              ),
              Icon(Icons.arrow_forward_sharp),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('18/06', style: TextStyle(fontSize: 16)),
                  Text('05:00', style: TextStyle(fontSize: 16)),
                  Text(
                    'Project 1',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shift Note:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text('_ _ _ _ _ _ _ _'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Request Note:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text('_ _ _ _ _ _ _ _'),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomTimeButton(
                  height: 60,
                  bgColor: Colors.green,
                  text: 'Approve',
                  textcolor: Colors.white,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: CustomTimeButton(
                  height: 60,
                  bgColor: Colors.red,
                  text: 'Decline',
                  textcolor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
