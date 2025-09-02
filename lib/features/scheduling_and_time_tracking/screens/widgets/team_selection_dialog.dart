import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/add_project_controller.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/models/team_model.dart';

/// Team Selection Dialog
/// Shows list of available teams with scrollable view
/// Maximum 10 teams visible at once with scroll functionality
class TeamSelectionDialog extends StatelessWidget {
  const TeamSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddProjectController>();

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: Sizer.wp(24)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Sizer.wp(12)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogHeader(),
            _buildTeamList(controller),
            _buildDialogActions(controller),
          ],
        ),
      ),
    );
  }

  /// Build dialog header with title and close button
  Widget _buildDialogHeader() {
    return Container(
      padding: EdgeInsets.all(Sizer.wp(20)),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: const Color(0xFFC8CAE7), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Select Team',
            style: AppTextStyle.f18W600().copyWith(color: AppColors.text),
          ),
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.close, size: Sizer.wp(24), color: AppColors.text),
          ),
        ],
      ),
    );
  }

  /// Build scrollable team list
  Widget _buildTeamList(AddProjectController controller) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: Sizer.hp(400), // Limit height for scrolling
      ),
      child: Obx(() {
        if (controller.teams.isEmpty && controller.isLoading.value) {
          return Container(
            padding: EdgeInsets.all(Sizer.wp(40)),
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

        if (controller.teams.isEmpty) {
          return Container(
            padding: EdgeInsets.all(Sizer.wp(40)),
            child: Text(
              'No teams available',
              style: AppTextStyle.f14W400().copyWith(
                color: AppColors.text.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!controller.isLoadingMoreTeams.value &&
                controller.hasMoreTeams.value &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              controller.loadMoreTeams();
            }
            return false;
          },
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.all(Sizer.wp(20)),
            itemCount:
                controller.teams.length +
                (controller.hasMoreTeams.value ? 1 : 0),
            separatorBuilder: (context, index) => SizedBox(height: Sizer.hp(8)),
            itemBuilder: (context, index) {
              if (index < controller.teams.length) {
                final team = controller.teams[index];
                final isSelected = controller.selectedTeam.value?.id == team.id;
                return _buildTeamItem(team, isSelected, controller);
              } else {
                // Loading indicator for pagination
                return Container(
                  padding: EdgeInsets.all(Sizer.wp(16)),
                  child: Center(
                    child: Obx(
                      () => controller.isLoadingMoreTeams.value
                          ? SizedBox(
                              width: Sizer.wp(20),
                              height: Sizer.wp(20),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.primary,
                              ),
                            )
                          : Text(
                              'Scroll to load more',
                              style: AppTextStyle.f12W400().copyWith(
                                color: AppColors.text.withValues(alpha: 0.6),
                              ),
                            ),
                    ),
                  ),
                );
              }
            },
          ),
        );
      }),
    );
  }

  /// Build individual team item
  Widget _buildTeamItem(
    TeamModel team,
    bool isSelected,
    AddProjectController controller,
  ) {
    return GestureDetector(
      onTap: () {
        controller.selectTeam(team);
        Get.back(); // Close dialog after selection
      },
      child: Container(
        padding: EdgeInsets.all(Sizer.wp(16)),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(Sizer.wp(8)),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFC8CAE7),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Team icon
            Container(
              width: Sizer.wp(40),
              height: Sizer.wp(40),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Sizer.wp(8)),
              ),
              child: Icon(
                Icons.group,
                size: Sizer.wp(20),
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: Sizer.wp(12)),
            // Team info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    team.name,
                    style: AppTextStyle.f16W500().copyWith(
                      color: isSelected ? AppColors.primary : AppColors.text,
                    ),
                  ),
                  SizedBox(height: Sizer.hp(4)),
                  Text(
                    '${team.members.length} members',
                    style: AppTextStyle.f12W400().copyWith(
                      color: AppColors.text.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            // Selection indicator
            if (isSelected)
              Icon(
                Icons.check_circle,
                size: Sizer.wp(20),
                color: AppColors.primary,
              ),
          ],
        ),
      ),
    );
  }

  /// Build dialog action buttons
  Widget _buildDialogActions(AddProjectController controller) {
    return Container(
      padding: EdgeInsets.all(Sizer.wp(20)),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: const Color(0xFFC8CAE7), width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizer.wp(8)),
                ),
                padding: EdgeInsets.symmetric(vertical: Sizer.hp(12)),
              ),
              child: Text(
                'Cancel',
                style: AppTextStyle.f14W500().copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          SizedBox(width: Sizer.wp(12)),
          Expanded(
            child: ElevatedButton(
              onPressed: controller.createNewTeam,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizer.wp(8)),
                ),
                padding: EdgeInsets.symmetric(vertical: Sizer.hp(12)),
              ),
              child: Text(
                'Create New Team',
                style: AppTextStyle.f14W500().copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
