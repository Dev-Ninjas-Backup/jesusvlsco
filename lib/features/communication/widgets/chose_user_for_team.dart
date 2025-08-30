import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/user/controller/user_list_controller.dart';
import 'package:jesusvlsco/features/communication/controllers/create_new_team_controller.dart';
import 'package:jesusvlsco/features/user/widget/user_tile.dart';

class ChoseUserForTeam extends StatelessWidget {
  const ChoseUserForTeam({super.key});

  @override
  Widget build(BuildContext context) {
    UserListController userListController = Get.find<UserListController>();
    CreateNewTeamController createNewTeamController = Get.find<CreateNewTeamController>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Choose User",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back(); // Close dialog without saving
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Obx(() {
                final users = userListController.employeeProfiles;

                if (userListController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (users.isEmpty) {
                  return const Center(
                    child: Text(
                      "No users found",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }
                return SizedBox(
                  height: 400, // Reduced height to accommodate buttons
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return UserTile(employee: user);
                      },
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back(); // Close dialog without saving
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      createNewTeamController.updateSelectedMembers();
                      Get.back(); // Close dialog after saving
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue, // Adjust color to match your theme
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Done",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}