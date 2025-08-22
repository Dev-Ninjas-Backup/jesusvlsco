import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/individual_payroll/payroll/controller/payroll_controller.dart';

class MyRequestsSection extends StatelessWidget {
  final IndividualPayrollController controller;
  const MyRequestsSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Requests",
          style: AppTextStyle.f18W600().copyWith(
            color: const Color(0xFF4E53B1),
          ),
        ),
        SizedBox(height: Sizer.hp(16)),
        Obx(() {
          return Column(
            children: controller.myRequests.map((request) {
              return Container(
                margin: EdgeInsets.only(bottom: Sizer.hp(16)),
                padding: EdgeInsets.all(Sizer.wp(16)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFEDEEF7)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            request.dateRange,
                            style: AppTextStyle.f14W400().copyWith(
                              color: const Color(0xFF484848),
                            ),
                          ),
                          SizedBox(height: Sizer.hp(8)),
                          Text(
                            request.description,
                            style: AppTextStyle.f12W400().copyWith(
                              color: const Color(0xFF484848),
                            ),
                          ),
                          SizedBox(height: Sizer.hp(16)),
                          if (request.status == PayrollRequestStatus.pending)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Sizer.wp(20),
                                vertical: Sizer.hp(8),
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFE6E7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                onTap: () =>
                                    controller.cancelRequest(request.id),
                                child: Text(
                                  "Cancel request",
                                  style: AppTextStyle.f16W500().copyWith(
                                    color: const Color(0xFFAB070F),
                                  ),
                                ),
                              ),
                            ),
                          if (request.status == PayrollRequestStatus.approved)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Sizer.wp(20),
                                vertical: Sizer.hp(8),
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD9F0E4),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Approved",
                                style: AppTextStyle.f16W500().copyWith(
                                  color: const Color(0xFF1EBD66),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      request.status == PayrollRequestStatus.pending
                          ? "Pending"
                          : "",
                      style: AppTextStyle.f14W400().copyWith(
                        color: const Color(0xFFFFBA5C),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}
