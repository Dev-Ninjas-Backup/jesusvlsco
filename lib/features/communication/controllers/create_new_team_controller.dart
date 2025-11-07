import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';
import 'package:jesusvlsco/features/user/controller/user_list_controller.dart';

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
  final RxBool isLoading = false.obs;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final RxList<EmployeeProfile> selectedMembers = <EmployeeProfile>[].obs;

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> pickImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  // Validate UUID format
  bool isValidUUID(String uuid) {
    final uuidRegex = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
      caseSensitive: false,
    );
    return uuidRegex.hasMatch(uuid);
  }

  Future<bool> createTeam() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedDepartment.value.isEmpty ||
        image.value == null ||
        selectedMembers.isEmpty) {
      Get.snackbar(
        'Error',
        'All fields are required, including at least one selected member',
      );
      return false;
    }

    // Validate UUIDs
    for (var member in selectedMembers) {
      if (!isValidUUID(member.id)) {
        Get.snackbar(
          'Error',
          'Invalid member ID: ${member.id} is not a valid UUID',
        );
        return false;
      }
    }

    isLoading.value = true;
    final token = await StorageService.getAuthToken();
    final url = Uri.parse('${ApiConstants.baseurl}/admin/team');

    try {
      var request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Accept'] = '*/*'
        ..headers['Content-Type'] = 'multipart/form-data'
        ..fields['title'] = titleController.text
        ..fields['description'] = descriptionController.text
        ..fields['department'] = selectedDepartment.value
        ..fields['members'] = jsonEncode(
          selectedMembers.map((e) => e.id).toList(),
        );

      if (image.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            image.value!.path,
            filename: 'team_image.jpg',
          ),
        );
      }

      if (kDebugMode) {
        print('Sending POST request to: $url');
      }
      if (kDebugMode) {
        print('Request headers: ${request.headers}');
      }
      if (kDebugMode) {
        print('Request fields: ${request.fields}');
      }
      if (kDebugMode) {
        print('Members sent: ${selectedMembers.map((e) => e.id).toList()}');
      }
      if (kDebugMode) {
        print(
          'Request files: ${request.files.map((f) => f.filename).toList()}',
        );
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      isLoading.value = false;

      if (kDebugMode) {
        print('Response status: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Response body: $responseBody');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Team created successfully');
        selectedMembers.clear();
        Get.find<UserListController>().clearSelections();
        Get.snackbar("info", "created successfully");
        return true;
      } else {
        Get.snackbar(
          'Error',
          'Failed to create team: ${response.statusCode} - $responseBody',
        );
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'An error occurred: $e');
      if (kDebugMode) {
        print('Exception during POST: $e');
      }
      return false;
    }
  }

  Future<void> updateSelectedMembers() async {
    final userListController = Get.find<UserListController>();
    if (userListController.employeeProfiles.isEmpty &&
        userListController.hasMore.value) {
      await userListController.fetchEmployeeProfiles();
    }
    selectedMembers.value = userListController.selectedEmployees;
    if (kDebugMode) {
      print(
        'Updated selectedMembers: ${selectedMembers.map((e) => "${e.profile.firstName} ${e.profile.lastName} (ID: ${e.id})").toList()}',
      );
    }
  }
}
