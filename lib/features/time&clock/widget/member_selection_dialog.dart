import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/time&clock/controller/add_project_controller.dart';
import 'package:jesusvlsco/features/time&clock/models/team_model.dart';

/// Member selection dialog widget
/// Shows a scrollable list of team members with checkbox selection
class MemberSelectionDialog extends StatelessWidget {
  const MemberSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddProjectController>();

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: Sizer.wp(32)),
      child: Container(
        constraints: BoxConstraints(maxHeight: Sizer.hp(600)),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            // Scrollable member list
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Sizer.wp(24)),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return SizedBox(
                      height: Sizer.hp(200),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: controller.availableMembers
                        .map((member) => _buildMemberItem(member, controller))
                        .toList(),
                  );
                }),
              ),
            ),
            // Add button
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                left: Sizer.wp(24),
                right: Sizer.wp(24),
                bottom: Sizer.wp(24),
              ),
              child: _buildAddButton(controller),
            ),
          ],
        ),
      ),
    );
  }

  /// Build individual member item with checkbox and avatar
  Widget _buildMemberItem(MemberModel member, AddProjectController controller) {
    return Obx(() {
      final isSelected = controller.isMemberSelected(member);

      return Container(
        margin: EdgeInsets.only(bottom: Sizer.hp(24)),
        child: Row(
          children: [
            // Checkbox
            GestureDetector(
              onTap: () => controller.toggleMemberSelection(member),
              child: Container(
                width: Sizer.wp(18),
                height: Sizer.wp(18),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF1EBD66)
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1EBD66)
                        : const Color(0xFFC5C5C5),
                    width: isSelected ? 0 : 1,
                  ),
                  borderRadius: BorderRadius.circular(Sizer.wp(2)),
                ),
                child: isSelected
                    ? Icon(Icons.check, size: Sizer.wp(14), color: Colors.white)
                    : null,
              ),
            ),
            SizedBox(width: Sizer.wp(16)),
            // Member info
            Expanded(
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: Sizer.wp(40),
                    height: Sizer.wp(40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizer.wp(32)),
                      image: DecorationImage(
                        image: NetworkImage(member.avatar),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: Sizer.wp(16)),
                  // Name and position
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.name,
                          style: AppTextStyle.f16W600().copyWith(
                            color: AppColors.primary,
                            height: 1.75,
                          ),
                        ),
                        Text(
                          member.position,
                          style: AppTextStyle.f14W500().copyWith(
                            color: AppColors.textfield,
                            height: 1.75,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  /// Build add button
  Widget _buildAddButton(AddProjectController controller) {
    return Obx(() {
      return Container(
        height: Sizer.hp(44),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(Sizer.wp(8)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              controller.toggleMemberDropdown();
              Get.back();
            },
            borderRadius: BorderRadius.circular(Sizer.wp(8)),
            child: Center(
              child: Text(
                'Add',
                style: AppTextStyle.f16W600().copyWith(
                  color: Colors.white,
                  height: 1.75,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
