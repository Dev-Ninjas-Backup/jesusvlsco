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
