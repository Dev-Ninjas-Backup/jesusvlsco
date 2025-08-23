import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/individual_payroll/payroll/controller/payroll_controller.dart';

class UserProfileSection extends StatelessWidget {
  final IndividualPayrollController controller;
  const UserProfileSection({super.key, required this.controller});

  Widget _buildHoursInput(
    String title,
    RxDouble hours,
    VoidCallback increment,
    VoidCallback decrement,
  ) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyle.f14W400().copyWith(
            color: const Color(0xFF484848),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: Sizer.hp(8)),
        Container(
          padding: EdgeInsets.all(Sizer.wp(12)),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFC8CAE7)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Obx(() {
                return Text(
                  hours.value.toStringAsFixed(2),
                  style: AppTextStyle.f16W500().copyWith(
                    color: const Color(0xFF484848),
                  ),
                );
              }),
              SizedBox(height: Sizer.hp(8)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: decrement,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4E53B1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: increment,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4E53B1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Sizer.wp(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEDEEF7)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA9B7DD).withAlpha(20),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: const Color(0xFF4E53B1),
                child: Text(
                  "RF",
                  style: AppTextStyle.f16W600().copyWith(color: Colors.white),
                ),
              ),
              SizedBox(height: Sizer.hp(12)),
              Text(
                "Robert Fox",
                style: AppTextStyle.f16W600().copyWith(
                  color: const Color(0xFF4E53B1),
                ),
              ),
              SizedBox(height: Sizer.hp(8)),
              InkWell(
                onTap: controller.chatWithAdmin,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline,
                      size: 18,
                      color: Color(0xFF4E53B1),
                    ),
                    SizedBox(width: Sizer.wp(8)),
                    Text(
                      "Chat with admin",
                      style: AppTextStyle.f16W500().copyWith(
                        color: const Color(0xFF4E53B1),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Sizer.hp(24)),
          Row(
            children: [
              Expanded(
                child: _buildHoursInput(
                  "Regular",
                  controller.regularHours,
                  controller.incrementRegularHours,
                  controller.decrementRegularHours,
                ),
              ),
              SizedBox(width: Sizer.wp(8)),
              Expanded(
                child: _buildHoursInput(
                  "Overtime",
                  controller.overtimeHours,
                  controller.incrementOvertimeHours,
                  controller.decrementOvertimeHours,
                ),
              ),
              SizedBox(width: Sizer.wp(8)),
              Expanded(
                child: _buildHoursInput(
                  "Paid time off",
                  controller.paidTimeOffHours,
                  controller.incrementPaidTimeOff,
                  controller.decrementPaidTimeOff,
                ),
              ),
            ],
          ),
          SizedBox(height: Sizer.hp(24)),
          Container(
            padding: EdgeInsets.all(Sizer.wp(12)),
            decoration: BoxDecoration(
              color: const Color(0xFFE4E5F3),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFA9B7DD).withAlpha(20),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Paid Hours - ",
                    style: AppTextStyle.f14W400().copyWith(
                      color: const Color(0xFF484848),
                    ),
                  ),
                  Text(
                    controller.totalPaidHours.toStringAsFixed(2),
                    style: AppTextStyle.f16W500().copyWith(
                      color: const Color(0xFF484848),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
