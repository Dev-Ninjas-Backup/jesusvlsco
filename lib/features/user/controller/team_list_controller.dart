import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';
import 'package:jesusvlsco/features/user/model/team_list_model.dart';

class TeamListController extends GetxController {
  final teams = <TeamListModel>[].obs;

  final RxInt currentPage = 1.obs;
  final int limit = 8;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTeams();
  }

  Future<void> fetchTeams() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    final token = await StorageService.getAuthToken();

    try {
      while (hasMore.value) {
        final url = Uri.parse(
          "${ApiConstants.baseurl}/admin/team/get-all-teams?page=${currentPage.value}&limit=$limit",
        );

        final response = await http.get(
          url,
          headers: {
            'accept': '*/*',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final List<dynamic> teamData = data['data']['teams'] ?? [];

          if (teamData.isEmpty) {
            hasMore.value = false;
          } else {
            final newTeams = teamData
                .map((json) => TeamListModel.fromJson(json))
                .toList();
            teams.addAll(newTeams);
            currentPage.value++;
          }

          // stop if last page reached
          final lastPage = data['data']['meta']?['last_page'] ?? currentPage.value;
          if (currentPage.value > lastPage || teamData.length < limit) {
            hasMore.value = false;
          }
        } else {
          hasMore.value = false;
          Get.snackbar('Error', 'Failed to fetch teams: ${response.statusCode}');
        }
      }
    } catch (e) {
      hasMore.value = false;
      Get.snackbar('Error', 'Network error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleSelection(int index) {
    teams[index].isSelected.value = !teams[index].isSelected.value;
  }
}
