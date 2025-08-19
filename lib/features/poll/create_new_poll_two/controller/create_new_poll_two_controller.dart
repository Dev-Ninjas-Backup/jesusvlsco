import 'package:get/get.dart';

class CreateNewPollTwoController extends GetxController {
  // default "All" selected
  var selectedOption = "All".obs;

  // track current step (0 = Assign by, 1 = Recipients, 2 = Publish, 3 = Summary)
  var currentStep = 0.obs;

  void selectOption(String option) {
    selectedOption.value = option;
  }

  bool isSelected(String option) => selectedOption.value == option;

  void nextStep() {
    if (currentStep.value < 3) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }
}
