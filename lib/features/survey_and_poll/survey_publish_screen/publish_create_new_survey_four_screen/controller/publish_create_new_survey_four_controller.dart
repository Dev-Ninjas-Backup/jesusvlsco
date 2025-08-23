import 'package:get/get.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_screen/screen/survey_and_poll_screen.dart';



class PublishCreateNewSurveyFourController extends GetxController {
  // Fake summary data (will usually come from previous steps)
  var publishDate = "21/06/2025".obs;
  var publishTime = "16:40".obs;
  var notificationMessage = "A new update is waiting for you in the XYZ company app".obs;

  // If user notification is enabled
  var notifyUsers = true.obs;

  void toggleNotify(bool value) {
    notifyUsers.value = value;
  }

  void createPoll() {
    // Final action to create the poll
    Get.to(SurveyAndPollScreen());
    Get.snackbar("Survey Created", "Your survey is now live!");
  }
}
