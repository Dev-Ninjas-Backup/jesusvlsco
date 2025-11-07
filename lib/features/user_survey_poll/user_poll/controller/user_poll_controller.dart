import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jesusvlsco/core/services/storage_service.dart';

import '../../user_view_single_template/screen/user_view_single_template_screen.dart';

class UserPollController extends GetxController {
  // raw list for polls only
  final polls = <Map<String, dynamic>>[].obs;

  /// search input controller
  final searchController = TextEditingController();

  /// search text
  final searchQuery = ''.obs;

  final String token = StorageService.token ?? '';

  final String pollsUrl =
      "https://lgcglobalcontractingltd.com/js/employee/poll/assigned?page=1&limit=10";

  @override
  void onInit() {
    super.onInit();
    fetchPolls();
  }

  /// Fetch polls from API
  Future<void> fetchPolls() async {
    try {
      final response = await http.get(
        Uri.parse(pollsUrl),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (kDebugMode) {
        print("Polls response: ${response.body}");
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data["success"] == true && data["data"] != null) {
          final List<dynamic> pollList = data["data"];
          polls.value = pollList.map((p) {
            return {
              "id": p["id"],
              "title": p["title"],
              "description": p["description"],
              "status": p["status"],
              "type": "poll",
            };
          }).toList();
          debugPrint("✅ Polls loaded: ${polls.length}");
        } else {
          Get.snackbar("Info", "No polls found");
        }
      } else {
        Get.snackbar("Error", "Failed to load polls");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  /// filtered list based on searchQuery
  List<Map<String, dynamic>> get filteredPolls {
    if (searchQuery.value.trim().isEmpty) return polls;
    final q = searchQuery.value.toLowerCase();
    return polls.where((poll) {
      final t = (poll["title"] ?? "").toString().toLowerCase();
      return t.contains(q);
    }).toList();
  }

  /// called when user types in search
  void updateSearch(String value) {
    searchQuery.value = value;
  }

  /// navigate to poll details
  void takePoll(Map<String, dynamic> poll) {
    Get.to(() => const UserViewSingleTemplateScreen(), arguments: poll);
    debugPrint("Taking poll -> ${poll['title']}");
  }
}
