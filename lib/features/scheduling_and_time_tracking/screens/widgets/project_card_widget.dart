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

  /// Build assigned users section (max 4 members + total count)
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

  /// Build admin section (only admin photo)
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
          child: _buildUserAvatar(
            null,
            isAdmin: true,
          ), // Admin doesn't have image in API
        ),
      ],
    );
  }

  /// Build user avatars with up to 4 members + total count
  Widget _buildUserAvatars() {
    final int totalUsers = project.projectUsers?.length ?? 0;
    final int displayCount = totalUsers > 4
        ? 3
        : totalUsers; // Show 3 if more than 4, else show all

    return Container(
      padding: EdgeInsets.only(right: Sizer.wp(14)),
      child: Row(
        children: [
          // Display assigned user avatars using Stack for overlap
          SizedBox(
            width: totalUsers > 4
                ? Sizer.wp(120) // Width for 3 avatars + total count
                : Sizer.wp(
                    80 + (displayCount > 2 ? 26 : 0),
                  ), // Dynamic width based on count
            height: Sizer.wp(40),
            child: Stack(
              children: [
                // Display up to 3 user avatars
                for (int i = 0; i < displayCount; i++)
                  Positioned(
                    left: i * Sizer.wp(26), // Overlap position
                    child: _buildUserAvatar(
                      null,
                    ), // No user images in API, use default icon
                  ),

                // Show total count if more than 4 users
                if (totalUsers > 4)
                  Positioned(
                    left: 3 * Sizer.wp(26), // Position after 3 avatars
                    child: Container(
                      width: Sizer.wp(40),
                      height: Sizer.wp(40),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          '+${totalUsers - 3}',
                          style: AppTextStyle.f14W500().copyWith(
                            color: Colors.white,
                            height: 1,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),

                // Add user button if 4 or fewer users
                if (totalUsers <= 4)
                  Positioned(
                    left: displayCount * Sizer.wp(26), // Position after avatars
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
                        size: Sizer.wp(20),
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

  /// Build user avatar with fallback to user icon
  Widget _buildUserAvatar(String? imageUrl, {bool isAdmin = false}) {
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
                  return _buildDefaultAvatar(isAdmin);
                },
              ),
            )
          : _buildDefaultAvatar(isAdmin),
    );
  }

  /// Build default avatar icon
  Widget _buildDefaultAvatar(bool isAdmin) {
    return Icon(
      isAdmin ? Iconsax.user_octagon : Iconsax.user,
      size: Sizer.wp(20),
      color: AppColors.textSecondary,
    );
  }
}
