import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/shift_scheduling_controller.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/project_card_widget.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/project_card_shimmer.dart';

import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/time_sheet_appbar.dart';

class TimeSheetScreen extends StatelessWidget {
  const TimeSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TimeSheetController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const TimeSheetAppBar(title: "Shift Scheduling"),

      body: Padding(
        padding: EdgeInsets.only(
          top: Sizer.hp(30),
          left: Sizer.wp(16),
          right: Sizer.wp(16),
        ),
        child: Column(
          children: [
            _buildHeader(context, controller),
            SizedBox(height: Sizer.hp(24)),
            _buildSearchSection(),
            SizedBox(height: Sizer.hp(24)),
            Expanded(child: _buildProjectsList(controller)),
          ],
        ),
      ),
    );
  }

  /// Build header section with title and add button
  Widget _buildHeader(BuildContext context, TimeSheetController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Job Scheduling Lobby',
          style: AppTextStyle.f18W600().copyWith(
            color: AppColors.primary,
            height: 1.5,
          ),
        ),
        Container(
          height: Sizer.hp(40),
          padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(Sizer.wp(6)),
          ),
          child: InkWell(
            onTap: () => controller.addNewProject(context),
            borderRadius: BorderRadius.circular(Sizer.wp(6)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, size: Sizer.wp(24), color: Colors.white),
                SizedBox(width: Sizer.wp(12)),
                Text(
                  'Add new',
                  style: AppTextStyle.f16W500().copyWith(
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Build search section with title and search field
  Widget _buildSearchSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Active Projects',
          style: AppTextStyle.f16W600().copyWith(
            color: AppColors.text,
            height: 1.5,
          ),
        ),
        SizedBox(height: Sizer.hp(8)),
        _buildSearchField(),
      ],
    );
  }

  /// Build search input field
  Widget _buildSearchField() {
    final controller = Get.find<TimeSheetController>();

    return Container(
      height: Sizer.hp(48),
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizer.wp(8)),
        border: Border.all(color: AppColors.textfield, width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA9B7DD).withValues(alpha: 0.08),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: controller.updateSearchText,
              style: AppTextStyle.f14W400().copyWith(
                color: AppColors.text,
                height: 1.45,
              ),
              decoration: InputDecoration(
                hintText: 'Search projects',
                hintStyle: AppTextStyle.f14W400().copyWith(
                  color: AppColors.textfield,
                  height: 1.45,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          Image.asset(
            'assets/icons/search.png',
            width: Sizer.wp(20),
            height: Sizer.hp(20),
            color: AppColors.textfield,
          ),
        ],
      ),
    );
  }

  /// Build projects list with pull to refresh and pagination
  Widget _buildProjectsList(TimeSheetController controller) {
    return Obx(() {
      if (controller.isLoading.value && controller.projects.isEmpty) {
        return ListView.builder(
          itemCount: 5, // Show 5 shimmer cards
          itemBuilder: (context, index) => const ProjectCardShimmer(),
        );
      }

      final projects = controller.filteredProjects;

      if (projects.isEmpty && !controller.isLoading.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.folder_minus,
                size: Sizer.wp(64),
                color: AppColors.textfield,
              ),
              SizedBox(height: Sizer.hp(16)),
              Text(
                'No projects found',
                style: AppTextStyle.f16W500().copyWith(
                  color: AppColors.textfield,
                  height: 1.5,
                ),
              ),
              SizedBox(height: Sizer.hp(8)),
              TextButton(
                onPressed: () => controller.refreshProjects(),
                child: Text(
                  'Tap to refresh',
                  style: AppTextStyle.f14W500().copyWith(
                    color: AppColors.primary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: controller.refreshProjects,
        color: AppColors.primary,
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            // Load more when reaching near the end (85% of scroll)
            if (scrollInfo is ScrollEndNotification &&
                scrollInfo.metrics.pixels / scrollInfo.metrics.maxScrollExtent >
                    0.85) {
              controller.loadMoreProjects();
            }
            return false;
          },
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount:
                projects.length +
                (controller.hasMoreData.value ||
                        controller.searchHasMoreData.value
                    ? 1
                    : 0),
            itemBuilder: (context, index) {
              // Show loading indicator at the end if there's more data
              if (index == projects.length) {
                return Obx(() {
                  if (controller.isLoadingMore.value) {
                    return Container(
                      padding: EdgeInsets.all(Sizer.wp(16)),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                });
              }

              final project = projects[index];
              return ProjectCardWidget(
                project: project,
                onMorePressed: () => controller.showProjectOptions(project),
                onAccessSchedule: () =>
                    controller.accessSchedule(project, context),
              );
            },
          ),
        ),
      );
    });
  }
}
