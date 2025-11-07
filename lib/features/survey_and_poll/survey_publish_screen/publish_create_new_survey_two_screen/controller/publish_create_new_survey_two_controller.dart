import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublishCreateNewSurveyTwoController extends GetxController {
  /// 🔹 Pagination
  var currentPage = 1.obs;

  /// 🔹 Search
  final searchController = TextEditingController();
  final searchQuery = ''.obs;

  /// 🔹 Users (mock data - replace with API later)
  final users = [
    {"id": 21389, "name": "Jenny Wilson", "avatar": "https://i.pravatar.cc/150?img=1"},
    {"id": 21390, "name": "Theresa Webb", "avatar": "https://i.pravatar.cc/150?img=2"},
    {"id": 21391, "name": "Courtney Henry", "avatar": "https://i.pravatar.cc/150?img=3"},
    {"id": 21392, "name": "Eleanor Pena", "avatar": "https://i.pravatar.cc/150?img=4"},
    {"id": 21393, "name": "Kathryn Murphy", "avatar": "https://i.pravatar.cc/150?img=5"},
    {"id": 21394, "name": "Arlene McCoy", "avatar": "https://i.pravatar.cc/150?img=6"},
    {"id": 21395, "name": "Cody Fisher", "avatar": "https://i.pravatar.cc/150?img=7"},
    {"id": 21396, "name": "Jacob Jones", "avatar": "https://i.pravatar.cc/150?img=8"},
  ];

  /// 🔹 Selected users
  var selectedUsers = <int>[].obs;

  /// 🔹 Toggle selection
  void toggleUser(int id) {
    if (selectedUsers.contains(id)) {
      selectedUsers.remove(id);
    } else {
      selectedUsers.add(id);
    }
  }

  /// 🔹 Search update
  void updateSearch(String value) {
    searchQuery.value = value;
  }

  /// 🔹 Filtered users list (reactive)
  List<Map<String, dynamic>> get filteredUsers {
    if (searchQuery.value.trim().isEmpty) return users;
    return users
        .where((u) =>
        (u["name"] as String).toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  /// 🔹 Pagination update
  void setPage(int page) {
    currentPage.value = page;
  }

  /// 🔹 Next step navigation
  void goToNextStep() {
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
