import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/models/project_model.dart';

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

  /// Build project header with title and project location
  Widget _buildProjectHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Job Scheduling',
          style: AppTextStyle.f18W600().copyWith(
            color: AppColors.text,
            height: 1.5,
          ),
        ),
        SizedBox(height: Sizer.hp(8)),
        Text(
          project.title,
          style: AppTextStyle.f16W600().copyWith(
            color: AppColors.primary,
            height: 1.5,
          ),
        ),
        if (project.projectLocation.isNotEmpty) ...[
          SizedBox(height: Sizer.hp(4)),
          Row(
            children: [
              Icon(
                Iconsax.location,
                size: Sizer.wp(16),
                color: AppColors.textSecondary,
              ),
              SizedBox(width: Sizer.wp(4)),
              Expanded(
                child: Text(
                  project.projectLocation,
                  style: AppTextStyle.f14W400().copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  /// Build project information section with team and manager
  Widget _buildProjectInfo() {
    return Column(
      children: [
        _buildTeamSection(),
        SizedBox(height: Sizer.hp(12)),
        _buildManagerSection(),
      ],
    );
  }

  /// Build team section
  Widget _buildTeamSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Team',
          style: AppTextStyle.f16W500().copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        Row(
          children: [
            // Team image or icon
            _buildUserAvatar(project.team.image, isTeam: true),
            SizedBox(width: Sizer.wp(8)),
            // Team name and department
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  project.team.title,
                  style: AppTextStyle.f14W500().copyWith(
                    color: AppColors.text,
                    height: 1.4,
                  ),
                ),
                Text(
                  project.team.department,
                  style: AppTextStyle.f12W400().copyWith(
                    color: AppColors.textSecondary,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// Build manager section
  Widget _buildManagerSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Manager',
          style: AppTextStyle.f16W500().copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        Row(
          children: [
            // Manager avatar (no image in API, so use icon)
            _buildUserAvatar(null),
            SizedBox(width: Sizer.wp(8)),
            // Manager email and role
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  project.manager.email.split('@')[0], // Display first part of email
                  style: AppTextStyle.f14W500().copyWith(
                    color: AppColors.text,
                    height: 1.4,
                  ),
                ),
                Text(
                  project.manager.role,
                  style: AppTextStyle.f12W400().copyWith(
                    color: AppColors.textSecondary,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// Build user avatar with fallback to user icon
  Widget _buildUserAvatar(String? imageUrl, {bool isTeam = false}) {
    return Container(
      width: Sizer.wp(40),
      height: Sizer.wp(40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.background,
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: imageUrl != null && imageUrl.isNotEmpty
          ? ClipOval(
              child: Image.network(
                imageUrl,
                width: Sizer.wp(40),
                height: Sizer.wp(40),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildDefaultAvatar(isTeam);
                },
              ),
            )
          : _buildDefaultAvatar(isTeam),
    );
  }

  /// Build default avatar icon
  Widget _buildDefaultAvatar(bool isTeam) {
    return Icon(
      isTeam ? Iconsax.people : Iconsax.user,
      size: Sizer.wp(20),
      color: AppColors.textSecondary,
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
