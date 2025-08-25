import 'package:get/get.dart';
import 'package:jesusvlsco/features/splasho_screen/controller/splasho_controller.dart'
    show SplashController;
import 'package:jesusvlsco/features/user_settings/models/notification_model.dart';
import 'package:jesusvlsco/features/user_settings/repository/notification_repository.dart';

class UserSettingsController extends GetxController {
  late UserSettingsRepository repository;

  var isLoading = true.obs;

  var email = false.obs;
  var communication = false.obs;
  var userUpdates = false.obs;
  var surveyAndPoll = false.obs;
  var tasksAndProjects = false.obs;
  var scheduling = false.obs;
  var message = false.obs;
  var userRegistration = false.obs;

  NotificationSettingsModel? _settings;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    isLoading.value = true;
    final splashController = Get.find<SplashController>();
    final token = await splashController.getAuthToken();
    if (token != null) {
      repository = UserSettingsRepository(token: token);
      _settings = await repository.fetchNotificationSettings();
      if (_settings != null) {
        // ✅ Only update the .value, do NOT replace the RxBool
        email.value = _settings!.email;
        communication.value = _settings!.communication;
        userUpdates.value = _settings!.userUpdates;
        surveyAndPoll.value = _settings!.surveyAndPoll;
        tasksAndProjects.value = _settings!.tasksAndProjects;
        scheduling.value = _settings!.scheduling;
        message.value = _settings!.message;
        userRegistration.value = _settings!.userRegistration;
      }
    }
    isLoading.value = false;
  }

  // Toggle a switch and update API
  Future<void> toggleSwitch(RxBool rxValue, bool newValue) async {
    rxValue.value = newValue; // update UI immediately

    if (_settings == null) return;

    // Update local settings object
    _settings!
      ..email = email.value
      ..communication = communication.value
      ..userUpdates = userUpdates.value
      ..surveyAndPoll = surveyAndPoll.value
      ..tasksAndProjects = tasksAndProjects.value
      ..scheduling = scheduling.value
      ..message = message.value
      ..userRegistration = userRegistration.value;

    try {
      final success = await repository.updateNotificationSettings(_settings!);
      if (success) {
        Get.snackbar(
          "Success",
          "Notification settings updated successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Error",
          "Failed to update settings",
          snackPosition: SnackPosition.BOTTOM,
        );
        rxValue.value = !newValue; // revert UI if API fails
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Exception: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
      rxValue.value = !newValue; // revert UI if exception occurs
    }
  }
}
