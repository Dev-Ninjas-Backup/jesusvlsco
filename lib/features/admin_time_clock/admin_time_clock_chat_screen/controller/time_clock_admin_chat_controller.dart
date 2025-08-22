import 'package:get/get.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_chat_screen/model/time_clock_admin_chat_massage.dart';


class TimeClockAdminChatController extends GetxController {
  final RxList<TimeClockAdminChatMassage> messages = <TimeClockAdminChatMassage>[].obs;
  final RxBool isOnline = true.obs;
  final RxString projectName = 'Project ABC'.obs;
  final RxString avatarUrl = 'https://i.pravatar.cc/40?img=1'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialMessages();
  }

  void _loadInitialMessages() {
    messages.addAll([
      TimeClockAdminChatMassage(
        isSender: false,
        avatarUrl: 'https://i.pravatar.cc/40?img=1',
        text: 'Hey! How is the new project coming along?',
      ),
      TimeClockAdminChatMassage(
        isSender: true,
        avatarUrl: 'https://i.pravatar.cc/40?img=2',
        text: 'Going great! Just finished the wireframes _ Will share them with you shortly.',
      ),
    ]);
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    messages.add(TimeClockAdminChatMassage(
      isSender: true,
      avatarUrl: 'https://i.pravatar.cc/40?img=2',
      text: text.trim(),
    ));
  }
}


