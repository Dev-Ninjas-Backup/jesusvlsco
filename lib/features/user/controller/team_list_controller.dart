import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';
import 'package:jesusvlsco/features/user/model/team_list_model.dart';

class TeamListController extends GetxController {
  var teams = <TeamListModel>[].obs;
  RxInt limit = 10.obs;
  var isLoading = false.obs;
  RxInt currentPage = 0.obs;
  RxInt? lastPage;
  RxBool initialInProgress = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch teams only when explicitly needed (e.g., Team tab selected)
  }

  void fetchTeams() async {
    if (lastPage != null && lastPage! < currentPage.value + 1) {
      return;
    }

    currentPage++;
    if (currentPage == 1) {
      teams.clear();
      initialInProgress.value = true;
    } else {
      isLoading.value = true;
    }

    final url = Uri.parse("${ApiConstants.baseurl}/admin/team/get-all-teams?page=$currentPage&limit=$limit");
    final token = await StorageService.getAuthToken();

    try {
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
        lastPage = RxInt(data['data']['meta']['last_page'] ?? currentPage.value);

        teams.addAll(teamData.map((json) => TeamListModel.fromJson(json)).toList());
      } else {
        Get.snackbar('Error', 'Failed to fetch teams: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error: $e');
    } finally {
      if (currentPage == 1) {
        initialInProgress.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }

  void toggleSelection(int index) {
    teams[index].isSelected.value = !teams[index].isSelected.value;
  }
}