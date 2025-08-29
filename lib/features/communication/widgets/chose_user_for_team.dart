import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/user/controller/user_list_controller.dart';
import 'package:jesusvlsco/features/user/widget/user_tile.dart';

class ChoseUserForTeam extends StatelessWidget {
  const ChoseUserForTeam({super.key});

  @override
  Widget build(BuildContext context) {
    UserListController userListController = Get.find<UserListController>();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Choose User",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.backspace),
                  ),
                ],
              ),
              Obx(() {
                final users = userListController.employeeProfiles;

                if (userListController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (users.isEmpty) {
                  return Center(
                    child: Text(
                      "No users found",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }
                return SizedBox(
                  height: 600,
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return UserTile(employee: user);
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
