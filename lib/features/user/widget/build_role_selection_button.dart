import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/features/user/controller/admin_list_controller.dart';
import 'package:jesusvlsco/features/user/controller/employee_list_screen_controller.dart';
import 'package:jesusvlsco/features/user/controller/user_list_controller.dart';
import 'package:jesusvlsco/features/user/controller/team_list_controller.dart';

class BuildRoleSelectionButton extends StatelessWidget {
  const BuildRoleSelectionButton({
    super.key,
    required this.width,
    required EmployeeListScreenController controller,
    required this.adminListController,
    required this.userListController,
    required this.teamListController,
  }) : _controller = controller;

  final double width;
  final EmployeeListScreenController _controller;
  final AdminListController adminListController;
  final UserListController userListController;
  final TeamListController teamListController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: width,
      child: Obx(
        () => Row(
          children: List.generate(_controller.roleButtonList.length, (index) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: InkWell(
                  onTap: () {
                    _controller.roleSelectedButton.value = index;
                    // Fetch data based on selected role
                    if (index == 0) {
                      userListController.fetchEmployeeProfiles();
                    } else if (index == 1) {
                      adminListController.fetchAdmins();
                    } else {
                      teamListController.fetchTeams();
                    }
                  },
                  child: SizedBox(
                    width: width / _controller.roleButtonList.length,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 7,
                            offset: const Offset(0, 4),
                            spreadRadius: 4,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(8),
                        color: _controller.roleSelectedButton.value == index
                            ? AppColors.primary
                            : Colors.white,
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Center(
                        child: Text(
                          _controller.roleButtonList[index],
                          style: TextStyle(
                            color: _controller.roleSelectedButton.value == index
                                ? Colors.white
                                : AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}