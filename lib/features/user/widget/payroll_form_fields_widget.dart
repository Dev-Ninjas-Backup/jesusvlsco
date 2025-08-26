import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../controller/add_user_controller.dart';

class PayrollFormFieldsWidget extends StatelessWidget {
  const PayrollFormFieldsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddUserController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Payroll cycle & Time-off Section
        const Text(
          'Payroll cycle & Time-off',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),

        // Pay rate
        const Text(
          'Pay rate',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),

        GestureDetector(
          onTap: () => controller.selectPayRateTypeBottomSheet(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Regular',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Obx(
                    () => Text(
                      controller.selectedPayRateType.value != null
                          ? 'X per ${controller.selectedPayRateType.value!.toLowerCase()}'
                          : 'X per hour',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),
        // Regular pay amount input
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: TextFormField(
            controller: controller.regularPayRateController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              hintText: 'Enter regular pay amount',
              border: InputBorder.none,
            ),
          ),
        ),

        const SizedBox(height: 16),

        GestureDetector(
          onTap: () => controller.selectOvertimeRateTypeBottomSheet(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Overtime',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Obx(
                    () => Text(
                      controller.selectedOvertimeRateType.value != null
                          ? 'X per ${controller.selectedOvertimeRateType.value!.toLowerCase()}'
                          : 'X per hour',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),
        // Overtime pay amount input
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: TextFormField(
            controller: controller.overtimePayRateController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              hintText: 'Enter overtime pay amount',
              border: InputBorder.none,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Time-off Section
        const Text(
          'Time-off',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),

        GestureDetector(
          onTap: () => controller.selectCasualLeaveBottomSheet(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    controller.selectedCasualLeave.value != null
                        ? 'Casual leave: ${controller.selectedCasualLeave.value}'
                        : 'Casual leave: 10 days',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        GestureDetector(
          onTap: () => controller.selectSickLeaveBottomSheet(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    controller.selectedSickLeave.value != null
                        ? 'Sick leave: ${controller.selectedSickLeave.value}'
                        : 'Sick leave: 10 days',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Offday & Break time Section
        const Text(
          'Offday & Break time',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),

        const Text(
          'Select off day here',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),

        GestureDetector(
          onTap: () => controller.selectOffDayBottomSheet(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    controller.selectedOffDay.value ?? 'Select Day here',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'Break Time',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),

        GestureDetector(
          onTap: () => controller.selectBreakTimeBottomSheet(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    controller.selectedBreakTime.value ?? 'Select Time here',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
