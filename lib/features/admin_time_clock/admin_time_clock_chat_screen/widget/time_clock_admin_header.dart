import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_chat_screen/controller/time_clock_admin_chat_controller.dart';


class TimeClockAdminHeader extends StatelessWidget {
  final TimeClockAdminChatController controller = Get.find();

  TimeClockAdminHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Color(0XFFEDEEF7),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(controller.avatarUrl.value),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: controller.isOnline.value
                          ? Colors.green
                          : Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.projectName.value,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  controller.isOnline.value ? 'Online' : 'Offline',
                  style: TextStyle(
                    color: controller.isOnline.value
                        ? Colors.green
                        : Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.call)),
            IconButton(onPressed: () {}, icon: Icon(Icons.videocam_outlined)),
            IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
