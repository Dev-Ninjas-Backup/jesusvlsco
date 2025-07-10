import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:jesusvlsco/core/models/Announcemodel.dart';
import 'package:jesusvlsco/features/user/screens/widgets/announcement_card.dart';

class AnnouncementController extends GetxController {
  AnnouncementModel? announcement;
  final RxBool ischecked = false.obs;
  final RxInt selectedIndex = 0.obs;
  final RxBool isdeleted = false.obs;

  final RxList<AnnouncementModel> announcements = <AnnouncementModel>[].obs;

  void ischek() {
    ischecked.value =! ischecked.value;
    
    update();
  }

  // Dummy data for announcements with category
  Future<List<AnnouncementModel>> fetchAnnouncements() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Returning the list of announcements after the delay
    return [
      AnnouncementModel(
        id: '1',
        title: 'New Leave Policy Effective July 2025',
        description:
            'We have updated our leave policy to provide better work-life balance for all employees...',
        dateTime: 'Today at 03:00 pm',
        isRead: false,
        hasResponse: true,
        category: 'Updates', // Category added here
      ),
      AnnouncementModel(
        id: '2',
        title: 'Office Relocation Notice',
        description:
            'Our office will be relocating to a new building starting August 1st, 2025...',
        dateTime: 'Yesterday at 10:30 am',
        isRead: true,
        hasResponse: false,
        category: 'Announcements', // Category added here
      ),
      AnnouncementModel(
        id: '3',
        title: 'Team Building Event - Save the Date',
        description:
            'Join us for our annual team building event on August 15th at the city park...',
        dateTime: '2 days ago at 02:15 pm',
        isRead: false,
        hasResponse: true,
        category: 'Announcements', // Category added here
      ),
      AnnouncementModel(
        id: '4',
        title: 'New Health Insurance Benefits',
        description:
            'We are pleased to announce enhanced health insurance coverage for all employees...',
        dateTime: '3 days ago at 09:45 am',
        isRead: true,
        hasResponse: false,
        category: 'Updates', // Category added here
      ),
      AnnouncementModel(
        id: '5',
        title: 'Quarterly Performance Review Schedule',
        description:
            'Performance review meetings will be conducted from July 20-25. Please check your calendar...',
        dateTime: '1 week ago at 11:20 am',
        isRead: false,
        hasResponse: true,
        category: 'Reports', // Category added here
      ),
    ];
  }
}
