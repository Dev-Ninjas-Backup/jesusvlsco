import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/assign_employee/controller/user_schedule_controller.dart';

class AddUnavailabilityScreen extends StatelessWidget {
  final ScheduleController controller = Get.find();

  AddUnavailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.close, color: AppColors.primary),
        ),
        title: Text(
          "Add Unavailability",
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(20),
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.primary),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildToggleAllDay(),
            const SizedBox(height: 16),
            _buildDatePicker(context),
            const SizedBox(height: 16),
            _buildTimePickers(context),
            const SizedBox(height: 16),
            _buildNotesField(),
            const SizedBox(height: 16),
            _buildRequestButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleAllDay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Unavailable all day",
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(16),
            fontWeight: FontWeight.w500,
            color: const Color(0xFF484848),
          ),
        ),
        Obx(
          () => Switch(
            value: controller.unavailableAllDay.value,
            onChanged: (val) => controller.unavailableAllDay.value = val,
            activeColor: AppColors.primary, // Thumb color (ON)
            activeTrackColor: AppColors.primary.withOpacity(0.5), // Track (ON)
            inactiveThumbColor: Colors.grey.shade400, // Thumb (OFF)
            inactiveTrackColor: Colors.grey.shade300, // Track (OFF)
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date",
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(16),
            fontWeight: FontWeight.w500,
            color: const Color(0xFF484848),
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: controller.selectedDate.value,
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
            );
            if (picked != null) controller.selectedDate.value = picked;
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: const Color(0xFF484848)),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    "${controller.selectedDate.value.toLocal()}".split(" ")[0],
                    style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(12),
                      color: Colors.black87,
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimePickers(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: _timeBox("From", controller.startTime.value, () async {
              TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: controller.startTime.value,
              );
              if (picked != null) controller.startTime.value = picked;
            }),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _timeBox("To", controller.endTime.value, () async {
              TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: controller.endTime.value,
              );
              if (picked != null) controller.endTime.value = picked;
            }),
          ),
        ],
      ),
    );
  }

  Widget _timeBox(String label, TimeOfDay time, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(14),
            fontWeight: FontWeight.w500,
            color: const Color(0xFF949494),
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: const Color(0xFF949494)),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time.format(Get.context!),
                  style: AppTextStyle.regular().copyWith(
                    fontSize: Sizer.wp(12),
                    color: Colors.black87,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Notes",
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(16),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF484848),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller.notesController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Type here...",
            hintStyle: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(11),
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  Widget _buildRequestButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: const Color(0xFFFFE6E7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {
        Get.back();
      },
      child: Text(
        "Request Time Off",
        style: AppTextStyle.regular().copyWith(
          fontSize: Sizer.wp(16),
          fontWeight: FontWeight.w500,
          color: const Color(0xFFAB070F),
        ),
      ),
    );
  }
}
