import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/individual_payroll/payroll/controller/payroll_controller.dart';

class ActionButtons extends StatelessWidget {
  final IndividualPayrollController controller;
  const ActionButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: Sizer.hp(40),
            decoration: BoxDecoration(
              color: const Color(0xFF4E53B1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: controller.addPayrollEntry,
              borderRadius: BorderRadius.circular(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add, color: Colors.white, size: 20),
                  SizedBox(width: Sizer.wp(8)),
                  Text(
                    "Add",
                    style: AppTextStyle.f16W500().copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: Sizer.wp(8)),
        Expanded(
          child: Obx(() {
            return Container(
              height: Sizer.hp(40),
              decoration: BoxDecoration(
                color: const Color(0xFF1EBD66),
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: controller.isSubmitting.value
                    ? null
                    : controller.submitPayroll,
                borderRadius: BorderRadius.circular(8),
                child: Center(
                  child: controller.isSubmitting.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          "Submit",
                          style: AppTextStyle.f16W500().copyWith(
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
