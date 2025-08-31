import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/communication/screens/new_team.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/features/user/controller/user_list_controller.dart';
// Import the controller
//import 'path/to/your/controller/user_list_controller.dart'; // Update with the correct path

class CreateNew extends StatelessWidget {
  const CreateNew({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final UserListController controller = Get.put(UserListController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: Custom_appbar(title: "Create New"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(Sizer.wp(16)),
              child: _buildSearchTextField(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/groups_2.svg',
                    height: Sizer.hp(20),
                    width: Sizer.wp(20),
                  ),
                  SizedBox(width: Sizer.wp(8)),
                  TextButton(
                    onPressed: () {
                      Get.to(NewTeam());
                    },
                    child: Text(
                      'New Team',
                      style: AppTextStyle.regular().copyWith(
                        fontSize: Sizer.wp(16),
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Sizer.hp(16)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
              child: Row(
                children: [
                  Text(
                    'Suggested',
                    style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(16),
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizer.wp(16),
                vertical: Sizer.hp(3),
              ),
              child: Divider(color: AppColors.border3, height: 1),
            ),
            buildSuggestedUser(controller), // Pass the controller to the widget
          ],
        ),
      ),
    );
  }
}

Widget buildSuggestedUser(UserListController controller) {
  return Padding(
    padding: EdgeInsets.all(Sizer.wp(16)),
    child: Container(
      //height: Sizer.hp(204),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        border: Border.all(color: AppColors.border3),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.border3,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Obx(() {
        // Handle loading state
        if (controller.isLoading.value && controller.employeeProfiles.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        // Handle empty state
        if (controller.employeeProfiles.isEmpty) {
          return const Center(child: Text('No employees found'));
        }
        return SizedBox(
          height: 400,
          child: SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.employeeProfiles.length,
              itemBuilder: (context, index) {
                final employee = controller.employeeProfiles[index];
                return ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text(
                    '${employee.profile.firstName} ${employee.profile.lastName}',
                    style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(16),
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  subtitle: Text(
                    employee.profile.jobTitle,
                    style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(14),
                      color: AppColors.text,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    ),
  );
}

Widget _buildSearchTextField() {
  return Container(
    height: Sizer.hp(48),
    decoration: BoxDecoration(
      color: AppColors.primaryBackground,
      border: Border.all(color: AppColors.border),
      borderRadius: BorderRadius.circular(Sizer.wp(10)),
    ),
    child: TextField(
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        border: InputBorder.none,
        hintText: 'To : type a name or group',
        hintStyle: AppTextStyle.regular().copyWith(
          fontSize: Sizer.wp(14),
          color: AppColors.text,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Sizer.wp(16),
          vertical: Sizer.hp(12),
        ),
      ),
    ),
  );
}