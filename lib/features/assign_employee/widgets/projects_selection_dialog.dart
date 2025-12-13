// widgets/project_selection_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/assign_employee/controller/user_schedule_controller.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/models/project_model.dart';

class ProjectSelectionDialog extends StatelessWidget {
  const ProjectSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScheduleController());

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
            _buildDialogHeader(controller),
            _buildProjectList(controller),
            _buildDialogActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogHeader(ScheduleController controller) {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Project',
                style: AppTextStyle.f18W600().copyWith(color: AppColors.text),
              ),
              Obx(
                () => Text(
                  '${controller.totalProjects.value} projects available',
                  style: AppTextStyle.f12W400().copyWith(
                    color: AppColors.text.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              // Refresh button
              GestureDetector(
                onTap: () => controller.refreshProjects(),
                child: Container(
                  padding: EdgeInsets.all(Sizer.wp(8)),
                  child: Icon(
                    Icons.refresh,
                    size: Sizer.wp(20),
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(width: Sizer.wp(8)),
              // Close button
              GestureDetector(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.close,
                  size: Sizer.wp(24),
                  color: AppColors.text,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectList(ScheduleController controller) {
    return Container(
      constraints: BoxConstraints(maxHeight: Sizer.hp(400)),
      child: Obx(() {
        // Show loading on first load or when refreshing
        if (controller.projects.isEmpty && controller.isLoading.value) {
          return Container(
            padding: EdgeInsets.all(Sizer.wp(40)),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: AppColors.primary),
                  SizedBox(height: Sizer.hp(16)),
                  Text(
                    'Loading projects...',
                    style: AppTextStyle.f14W400().copyWith(
                      color: AppColors.text.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Empty state
        if (controller.projects.isEmpty && !controller.isLoading.value) {
          return Container(
            padding: EdgeInsets.all(Sizer.wp(40)),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.folder_open,
                    size: Sizer.wp(48),
                    color: AppColors.text.withValues(alpha: 0.3),
                  ),
                  SizedBox(height: Sizer.hp(16)),
                  Text(
                    'No projects available',
                    style: AppTextStyle.f16W500().copyWith(
                      color: AppColors.text.withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Sizer.hp(8)),
                  Text(
                    'Try refreshing or check back later',
                    style: AppTextStyle.f14W400().copyWith(
                      color: AppColors.text.withValues(alpha: 0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Sizer.hp(16)),
                  GestureDetector(
                    onTap: () => controller.refreshProjects(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizer.wp(20),
                        vertical: Sizer.hp(8),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(Sizer.wp(8)),
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Text(
                        'Refresh',
                        style: AppTextStyle.f14W500().copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Project list with pagination
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            // Trigger pagination when user scrolls near the bottom
            if (!controller.isLoadingMoreProjects.value &&
                controller.hasMoreProjects.value &&
                scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 50) {
              // Changed from 100 to 50
              controller.loadMoreProjects();
            }
            return false;
          },
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.all(Sizer.wp(20)),
            itemCount:
                controller.projects.length +
                (controller.hasMoreProjects.value ? 1 : 0),
            separatorBuilder: (context, index) => SizedBox(height: Sizer.hp(8)),
            itemBuilder: (context, index) {
              if (index < controller.projects.length) {
                final project = controller.projects[index];
                final isSelected =
                    controller.selectedProject.value?.id == project.id;
                return _buildProjectItem(project, isSelected, controller);
              } else {
                // Loading indicator for pagination
                return Container(
                  padding: EdgeInsets.symmetric(vertical: Sizer.hp(16)),
                  child: Center(
                    child: Obx(
                      () => controller.isLoadingMoreProjects.value
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: Sizer.wp(20),
                                  height: Sizer.wp(20),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(height: Sizer.hp(8)),
                                Text(
                                  'Loading more projects...',
                                  style: AppTextStyle.f12W400().copyWith(
                                    color: AppColors.text.withValues(
                                      alpha: 0.6,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              padding: EdgeInsets.all(Sizer.wp(8)),
                              child: Text(
                                'Scroll down for more projects',
                                style: AppTextStyle.f12W400().copyWith(
                                  color: AppColors.text.withValues(alpha: 0.6),
                                ),
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

  Widget _buildProjectItem(
    ProjectModel project,
    bool isSelected,
    ScheduleController controller,
  ) {
    return GestureDetector(
      onTap: () {
        controller.selectProject(project);
        Get.back();
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
            Container(
              width: Sizer.wp(40),
              height: Sizer.wp(40),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Sizer.wp(8)),
              ),
              child: Icon(
                Icons.work_outline,
                size: Sizer.wp(20),
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: Sizer.wp(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: AppTextStyle.f16W500().copyWith(
                      color: isSelected ? AppColors.primary : AppColors.text,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Sizer.hp(4)),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: Sizer.wp(12),
                        color: AppColors.text.withValues(alpha: 0.6),
                      ),
                      SizedBox(width: Sizer.wp(4)),
                      Expanded(
                        child: Text(
                          project.projectLocation,
                          style: AppTextStyle.f12W400().copyWith(
                            color: AppColors.text.withValues(alpha: 0.6),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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

  Widget _buildDialogActions() {
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
        ],
      ),
    );
  }
}
