import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/utils/constants/image_path.dart';

class UserModel {
  final String id;
  final String name;
  final String avatarUrl;

  UserModel({required this.id, required this.name, required this.avatarUrl});
}

/// Controller for the Users / Directory screen.
/// - Holds a list of users (mocked for now).
/// - Exposes reactive search and a filtered view ready to be wired to a backend.
class UserUsersController extends GetxController {
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxString query = ''.obs;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchMockUsers();
    searchController.addListener(() => query.value = searchController.text);
  }

  /// Populate with mock users. Replace with API call when backend is ready.
  void fetchMockUsers() {
    final mock = <UserModel>[
      UserModel(id: '1', name: 'Cody Fisher', avatarUrl: ImagePath.user1),
      UserModel(id: '2', name: 'Leslie Alexander', avatarUrl: ImagePath.user2),
      UserModel(id: '3', name: 'Kristin Watson', avatarUrl: ImagePath.user3),
      UserModel(id: '4', name: 'Robert Fox', avatarUrl: ImagePath.user4),
      UserModel(id: '5', name: 'Jacob Jones', avatarUrl: ImagePath.user5),
      UserModel(id: '6', name: 'Theresa Webb', avatarUrl: ImagePath.user6),
      UserModel(id: '7', name: 'Guy Hawkins', avatarUrl: ImagePath.user7),
    ];

    users.assignAll(mock);
  }

  List<UserModel> get filteredUsers {
    final q = query.value.trim().toLowerCase();
    if (q.isEmpty) return users;
    return users.where((u) => u.name.toLowerCase().contains(q)).toList();
  }

  /// Actions (currently mocked). Replace with navigation / platform channels as needed.
  void callUser(UserModel user) {
    debugPrint('Call ${user.name}');
  }

  void messageUser(UserModel user) {
    debugPrint('Message ${user.name}');
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
