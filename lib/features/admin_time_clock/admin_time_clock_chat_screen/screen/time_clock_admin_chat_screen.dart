import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_chat_screen/controller/time_clock_admin_chat_controller.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_chat_screen/widget/time_clock_admin_chat_bubble.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_chat_screen/widget/time_clock_admin_header.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_chat_screen/widget/time_clock_admin_message_input_bar.dart';


class TimeClockAdminChatScreen extends StatelessWidget {
  const TimeClockAdminChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TimeClockAdminChatController controller = Get.put(
      TimeClockAdminChatController(),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Chat",
          style: TextStyle(fontSize: 18, color: AppColors.primary),
        ),
      ),
      body: Column(
        children: [
          TimeClockAdminHeader(),
          Expanded(
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final msg = controller.messages[index];
                    return TimeClockAdminChatBubble(
                      isSender: msg.isSender,
                      avatarUrl: msg.avatarUrl,
                      text: msg.text,
                    );
                  },
                ),
              ),
            ),
          ),
          TimeClockAdminMessageInputBar(onSend: controller.sendMessage),
          SizedBox(height: 36,),
        ],
      ),
    );
  }
}
