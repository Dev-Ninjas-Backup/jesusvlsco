import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateNewTeamController extends GetxController {
  final RxList<String> departments = [
    'IT',
    'DEVELOPMENT',
    'HR',
    'FINANCE',
    'MARKETING',
    'SALES',
  ].obs;

  RxString selectedDepartment = 'IT'.obs;
  final Rx<File?> image = Rx<File?>(null);

  Future<void> pickImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }
}
