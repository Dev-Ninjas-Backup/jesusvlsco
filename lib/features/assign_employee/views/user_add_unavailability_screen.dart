import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/assign_employee/controller/user_time_off_request_controller.dart';

class AddUnavailabilityScreen extends StatelessWidget {
  final TimeOffController controller = Get.put(TimeOffController());

  AddUnavailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildToggleAllDay(),
              const SizedBox(height: 16),
              _buildDateRangePickers(context),
              const SizedBox(height: 16),
              _buildTypeDropdown(),
              const SizedBox(height: 16),
              _buildNotesField(),
              const SizedBox(height: 16),
              _buildDaysCounter(),
              const SizedBox(height: 24),
              _buildRequestButton(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Get.back(),
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
            value: controller.isFullDayOff.value,
            onChanged: (val) => controller.isFullDayOff.value = val,
            activeThumbColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
            inactiveThumbColor: Colors.grey.shade400,
            inactiveTrackColor: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  Widget _buildDateRangePickers(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Date Range",
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(16),
            fontWeight: FontWeight.w500,
            color: const Color(0xFF484848),
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: _dateBox(
                  label: "Start Date",
                  date: controller.selectedStartDate.value,
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: controller.selectedStartDate.value,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    controller.setStartDate(picked!);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _dateBox(
                  label: "End Date",
                  date: controller.selectedEndDate.value,
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: controller.selectedEndDate.value,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    controller.setEndDate(picked!);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dateBox({
    required String label,
    required DateTime date,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
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
            Text(
              DateFormat("yyyy-MM-dd").format(date),
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(12),
                color: Colors.black87,
              ),
            ),
            const Icon(Icons.calendar_today, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Request Type",
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(16),
            fontWeight: FontWeight.w500,
            color: const Color(0xFF484848),
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => DropdownButtonFormField<TimeOffRequestType>(
            initialValue: controller.selectedType.value,
            items: TimeOffRequestType.values.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(type.name.replaceAll("_", " ")),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) controller.selectedType.value = val;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
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
          "Reason",
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(16),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF484848),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller.reasonController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Enter your reason...",
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

  Widget _buildDaysCounter() {
    return Obx(
      () => Text(
        "Total Days Off: ${controller.totalDaysOff.value}",
        style: AppTextStyle.regular().copyWith(
          fontSize: Sizer.wp(14),
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildRequestButton() {
    return Obx(
      () => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: const Color(0xFFFFE6E7),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: controller.isSubmitting.value
            ? null
            : () {
                controller.submitTimeOffRequest();
              },
        child: controller.isSubmitting.value
            ? const CircularProgressIndicator(color: Colors.red)
            : Text(
                "Request Time Off",
                style: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(16),
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFAB070F),
                ),
              ),
      ),
    );
  }
}
