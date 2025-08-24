import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/scheduling_and_time%20_tracking/controllers/add_project_controller.dart';
import 'package:jesusvlsco/features/scheduling_and_time%20_tracking/screens/widgets/time_sheet_appbar.dart';
import 'package:jesusvlsco/features/scheduling_and_time%20_tracking/screens/widgets/member_selection_dialog.dart';

/// Add Project Screen
/// Allows users to create new projects with team and member selection
class AddProjectScreen extends StatelessWidget {
  const AddProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddProjectController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const TimeSheetAppBar(title: "Add New Project"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Sizer.wp(16)),
        child: Column(
          children: [
            SizedBox(height: Sizer.hp(30)),
            _buildProjectForm(controller),
            SizedBox(height: Sizer.hp(40)),
            _buildCreateButton(controller),
          ],
        ),
      ),
    );
  }

  /// Build the project creation form
  Widget _buildProjectForm(AddProjectController controller) {
    return Container(
      padding: EdgeInsets.all(Sizer.wp(24)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizer.wp(12)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA9B7DD).withOpacity(0.08),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProjectNameSection(controller),
          SizedBox(height: Sizer.hp(24)),
          _buildTeamSelectionSection(controller),
          SizedBox(height: Sizer.hp(24)),
          _buildMemberSelectionSection(controller),
        ],
      ),
    );
  }

  /// Build project name input section
  Widget _buildProjectNameSection(AddProjectController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create Project Name',
          style: AppTextStyle.f16W600().copyWith(
            color: AppColors.text,
            height: 1.5,
          ),
        ),
        SizedBox(height: Sizer.hp(8)),
        Container(
          height: Sizer.hp(48),
          padding: EdgeInsets.symmetric(horizontal: Sizer.wp(12)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Sizer.wp(8)),
            border: Border.all(color: const Color(0xFFC8CAE7), width: 1),
          ),
          child: TextField(
            controller: controller.projectNameController,
            style: AppTextStyle.f14W400().copyWith(
              color: AppColors.text,
              height: 1.5,
            ),
            decoration: InputDecoration(
              hintText: 'Enter project name here',
              hintStyle: AppTextStyle.f14W400().copyWith(
                color: AppColors.text,
                height: 1.5,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  /// Build team selection section
  Widget _buildTeamSelectionSection(AddProjectController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Team',
          style: AppTextStyle.f16W600().copyWith(
            color: AppColors.text,
            height: 1.5,
          ),
        ),
        SizedBox(height: Sizer.hp(8)),
        _buildTeamDropdown(controller),
      ],
    );
  }

  /// Build team dropdown
  Widget _buildTeamDropdown(AddProjectController controller) {
    return Obx(() {
      return Column(
        children: [
          // Main dropdown button
          GestureDetector(
            onTap: controller.toggleTeamDropdown,
            child: Container(
              height: Sizer.hp(48),
              padding: EdgeInsets.symmetric(horizontal: Sizer.wp(12)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Sizer.wp(8)),
                border: Border.all(color: const Color(0xFFC8CAE7), width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      controller.selectedTeam.value?.name ?? 'Select team',
                      style: AppTextStyle.f14W400().copyWith(
                        color: AppColors.text,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Icon(
                    controller.isTeamDropdownOpen.value
                        ? Iconsax.arrow_up_2
                        : Iconsax.arrow_down_1,
                    size: Sizer.wp(24),
                    color: AppColors.text,
                  ),
                ],
              ),
            ),
          ),
          // Dropdown list
          if (controller.isTeamDropdownOpen.value)
            Container(
              margin: EdgeInsets.only(top: Sizer.hp(8)),
              padding: EdgeInsets.all(Sizer.wp(24)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Sizer.wp(8)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFA9B7DD).withOpacity(0.25),
                    offset: const Offset(0, 0),
                    blurRadius: 12,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...controller.teams.map((team) {
                    return GestureDetector(
                      onTap: () => controller.selectTeam(team),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: Sizer.hp(8)),
                        child: Text(
                          team.name,
                          style: AppTextStyle.f16W500().copyWith(
                            color: AppColors.text,
                            height: 1.7,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  GestureDetector(
                    onTap: controller.createNewTeam,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: Sizer.hp(8)),
                      child: Text(
                        'Create Team',
                        style: AppTextStyle.f16W500().copyWith(
                          color: AppColors.primary,
                          height: 1.7,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    });
  }

  /// Build member selection section
  Widget _buildMemberSelectionSection(AddProjectController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Specific Members',
          style: AppTextStyle.f16W600().copyWith(
            color: AppColors.text,
            height: 1.5,
          ),
        ),
        SizedBox(height: Sizer.hp(8)),
        _buildMemberSelector(controller),
      ],
    );
  }

  /// Build member selector dropdown
  Widget _buildMemberSelector(AddProjectController controller) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          Get.dialog(const MemberSelectionDialog(), barrierDismissible: true);
        },
        child: Container(
          height: Sizer.hp(48),
          padding: EdgeInsets.symmetric(horizontal: Sizer.wp(12)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Sizer.wp(8)),
            border: Border.all(color: const Color(0xFFC8CAE7), width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  controller.selectedMembersCount > 0
                      ? '${controller.selectedMembersCount} members selected'
                      : 'Select Member',
                  style: AppTextStyle.f14W400().copyWith(
                    color: AppColors.text,
                    height: 1.5,
                  ),
                ),
              ),
              Icon(
                Iconsax.arrow_down_1,
                size: Sizer.wp(24),
                color: AppColors.text,
              ),
            ],
          ),
        ),
      );
    });
  }

  /// Build create project button
  Widget _buildCreateButton(AddProjectController controller) {
    return Obx(() {
      // Reference observable values to trigger updates
      final isValid =
          controller.projectName.value.trim().isNotEmpty &&
          controller.selectedTeam.value != null &&
          controller.selectedMembers.isNotEmpty;

      return Container(
        width: double.infinity,
        height: Sizer.hp(48),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(Sizer.wp(8)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isValid ? controller.createProject : null,
            borderRadius: BorderRadius.circular(Sizer.wp(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, size: Sizer.wp(24), color: Colors.white),
                SizedBox(width: Sizer.wp(12)),
                Text(
                  'Create New',
                  style: AppTextStyle.f16W500().copyWith(
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
