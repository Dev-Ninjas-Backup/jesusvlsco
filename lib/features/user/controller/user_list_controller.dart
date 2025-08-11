import 'package:get/get.dart';

class User {
  final String name;
  final String imageUrl;
  final String code;
  RxBool isSelected;

  User({
    required this.name,
    required this.imageUrl,
    required this.code,
    bool selected = false,
  }) : isSelected = selected.obs;
}

class UserListController extends GetxController {
  var users = <User>[
    User(name: "Jenny Wilson", imageUrl: "https://i.pravatar.cc/150?img=1", code: "21389"),
    User(name: "Theresa Webb", imageUrl: "https://i.pravatar.cc/150?img=2", code: "21389"),
    User(name: "Courtney Henry", imageUrl: "https://i.pravatar.cc/150?img=3", code: "21389"),
    User(name: "Eleanor Pena", imageUrl: "https://i.pravatar.cc/150?img=4", code: "21389"),
    User(name: "Kathryn Murphy", imageUrl: "https://i.pravatar.cc/150?img=5", code: "21389"),
    User(name: "Kathryn Murphy", imageUrl: "https://i.pravatar.cc/150?img=6", code: "21389"),
    User(name: "Arlene McCoy", imageUrl: "https://i.pravatar.cc/150?img=7", code: "21389"),
    User(name: "Cody Fisher", imageUrl: "https://i.pravatar.cc/150?img=8", code: "21389"),
    User(name: "Jacob Jones", imageUrl: "https://i.pravatar.cc/150?img=9", code: "21389"),
  ].obs;

  void toggleSelection(int index) {
    users[index].isSelected.value = !users[index].isSelected.value;
  }
}
