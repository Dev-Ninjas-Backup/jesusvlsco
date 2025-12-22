import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/assign_employee/controller/user_schedule_controller.dart';
import 'package:jesusvlsco/features/assign_employee/models/assign_user_response_model.dart';
import 'package:jesusvlsco/features/assign_employee/widgets/projects_selection_dialog.dart';

class AssignEmployeeScreen extends StatelessWidget {
  final ScheduleController controller = Get.put(ScheduleController());

  AssignEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Employee Schedul",
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(18),
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Sizer.hp(16)),
            _buildHeaderView(),
            SizedBox(height: Sizer.hp(16)),
            _buildProjectSelectionSection(),
            SizedBox(height: Sizer.hp(16)),
            // _buildFilterView(context),
            const SizedBox(height: 24),
            _buildEmployeeAvailabilityHeader(),
            SizedBox(height: Sizer.hp(16)),
            _buildEmployeeList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderView() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              controller.selectedProject.value?.title ?? "Shift Checking",
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(18),
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildProjectSelectionSection() {
    return Container(
      padding: EdgeInsets.only(
        top: Sizer.hp(16),
        left: Sizer.wp(10),
        right: Sizer.wp(10),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizer.wp(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Assigned Projects *',
                style: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(14),
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Obx(
                () => controller.isLoading.value
                    ? SizedBox(
                        width: Sizer.wp(16),
                        height: Sizer.wp(16),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primary,
                        ),
                      )
                    : GestureDetector(
                        onTap: () => controller.refreshProjects(),
                        child: Icon(
                          Icons.refresh,
                          size: Sizer.wp(20),
                          color: AppColors.primary.withValues(alpha: 0.7),
                        ),
                      ),
              ),
            ],
          ),
          SizedBox(height: Sizer.hp(12)),
          _buildProjectSelector(),
        ],
      ),
    );
  }

  Widget _buildProjectSelector() {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          if (controller.projects.isEmpty && !controller.isLoading.value) {
            controller.refreshProjects();
          }
          Get.dialog(const ProjectSelectionDialog(), barrierDismissible: true);
        },
        child: Container(
          height: Sizer.hp(48),
          padding: EdgeInsets.symmetric(horizontal: Sizer.wp(12)),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(Sizer.wp(8)),
            border: Border.all(
              color: controller.selectedProject.value != null
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : const Color(0xFFC8CAE7),
              width: 1,
            ),
          ),

          child: Row(
            children: [
              Expanded(
                child: Text(
                  controller.selectedProject.value?.title ??
                      'Select a project to continue',
                  style: AppTextStyle.f14W400().copyWith(
                    color: controller.selectedProject.value != null
                        ? AppColors.text
                        : AppColors.text.withValues(alpha: 0.6),
                    height: 1.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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

  // Widget _buildFilterView(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: [
  //       _buildDateRange(),
  //       SizedBox(width: Sizer.wp(20)),
  //       _buildAvailability(),
  //     ],
  //   );
  // }

  // Widget _buildAvailability() {
  //   return Expanded(
  //     child: OutlinedButton(
  //       onPressed: () {
  //         Get.to(AddUnavailabilityScreen());
  //       },
  //       style: OutlinedButton.styleFrom(
  //         padding: EdgeInsets.symmetric(vertical: 15),
  //         side: BorderSide(
  //           width: 1,
  //           strokeAlign: BorderSide.strokeAlignOutside,
  //           color: const Color(0xFF4E53B1),
  //         ),
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
  //       ),
  //       child: Center(
  //         child: Text(
  //           'Availability',
  //           style: AppTextStyle.regular().copyWith(
  //             fontSize: Sizer.wp(12),
  //             color: AppColors.primary,
  //             fontWeight: FontWeight.w700,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildDateRange() {
  //   return Expanded(
  //     child: Obx(() {
  //       return InkWell(
  //         onTap: controller.onDateRangePressed,
  //         child: Container(
  //           padding: EdgeInsets.symmetric(
  //             horizontal: Sizer.wp(12),
  //             vertical: 15,
  //           ),
  //           decoration: ShapeDecoration(
  //             shape: RoundedRectangleBorder(
  //               side: BorderSide(
  //                 width: 1,
  //                 strokeAlign: BorderSide.strokeAlignOutside,
  //                 color: controller.hasDateRange
  //                     ? AppColors.primary
  //                     : const Color(0xFF4E53B1),
  //               ),
  //               borderRadius: BorderRadius.circular(6),
  //             ),
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Expanded(
  //                 child: Text(
  //                   controller.dateRangeText,
  //                   style: AppTextStyle.regular().copyWith(
  //                     fontSize: Sizer.wp(11),
  //                     color: controller.hasDateRange
  //                         ? AppColors.primary
  //                         : AppColors.primary,
  //                     fontWeight: FontWeight.w700,
  //                   ),
  //                   textAlign: TextAlign.center,
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ),
  //               if (controller.hasDateRange) ...[
  //                 SizedBox(width: Sizer.wp(4)),
  //                 GestureDetector(
  //                   onTap: controller.clearDateRange,
  //                   child: Icon(
  //                     Icons.clear,
  //                     size: Sizer.wp(16),
  //                     color: AppColors.primary,
  //                   ),
  //                 ),
  //               ],
  //             ],
  //           ),
  //         ),
  //       );
  //     }),
  //   );
  // }

  Widget _buildEmployeeAvailabilityHeader() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Employee Availability",
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(16),
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (controller.assignedUsers.isNotEmpty) ...[
            Text(
              "${controller.assignedUsers.length} employees",
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(14),
                color: AppColors.text.withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      );
    });
  }

  Widget _buildEmployeeList() {
    return Expanded(
      child: Obx(() {
        if (controller.selectedProject.value == null) {
          return _buildNoProjectSelected();
        }

        if (controller.isLoadingAssignedUsers.value) {
          return _buildLoadingState();
        }

        if (controller.assignedUsers.isEmpty) {
          return _buildNoEmployeesFound();
        }

        return ListView.builder(
          itemCount: controller.assignedUsers.length,
          itemBuilder: (context, index) {
            final assignedUser = controller.assignedUsers[index];
            return _buildEmployeeCard(assignedUser);
          },
        );
      }),
    );
  }

  Widget _buildNoProjectSelected() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.work_outline,
            size: Sizer.wp(64),
            color: AppColors.primary.withValues(alpha: 0.3),
          ),
          SizedBox(height: Sizer.hp(16)),
          Text(
            'No Project Selected',
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(18),
              color: AppColors.text.withValues(alpha: 0.8),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Sizer.hp(8)),
          Text(
            'Please select a project to view assigned employees',
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(14),
              color: AppColors.text.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primary),
          SizedBox(height: Sizer.hp(16)),
          Text(
            'Loading employees...',
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(16),
              color: AppColors.text.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoEmployeesFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off_outlined,
            size: Sizer.wp(64),
            color: AppColors.primary.withValues(alpha: 0.3),
          ),
          SizedBox(height: Sizer.hp(16)),
          Text(
            'No Employees Found',
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(18),
              color: AppColors.text.withValues(alpha: 0.8),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Sizer.hp(8)),
          Text(
            'No employees are assigned to this project',
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(14),
              color: AppColors.text.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeCard(AssignedUserData assignedUser) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEmployeeAvatar(assignedUser.user),
              const SizedBox(width: 16),
              Expanded(child: _buildEmployeeInfo(assignedUser.user)),
            ],
          ),
        ),
        SizedBox(height: Sizer.hp(12)),
        _buildShiftCards(assignedUser.shifts),
        SizedBox(height: Sizer.hp(20)),
      ],
    );
  }

  Widget _buildEmployeeAvatar(UserModel user) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primary.withValues(alpha: 0.1),
      ),
      child: user.profileUrl.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                user.profileUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildDefaultAvatar(user),
              ),
            )
          : _buildDefaultAvatar(user),
    );
  }

  Widget _buildDefaultAvatar(UserModel user) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primary.withValues(alpha: 0.1),
      ),
      child: Center(
        child: Text(
          user.firstName.isNotEmpty && user.lastName.isNotEmpty
              ? '${user.firstName[0]}${user.lastName[0]}'
              : user.email[0].toUpperCase(),
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(24),
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeInfo(UserModel user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                user.fullName,
                style: AppTextStyle.regular().copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: Sizer.wp(16),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: user.isAvailable ? Colors.green : Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: AppTextStyle.regular().copyWith(
            color: const Color(0xFF4F46E5),
            fontWeight: FontWeight.w500,
            fontSize: Sizer.wp(14),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Off Days: ${user.formattedOffDays}",
          style: AppTextStyle.regular().copyWith(
            color: AppColors.text.withValues(alpha: 0.7),
            fontSize: Sizer.wp(12),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          user.isAvailable ? "Available" : "Not Available",
          style: AppTextStyle.regular().copyWith(
            color: user.isAvailable ? Colors.green : Colors.red,
            fontWeight: FontWeight.w500,
            fontSize: Sizer.wp(12),
          ),
        ),
      ],
    );
  }

  Widget _buildShiftCards(List<ShiftModel> shifts) {
    if (shifts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            4,
            (i) => Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 234, 233, 233),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.add, color: Colors.grey),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          ...shifts.take(4).map((shift) => _buildShiftCard(shift)),
          ...List.generate(
            (4 - shifts.length).clamp(0, 4),
            (i) => Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 234, 233, 233),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.add, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftCard(ShiftModel shift) {
    Color statusColor;
    switch (shift.shiftStatus.toLowerCase()) {
      case 'published':
        statusColor = AppColors.primary;
        break;
      case 'draft':
        statusColor = Colors.orange;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      width: Sizer.wp(100),
      height: Sizer.hp(100),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            shift.formattedDate,
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(13),
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
          SizedBox(height: Sizer.wp(3)),
          Text(
            shift.formattedViewerTime,
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(12),
              color: statusColor.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
          SizedBox(height: Sizer.wp(3)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              shift.shiftStatus,
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(12),
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
