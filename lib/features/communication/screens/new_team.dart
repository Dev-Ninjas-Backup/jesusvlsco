import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/features/communication/controllers/create_new_team_controller.dart';
import 'package:jesusvlsco/features/communication/widgets/chose_user_for_team.dart';
import 'package:jesusvlsco/features/taskmanagement/widgets/common_button.dart';

// ignore: must_be_immutable
class NewTeam extends StatelessWidget {
  CreateNewTeamController createNewTeamController = Get.put(
    CreateNewTeamController(),
  );
  NewTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Custom_appbar(title: "New Team"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              createNewTeamController.pickImage();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Sizer.wp(24)),
                  child: Container(
                    width: Sizer.wp(166),
                    height: Sizer.hp(48),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBackground,
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(Sizer.wp(10)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: Sizer.wp(24)),
                        SvgPicture.asset(
                          "assets/icons/home.svg",
                          height: Sizer.hp(24),
                          width: Sizer.wp(24),
                        ),
                        SizedBox(width: Sizer.wp(8)),
                        Text(
                          'Add Image',
                          style: AppTextStyle.regular().copyWith(
                            fontSize: Sizer.wp(16),
                            fontWeight: FontWeight.w500,
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              left: Sizer.wp(16),
              top: Sizer.hp(16),
              right: Sizer.wp(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create team name",
                  style: TextStyle(
                    fontSize: Sizer.wp(16),
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                SizedBox(height: Sizer.hp(8)),
                TextFormField(
                  decoration: InputDecoration(hintText: "Team Title"),
                ),
              ],
            ),
          ),
          SizedBox(height: Sizer.hp(16)),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "Description",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Brief Description about team",
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Select Department",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 8),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: createNewTeamController.selectedDepartment.value,
                    icon: Icon(Icons.keyboard_arrow_down),
                    isExpanded: true,
                    items: createNewTeamController.departments.map((
                      String department,
                    ) {
                      return DropdownMenuItem<String>(
                        value: department,
                        child: Text(department),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        createNewTeamController.selectedDepartment.value =
                            newValue;
                      }
                    },
                  ),
                ),
              ),
            );
          }),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {
                //Select User show Model action here,
                showDialog(
                  context: context,
                  builder: (context) {
                    return ChoseUserForTeam();
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      "Select User",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: Sizer.hp(24),
                    left: Sizer.wp(16),
                    right: Sizer.wp(16),
                  ),
                  child: customButton(
                    bgcolor: AppColors.primary,
                    brcolor: Colors.transparent,
                    text: "Create New Team",
                    textcolor: Colors.white,
                    onPressed: () {},
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget _buildSearchTextField() {
//   return Container(
//     height: Sizer.hp(48),

//     decoration: BoxDecoration(
//       color: AppColors.primaryBackground,
//       border: Border.all(color: AppColors.border),
//       borderRadius: BorderRadius.circular(Sizer.wp(10)),
//     ),
//     child: TextField(
//       textAlign: TextAlign.start,
//       decoration: InputDecoration(
//         enabledBorder: InputBorder.none,
//         focusedBorder: InputBorder.none,
//         border: InputBorder.none,
//         hintText: 'Enter team name here ',
//         hintStyle: AppTextStyle.regular().copyWith(
//           fontSize: Sizer.wp(14),
//           color: AppColors.text,
//         ),

//         contentPadding: EdgeInsets.symmetric(
//           horizontal: Sizer.wp(16),
//           vertical: Sizer.hp(12),
//         ),
//       ),
//     ),
//   );
// }
