import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/features/user/controller/admin_list_controller.dart';
import 'package:jesusvlsco/features/user/controller/employee_list_screen_controller.dart';
import 'package:jesusvlsco/features/user/controller/user_list_controller.dart';
import 'package:jesusvlsco/features/user/widget/action_button_row.dart';
import 'package:jesusvlsco/features/user/widget/admin_tile.dart';
import 'package:jesusvlsco/features/user/widget/build_role_selection_button.dart';
import 'package:jesusvlsco/features/user/widget/user_tile.dart';

class EmployeeListScreen extends StatelessWidget {
  EmployeeListScreen({super.key});

  final EmployeeListScreenController controller = Get.put(
    EmployeeListScreenController(),
  );

  final UserListController userListController = Get.put(UserListController());
  final AdminListController adminListController = Get.put(
    AdminListController(),
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
            spacing: 10,
            children: [
              const SizedBox(height: 10),
              BuildRoleSelectionButton(width: width, controller: controller),
              Text(
                "Employee List",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "All Employee Info. in One Place",
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
                      spacing: 15,
                      children: [
                        Icon(Icons.check_box_outline_blank),
                        Text("Name"),
                      ],
                    ),
                    Text("ID"),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: Obx(() {
                  final isUserRole = controller.roleSelectedButton.value == 0;
                  final items = isUserRole
                      ? userListController.users
                      : adminListController.admin;

                  if (items.isEmpty) {
                    return Center(
                      child: Text(
                        "No ${isUserRole ? 'users' : 'admins'} found",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      if (isUserRole) {
                        final user = items[index] as User;
                        return UserTile(
                          user: user,
                          onChanged: () =>
                              userListController.toggleSelection(index),
                        );
                      } else {
                        final admin = items[index] as Admin;
                        return AdminTile(
                          admin: admin,
                          onChanged: () =>
                              adminListController.toggleSelection(index),
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
