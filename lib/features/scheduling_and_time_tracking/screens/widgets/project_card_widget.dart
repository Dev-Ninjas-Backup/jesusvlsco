import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/time_sheet_controller.dart';

/// ProjectCardWidget displays individual project information
/// Shows project details, assigned users, and action buttons
class ProjectCardWidget extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback? onMorePressed;
  final VoidCallback? onAccessSchedule;

  const ProjectCardWidget({
    super.key,
    required this.project,
    this.onMorePressed,
    this.onAccessSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Sizer.hp(16)),
      padding: EdgeInsets.all(Sizer.wp(24)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizer.wp(8)),
        border: Border.all(color: AppColors.border),
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
          _buildProjectHeader(),
          SizedBox(height: Sizer.hp(16)),
          _buildProjectInfo(),
          SizedBox(height: Sizer.hp(16)),
          _buildActionButtons(),
        ],
      ),
    );
  }

  /// Build project header with title and project name
  Widget _buildProjectHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.title,
          style: AppTextStyle.f18W600().copyWith(
            color: AppColors.text,
            height: 1.5,
          ),
        ),
        SizedBox(height: Sizer.hp(8)),
        Text(
          project.projectName,
          style: AppTextStyle.f16W600().copyWith(
            color: AppColors.primary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  /// Build project information section with assigned users and admin
  Widget _buildProjectInfo() {
    return Column(
      children: [
        _buildAssignedSection(),
        SizedBox(height: Sizer.hp(12)),
        _buildAdminSection(),
      ],
    );
  }

  /// Build assigned users section
  Widget _buildAssignedSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Assigned',
          style: AppTextStyle.f16W500().copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        _buildUserAvatars(),
      ],
    );
  }

  /// Build admin user section
  Widget _buildAdminSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Admin',
          style: AppTextStyle.f16W500().copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: Sizer.wp(12)),
          child: CircleAvatar(
            radius: Sizer.wp(20),
            backgroundImage: NetworkImage(project.adminUser.avatar),
          ),
        ),
      ],
    );
  }

  /// Build user avatars with add button
  Widget _buildUserAvatars() {
    return Container(
      padding: EdgeInsets.only(right: Sizer.wp(14)),
      child: Row(
        children: [
          // Display assigned user avatars using Stack for overlap
          SizedBox(
            width: Sizer.wp(80), // Width for 2 overlapping avatars
            height: Sizer.wp(40),
            child: Stack(
              children: [
                // First user avatar
                if (project.assignedUsers.isNotEmpty)
                  Positioned(
                    left: 0,
                    child: CircleAvatar(
                      radius: Sizer.wp(20),
                      backgroundImage: NetworkImage(
                        project.assignedUsers[0].avatar,
                      ),
                    ),
                  ),
                // Second user avatar (overlapping)
                if (project.assignedUsers.length > 1)
                  Positioned(
                    left: Sizer.wp(26), // Overlap position
                    child: CircleAvatar(
                      radius: Sizer.wp(20),
                      backgroundImage: NetworkImage(
                        project.assignedUsers[1].avatar,
                      ),
                    ),
                  ),
                // Add user button (overlapping)
                Positioned(
                  left: Sizer.wp(52), // Position after avatars
                  child: Container(
                    width: Sizer.wp(40),
                    height: Sizer.wp(40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: AppColors.text, width: 1),
                    ),
                    child: Icon(
                      Icons.add,
                      size: Sizer.wp(24),
                      color: AppColors.text,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build action buttons section
  Widget _buildActionButtons() {
    return Row(
      children: [
        // More options button
        Container(
          width: Sizer.wp(44),
          height: Sizer.wp(44),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border2, width: 1),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onMorePressed,
              borderRadius: BorderRadius.circular(Sizer.wp(22)),
              child: Icon(
                Iconsax.more,
                size: Sizer.wp(24),
                color: AppColors.text,
              ),
            ),
          ),
        ),
        SizedBox(width: Sizer.wp(24)),
        // Access Schedule button
        Expanded(
          child: Container(
            height: Sizer.wp(44),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(Sizer.wp(50)),
              border: Border.all(color: AppColors.primary, width: 1),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onAccessSchedule,
                borderRadius: BorderRadius.circular(Sizer.wp(50)),
                child: Center(
                  child: Text(
                    'Access Schedule',
                    style: AppTextStyle.f16W500().copyWith(
                      color: Colors.white,
                      height: 1.75,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
