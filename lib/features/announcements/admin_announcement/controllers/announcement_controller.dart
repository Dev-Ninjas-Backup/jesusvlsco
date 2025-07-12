import 'dart:ui';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:jesusvlsco/core/models/Announcemodel.dart';

class AnnouncementController extends GetxController {
  RxBool isdelete = false.obs;

  final RxList<AnnouncementModel> announcements = <AnnouncementModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAnnouncements();
  }

  void toggleDelete() {
    isdelete.value = !isdelete.value;
    
    update();
  }

void clickdelete(){
  announcements.removeWhere((element) => element.isChecked.value == true);
  update();
}
 List<String> categories = [
    'Technology',
    'Science',
    'Health',
    'Business',
    'Sports',
    'Entertainment'
  ];
 final List<String> teams = ['Team A', 'Team B', 'Team C', 'Team D', 'Team E'];


 final List<Map<String, dynamic>> dummyUsers = [
    {
      'name': 'Cody Fisher',
      'profileImageUrl': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
      'statusText': 'Viewed',
      'statusColor': Color(0xFF10B981),
    },
    {
      'name': 'Jenny Wilson',
      'profileImageUrl': 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
      'statusText': 'Online',
      'statusColor': Color(0xFF22C55E),
    },
    {
      'name': 'Wade Warren',
      'profileImageUrl': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      'statusText': 'Offline',
      'statusColor': Color(0xFF6B7280),
    },
    {
      'name': 'Esther Howard',
      'profileImageUrl': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
      'statusText': 'Viewed',
      'statusColor': Color(0xFF10B981),
    },
    {
      'name': 'Cameron Williamson',
      'profileImageUrl': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face',
      'statusText': 'Pending',
      'statusColor': Color(0xFFF59E0B),
    },
    {
      'name': 'Brooklyn Simmons',
      'profileImageUrl': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&h=150&fit=crop&crop=face',
      'statusText': 'Online',
      'statusColor': Color(0xFF22C55E),
    },
    {
      'name': 'Esther Howard',
      'profileImageUrl': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
      'statusText': 'Viewed',
      'statusColor': Color(0xFF10B981),
    },
    {
      'name': 'Cameron Williamson',
      'profileImageUrl': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face',
      'statusText': 'Pending',
      'statusColor': Color(0xFFF59E0B),
    },
    {
      'name': 'Brooklyn Simmons',
      'profileImageUrl': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&h=150&fit=crop&crop=face',
      'statusText': 'Online',
      'statusColor': Color(0xFF22C55E),
    },
  ];



  // Dummy data for announcements with category
  Future<List<AnnouncementModel>> fetchAnnouncements() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Returning the list of announcements after the delay
    announcements.addAll([
      AnnouncementModel(
        id: '1',
        title: 'New Leave Policy Effective July 2025',
        description:
            'We have updated our leave policy to provide better work-life balance for all employees...',
        dateTime: 'Today at 03:00 pm',
        isRead: false,
        hasResponse: true,
        category: 'Updates',
        isChecked: false.obs,  // Add RxBool for check state
      ),
      AnnouncementModel(
        id: '2',
        title: 'Office Relocation Notice',
        description:
            'Our office will be relocating to a new building starting August 1st, 2025...',
        dateTime: 'Yesterday at 10:30 am',
        isRead: true,
        hasResponse: false,
        category: 'Announcements',
        isChecked: false.obs,  // Add RxBool for check state
      ),
      AnnouncementModel(
        id: '3',
        title: 'Team Building Event - Save the Date',
        description:
            'Join us for our annual team building event on August 15th at the city park...',
        dateTime: '2 days ago at 02:15 pm',
        isRead: false,
        hasResponse: true,
        category: 'Announcements',
        isChecked: false.obs,  // Add RxBool for check state
      ),
      // Add more announcements...
    ]);
    return announcements;
  }

  // Function to toggle checkbox state for a specific index
  void toggleCheckbox(int index) {
    // Correctly toggle the value of the existing RxBool
    announcements[index].isChecked.value = !announcements[index].isChecked.value;
    update(); // Notifies the UI of the change
  }
}
