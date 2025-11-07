// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/features/user/controller/admin_list_controller.dart';
import 'package:jesusvlsco/features/user/controller/employee_list_screen_controller.dart';
import 'package:jesusvlsco/features/user/controller/user_list_controller.dart';
import 'package:jesusvlsco/features/user/controller/team_list_controller.dart';
import 'package:jesusvlsco/features/user/model/team_list_model.dart';
import 'package:jesusvlsco/features/user/widget/action_button_row.dart';
import 'package:jesusvlsco/features/user/widget/admin_tile.dart';
import 'package:jesusvlsco/features/user/widget/build_role_selection_button.dart';
import 'package:jesusvlsco/features/user/widget/user_tile.dart';
import 'package:jesusvlsco/features/user/widget/team_tile.dart';

class EmployeeListScreen extends StatelessWidget {
  EmployeeListScreen({super.key});

  final EmployeeListScreenController controller = Get.put(
    EmployeeListScreenController(),
  );

  final UserListController userListController = Get.put(UserListController());
  final AdminListController adminListController = Get.put(
    AdminListController(),
  );
  final TeamListController teamListController = Get.put(
    TeamListController(),
  );

  OutlineInputBorder getOutlineBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: Color(0xFFE8E6FF), // normal border color
        width: 1.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: Custom_appbar(title: "Employee List"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              BuildRoleSelectionButton(
                width: width,
                controller: controller,
                adminListController: adminListController,
                userListController: userListController,
                teamListController: teamListController,
              ),
              Text(
                controller.roleSelectedButton.value == 2 ? "Team List" : "Employee List",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                controller.roleSelectedButton.value == 2
                    ? "All Team Info. in One Place"
                    : "All Employee Info. in One Place",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              ActionButtonsRow(),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: getOutlineBorder(),
                  focusedBorder: getOutlineBorder(),
                  errorBorder: getOutlineBorder(),
                  disabledBorder: getOutlineBorder(),
                  enabledBorder: getOutlineBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  hintText: "Search",
                  suffixIcon: Image.asset('assets/icons/search-normal.png'),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_box_outline_blank),
                        SizedBox(width: 15),
                        Text(controller.roleSelectedButton.value == 2 ? "Team Name" : "Name"),
                      ],
                    ),
                    Text(controller.roleSelectedButton.value == 2 ? "Team ID" : "ID"),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: Obx(() {
                  final roleIndex = controller.roleSelectedButton.value;
                  final items = roleIndex == 0
                      ? userListController.employeeProfiles
                      : roleIndex == 1
                          ? adminListController.admin
                          : teamListController.teams;

                  if (items.isEmpty) {
                    return Center(
                      child: Text(
                        "Wait for ${roleIndex == 0 ? 'users' : roleIndex == 1 ? 'admins' : 'teams'} load data",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      if (roleIndex == 0) {
                        final user = items[index] as EmployeeProfile;
                        if (userListController.isLoading == true) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return UserTile(employee: user);
                        }
                      } else if (roleIndex == 1) {
                        final admin = items[index] as Admin;
                        return AdminTile(
                          admin: admin,
                          onChanged: () =>
                              adminListController.toggleSelection(index),
                        );
                      } else {
                        final team = items[index] as TeamListModel;
                        return TeamTile(
                          team: team,
                          onChanged: () =>
                              teamListController.toggleSelection(index),
                        );
                      }
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}