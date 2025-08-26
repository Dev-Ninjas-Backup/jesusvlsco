import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/common/widgets/custom_button.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/assign_employee/controller/user_schedule_controller.dart';
import 'package:jesusvlsco/features/assign_employee/views/user_add_unavailability_screen.dart';
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
        // leading: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   icon: Icon(Icons.arrow_back, color: Colors.black),
        // ),
        title: Text(
          "Assign Employee",
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(18),
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.menu, color: Colors.black),
        //     onPressed: () {},
        //   ),
        // ],
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
            // _buildProjectInfo(),
            SizedBox(height: Sizer.hp(16)),
            _buildFilterView(context),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Shift Scheduling Project 1",
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(18),
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        // CustomButton(
        //   onPressed: () {},
        //   text: 'Publish',
        //   textColor: Colors.white,
        //   decorationColor: AppColors.primary,
        //   leadingIcon: Icon(Icons.notifications_active, color: Colors.white),
        // ),
      ],
    );
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
            color: Colors.black.withOpacity(0.05),
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
                'Projects *',
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
                          color: AppColors.primary.withOpacity(0.7),
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
          // Refresh projects when dialog opens if list is empty
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
                  ? AppColors.primary.withOpacity(0.5)
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
                        : AppColors.text.withOpacity(0.6),
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

  Widget _buildProjectInfo() {
    return Obx(() {
      if (controller.selectedProject.value == null) {
        return Container(
          padding: EdgeInsets.all(Sizer.wp(20)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Sizer.wp(12)),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.info_outline,
                size: Sizer.wp(48),
                color: AppColors.primary.withOpacity(0.3),
              ),
              SizedBox(height: Sizer.hp(16)),
              Text(
                'No Project Selected',
                style: AppTextStyle.f16W500().copyWith(
                  color: AppColors.text.withOpacity(0.8),
                ),
              ),
              SizedBox(height: Sizer.hp(8)),
              Text(
                'Please select a project to view details and assign employees',
                style: AppTextStyle.f14W400().copyWith(
                  color: AppColors.text.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      final project = controller.selectedProject.value!;
      return Container(
        padding: EdgeInsets.all(Sizer.wp(16)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Sizer.wp(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
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
                Container(
                  width: Sizer.wp(40),
                  height: Sizer.wp(40),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
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
                        'Selected Project',
                        style: AppTextStyle.f12W400().copyWith(
                          color: AppColors.text.withOpacity(0.6),
                        ),
                      ),
                      Text(
                        project.title,
                        style: AppTextStyle.f16W600().copyWith(
                          color: AppColors.text,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.clearSelection(),
                  child: Container(
                    padding: EdgeInsets.all(Sizer.wp(6)),
                    child: Icon(
                      Icons.close,
                      size: Sizer.wp(16),
                      color: AppColors.text.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Sizer.hp(16)),
            _buildProjectDetailRow(
              icon: Icons.location_on_outlined,
              label: 'Location',
              value: project.projectLocation,
            ),
            SizedBox(height: Sizer.hp(12)),
            _buildProjectDetailRow(
              icon: Icons.calendar_today_outlined,
              label: 'Created',
              value: _formatDate(project.createdAt),
            ),
            SizedBox(height: Sizer.hp(12)),
            _buildProjectDetailRow(
              icon: Icons.update_outlined,
              label: 'Last Updated',
              value: _formatDate(project.updatedAt),
            ),
            SizedBox(height: Sizer.hp(20)),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to employee assignment screen
                  // You can implement this based on your navigation structure
                  Get.snackbar(
                    'Success',
                    'Ready to assign employees to ${project.title}',
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    colorText: AppColors.primary,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: Sizer.hp(14)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizer.wp(8)),
                  ),
                ),
                child: Text('Assign Employees', style: AppTextStyle.f14W600()),
              ),
            ),
          ],
        ),
      );
    });
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildProjectDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: Sizer.wp(16), color: AppColors.text.withOpacity(0.6)),
        SizedBox(width: Sizer.wp(8)),
        Text(
          '$label: ',
          style: AppTextStyle.f12W400().copyWith(
            color: AppColors.text.withOpacity(0.6),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyle.f12W400().copyWith(color: AppColors.text),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildDateRange(),
        SizedBox(width: Sizer.wp(20)),
        _buildAvailability(),
      ],
    );
  }

  Widget _buildAvailability() {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          Get.to(AddUnavailabilityScreen());
        },
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: const Color(0xFF4E53B1),
          ),

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Center(
          child: Text(
            ' Availability',
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(12),
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateRange() {
    return Expanded(
      child: InkWell(
        onTap: controller.onDatePressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Sizer.wp(15), vertical: 15),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: const Color(0xFF4E53B1),
              ),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Center(
            child: Text(
              "Aug 3",
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(12),
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildDropdownItem() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Sizer.wp(12)),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: const Color(0xFF4E53B1),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Obx(
          () => DropdownButton<String>(
            value: controller.dropdownValue.value,
            items: controller.dropdownItems
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: AppTextStyle.regular().copyWith(
                        fontSize: Sizer.wp(12),
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (val) => controller.dropdownValue.value = val!,
            underline: const SizedBox(),
            isExpanded: true,
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeAvailabilityHeader() {
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
      ],
    );
  }

  Widget _buildEmployeeList() {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.employees.length,
        itemBuilder: (context, index) {
          final emp = controller.employees[index];
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        emp["image"]!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              emp["name"]!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          emp["role"]!,
                          style: const TextStyle(
                            color: Color(0xFF4F46E5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text("Off Day: ${emp["offDay"]}"),
                      ],
                    ),
                  ],
                ),
              ),
              // Add plus buttons only after the first employee
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
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
              ),
              const SizedBox(height: 12),
            ],
          );
        },
      ),
    );
  }
}
