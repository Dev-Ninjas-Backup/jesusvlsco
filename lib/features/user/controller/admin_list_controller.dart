import 'package:get/get.dart';

class Admin {
  final String name;
  final String imageUrl;
  final String code;
  RxBool isSelected;

  Admin({
    required this.name,
    required this.imageUrl,
    required this.code,
    bool selected = false,
  }) : isSelected = selected.obs;
}

class AdminListController extends GetxController {
  var admin = <Admin>[
  Admin(name: "Olivia Martinez", imageUrl: "https://i.pravatar.cc/150?img=10", code: "78421"),
  Admin(name: "Liam Anderson", imageUrl: "https://i.pravatar.cc/150?img=11", code: "45938"),
  Admin(name: "Sophia Lee", imageUrl: "https://i.pravatar.cc/150?img=12", code: "93215"),
  Admin(name: "Noah Brown", imageUrl: "https://i.pravatar.cc/150?img=13", code: "67209"),
  Admin(name: "Isabella Clark", imageUrl: "https://i.pravatar.cc/150?img=14", code: "84576"),
  Admin(name: "Mason Walker", imageUrl: "https://i.pravatar.cc/150?img=15", code: "21847"),
  Admin(name: "Ava Harris", imageUrl: "https://i.pravatar.cc/150?img=16", code: "50673"),
  Admin(name: "Ethan Young", imageUrl: "https://i.pravatar.cc/150?img=17", code: "39482"),
  Admin(name: "Mia King", imageUrl: "https://i.pravatar.cc/150?img=18", code: "76134"),
].obs;


  void toggleSelection(int index) {
    admin[index].isSelected.value = !admin[index].isSelected.value;
  }
}
