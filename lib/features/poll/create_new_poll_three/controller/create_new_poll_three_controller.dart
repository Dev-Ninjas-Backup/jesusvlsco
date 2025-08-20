import 'package:get/get.dart';

class CreateNewPollThreeController extends GetxController {
  var currentPage = 3.obs;

  var users = [
    {"id": 21389, "name": "Jenny Wilson", "avatar": "https://i.pravatar.cc/150?img=1"},
    {"id": 21390, "name": "Theresa Webb", "avatar": "https://i.pravatar.cc/150?img=2"},
    {"id": 21391, "name": "Courtney Henry", "avatar": "https://i.pravatar.cc/150?img=3"},
    {"id": 21392, "name": "Eleanor Pena", "avatar": "https://i.pravatar.cc/150?img=4"},
    {"id": 21393, "name": "Kathryn Murphy", "avatar": "https://i.pravatar.cc/150?img=5"},
    {"id": 21394, "name": "Arlene McCoy", "avatar": "https://i.pravatar.cc/150?img=6"},
    {"id": 21395, "name": "Cody Fisher", "avatar": "https://i.pravatar.cc/150?img=7"},
    {"id": 21396, "name": "Jacob Jones", "avatar": "https://i.pravatar.cc/150?img=8"},
  ];

  var selectedUsers = <int>[].obs;

  void toggleUser(int id) {
    if (selectedUsers.contains(id)) {
      selectedUsers.remove(id);
    } else {
      selectedUsers.add(id);
    }
  }

  void setPage(int page) {
    currentPage.value = page;
  }

  void goToNextStep() {
    // Navigate to Publish Settings screen
  }
}
