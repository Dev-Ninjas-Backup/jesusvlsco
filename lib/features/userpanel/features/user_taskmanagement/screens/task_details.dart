import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/features/taskmanagement/widgets/common_button.dart';
import 'package:jesusvlsco/features/userpanel/features/user_taskmanagement/controllers/task_controller.dart';

class TaskDetails extends StatelessWidget {
  final User_Taskcontroller controller = Get.put(User_Taskcontroller());

  TaskDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: Custom_appbar(title: "Task Details"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTimerSection(),
              const SizedBox(height: 24),
              _buildProjectTitle(),
              const SizedBox(height: 16),
              _buildTaskTypeToggle(),
              const SizedBox(height: 20),
              _buildInfoSection('Description', controller.description),
              const SizedBox(height: 16),
              const Divider(color: AppColors.dividerColor, thickness: 0.5),
              _buildInfoSection('Assigned to', controller.assignedTo, valueColor: const Color(0xFF6366F1)),
              const Divider(color: AppColors.dividerColor, thickness: 0.5),
              const SizedBox(height: 16),
              _buildDateSection(),
              const SizedBox(height: 16),
              const Divider(color: AppColors.dividerColor, thickness: 0.5),
              const Spacer(),
              _buildBottomButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimerSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.border3,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.access_time,
                    color: Color(0xFF00C851),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Obx(
                    () => Text(
                      controller.elapsedTime.value,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00C851),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              customButton(
                width: double.infinity,
                bgcolor: AppColors.primary,
                brcolor: AppColors.background,
                text: "Start Task",
                textcolor: AppColors.background,
                onPressed: () {},
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProjectTitle() {
    return Obx(
      () => Text(
        controller.projectTitle.value,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1F2937),
        ),
      ),
    );
  }

  Widget _buildTaskTypeToggle() {
    return Obx(
      () => Row(
        children: [
          _buildToggleButton(
            'General tasks',
            !controller.showAllTasks.value,
            () => controller.setTaskView(false),
          ),
          const SizedBox(width: 8),
          _buildToggleButton(
            'All Tasks',
            controller.showAllTasks.value,
            () => controller.setTaskView(true),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, RxString value, {Color valueColor = const Color(0xFF6B7280)}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.backgroundDark,
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => Text(
            value.value,
            style: TextStyle(
              fontSize: 14,
              color: valueColor,
              height: 1.4,
              fontWeight: valueColor == const Color(0xFF6366F1) ? FontWeight.w500 : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSection() {
    return Row(
      children: [
        Expanded(
          child: _buildDateContainer(
            'Start time',
            controller.startTime,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildDateContainer(
            'End time',
            controller.endTime,
          ),
        ),
      ],
    );
  }

  Widget _buildDateContainer(String title, RxString time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD1D5DB)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 16,
                color: Color(0xFF6B7280),
              ),
              const SizedBox(width: 8),
              Obx(
                () => Text(
                  time.value,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.backgroundDark,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      children: [
        Expanded(
          child: customButton(
            width: double.infinity,
            bgcolor: AppColors.primary,
            brcolor: AppColors.background,
            text: "Add Atachment",
            textcolor: AppColors.background,
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: customButton(
            width: double.infinity,
            bgcolor: AppColors.primary,
            brcolor: AppColors.background,
            text: "Start Task",
            textcolor: AppColors.background,
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.viewcolor : AppColors.primaryBackground,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? AppColors.progresstext : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }
}
