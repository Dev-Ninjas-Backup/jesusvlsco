import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/add_project_controller.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/models/team_model.dart';

/// Manager Selection Dialog
/// Shows list of available managers with scrollable view
/// Similar to team selection but for manager selection
class ManagerSelectionDialog extends StatelessWidget {
  const ManagerSelectionDialog({super.key});

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
            _buildManagerList(controller),
            _buildDialogActions(),
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
            'Select Manager',
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

  /// Build scrollable manager list
  Widget _buildManagerList(AddProjectController controller) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: Sizer.hp(400), // Limit height for scrolling
      ),
      child: Obx(() {
        if (controller.availableManagers.isEmpty &&
            controller.isLoading.value) {
          return Container(
            padding: EdgeInsets.all(Sizer.wp(40)),
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

        if (controller.availableManagers.isEmpty) {
          return Container(
            padding: EdgeInsets.all(Sizer.wp(40)),
            child: Text(
              'No managers available',
              style: AppTextStyle.f14W400().copyWith(
                color: AppColors.text.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!controller.isLoadingMoreManagers.value &&
                controller.hasMoreManagers.value &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              controller.loadMoreManagers();
            }
            return false;
          },
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.all(Sizer.wp(20)),
            itemCount:
                controller.availableManagers.length +
                (controller.hasMoreManagers.value ? 1 : 0),
            separatorBuilder: (context, index) => SizedBox(height: Sizer.hp(8)),
            itemBuilder: (context, index) {
              if (index < controller.availableManagers.length) {
                final manager = controller.availableManagers[index];
                final isSelected =
                    controller.selectedManager.value?.id == manager.id;
                return _buildManagerItem(manager, isSelected, controller);
              } else {
                // Loading indicator for pagination
                return Container(
                  padding: EdgeInsets.all(Sizer.wp(16)),
                  child: Center(
                    child: Obx(
                      () => controller.isLoadingMoreManagers.value
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

  /// Build individual manager item
  Widget _buildManagerItem(
    MemberModel manager,
    bool isSelected,
    AddProjectController controller,
  ) {
    return GestureDetector(
      onTap: () {
        controller.selectManager(manager);
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
            // Manager avatar
            Container(
              width: Sizer.wp(40),
              height: Sizer.wp(40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizer.wp(20)),
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
              child:
                  manager.avatar.isNotEmpty &&
                      manager.avatar != 'https://i.pravatar.cc/150?img=1'
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(Sizer.wp(20)),
                      child: Image.network(
                        manager.avatar,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person,
                            size: Sizer.wp(24),
                            color: AppColors.primary,
                          );
                        },
                      ),
                    )
                  : Icon(
                      Icons.person,
                      size: Sizer.wp(24),
                      color: AppColors.primary,
                    ),
            ),
            SizedBox(width: Sizer.wp(12)),
            // Manager info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    manager.name,
                    style: AppTextStyle.f16W500().copyWith(
                      color: isSelected ? AppColors.primary : AppColors.text,
                    ),
                  ),
                  SizedBox(height: Sizer.hp(4)),
                  Text(
                    manager.position,
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
  Widget _buildDialogActions() {
    return Container(
      padding: EdgeInsets.all(Sizer.wp(20)),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: const Color(0xFFC8CAE7), width: 1),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
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
            style: AppTextStyle.f14W500().copyWith(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
