import 'package:get/get.dart';
import '../model/response_model.dart';

class ResponseController extends GetxController {
  var responses = <ResponseModel>[].obs;
  var currentPage = 3.obs; // default page

  @override
  void onInit() {
    super.onInit();
    loadResponses();
  }

  void loadResponses() {
    responses.value = [
      ResponseModel(name: "Cody Fisher", imageUrl: "https://i.pravatar.cc/150?img=1", viewed: true),
      ResponseModel(name: "Leslie Alexander", imageUrl: "https://i.pravatar.cc/150?img=2", viewed: true),
      ResponseModel(name: "Kristin Watson", imageUrl: "https://i.pravatar.cc/150?img=3", viewed: true),
      ResponseModel(name: "Robert Fox", imageUrl: "https://i.pravatar.cc/150?img=4", viewed: true),
      ResponseModel(name: "Jacob Jones", imageUrl: "https://i.pravatar.cc/150?img=5", viewed: false),
      ResponseModel(name: "Jacob Jones", imageUrl: "https://i.pravatar.cc/150?img=6", viewed: true),
      ResponseModel(name: "Jacob Jones", imageUrl: "https://i.pravatar.cc/150?img=7", viewed: false),ResponseModel(name: "Robert Fox", imageUrl: "https://i.pravatar.cc/150?img=4", viewed: true),
      ResponseModel(name: "Jacob Jones", imageUrl: "https://i.pravatar.cc/150?img=5", viewed: false),
      ResponseModel(name: "Jacob Jones", imageUrl: "https://i.pravatar.cc/150?img=6", viewed: true),
      ResponseModel(name: "Jacob Jones", imageUrl: "https://i.pravatar.cc/150?img=7", viewed: false),ResponseModel(name: "Robert Fox", imageUrl: "https://i.pravatar.cc/150?img=4", viewed: true),
      ResponseModel(name: "Jacob Jones", imageUrl: "https://i.pravatar.cc/150?img=5", viewed: false),
      ResponseModel(name: "Jacob Jones", imageUrl: "https://i.pravatar.cc/150?img=6", viewed: true),
      ResponseModel(name: "Jacob Jones", imageUrl: "https://i.pravatar.cc/150?img=7", viewed: false),
    ];
  }
}
