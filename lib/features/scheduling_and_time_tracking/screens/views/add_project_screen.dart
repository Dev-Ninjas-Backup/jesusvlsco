import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/add_project_controller.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/time_sheet_appbar.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/team_selection_dialog.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/manager_selection_dialog.dart';

/// Add Project Screen
/// Allows users to create new projects with team and manager selection
/// Includes project name, team selection, manager selection, and location
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
            color: const Color(0xFFA9B7DD).withValues(alpha: 0.08),
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
          _buildManagerSelectionSection(controller),
          SizedBox(height: Sizer.hp(24)),
          _buildLocationSection(controller),
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
          'Project Name *',
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
          'Team *',
          style: AppTextStyle.f16W600().copyWith(
            color: AppColors.text,
            height: 1.5,
          ),
        ),
        SizedBox(height: Sizer.hp(8)),
        _buildTeamSelector(controller),
      ],
    );
  }

  /// Build team selector that opens dialog
  Widget _buildTeamSelector(AddProjectController controller) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          Get.dialog(const TeamSelectionDialog(), barrierDismissible: true);
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
                  controller.selectedTeam.value?.name ?? 'Select a team',
                  style: AppTextStyle.f14W400().copyWith(
                    color: controller.selectedTeam.value != null
                        ? AppColors.text
                        : AppColors.text.withValues(alpha: 0.6),
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

  /// Build manager selection section
  Widget _buildManagerSelectionSection(AddProjectController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Manager *',
          style: AppTextStyle.f16W600().copyWith(
            color: AppColors.text,
            height: 1.5,
          ),
        ),
        SizedBox(height: Sizer.hp(8)),
        _buildManagerSelector(controller),
      ],
    );
  }

  /// Build manager selector that opens dialog
  Widget _buildManagerSelector(AddProjectController controller) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          Get.dialog(const ManagerSelectionDialog(), barrierDismissible: true);
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
                  controller.selectedManager.value?.name ?? 'Select a manager',
                  style: AppTextStyle.f14W400().copyWith(
                    color: controller.selectedManager.value != null
                        ? AppColors.text
                        : AppColors.text.withValues(alpha: 0.6),
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

  /// Build location input section
  Widget _buildLocationSection(AddProjectController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Project Location *',
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
            controller: controller.locationController,
            style: AppTextStyle.f14W400().copyWith(
              color: AppColors.text,
              height: 1.5,
            ),
            decoration: InputDecoration(
              hintText: 'Enter project location',
              hintStyle: AppTextStyle.f14W400().copyWith(
                color: AppColors.text.withValues(alpha: 0.6),
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

  /// Build create project button
  Widget _buildCreateButton(AddProjectController controller) {
    return Obx(() {
      // Reference observable values to trigger updates
      final isValid =
          controller.projectName.value.trim().isNotEmpty &&
          controller.location.value.trim().isNotEmpty &&
          controller.selectedTeam.value != null &&
          controller.selectedManager.value != null;

      return Container(
        width: double.infinity,
        height: Sizer.hp(48),
        decoration: BoxDecoration(
          color: isValid
              ? AppColors.primary
              : AppColors.primary.withValues(alpha: 0.5),
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
                  'Create Project',
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
