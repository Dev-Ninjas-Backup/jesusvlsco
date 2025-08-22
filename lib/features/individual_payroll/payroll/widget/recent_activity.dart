import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/individual_payroll/payroll/controller/payroll_controller.dart';

class RecentActivitySection extends StatelessWidget {
  final IndividualPayrollController controller;
  const RecentActivitySection({super.key, required this.controller});

  Color _getActivityColor(ActivityType type) {
    switch (type) {
      case ActivityType.clockIn:
        return const Color(0xFF1EBD66);
      case ActivityType.clockOut:
        return const Color(0xFFDC1E28);
      case ActivityType.timesheetApproved:
        return const Color(0xFF1EBD66);
      case ActivityType.requestSubmitted:
        return const Color(0xFF4E53B1);
    }
  }

  IconData _getActivityIcon(ActivityType type) {
    switch (type) {
      case ActivityType.clockIn:
        return Icons.access_time;
      case ActivityType.clockOut:
        return Icons.access_time;
      case ActivityType.timesheetApproved:
        return Icons.check;
      case ActivityType.requestSubmitted:
        return Icons.note_add;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent activity",
          style: AppTextStyle.f18W600().copyWith(
            color: const Color(0xFF4E53B1),
          ),
        ),
        SizedBox(height: Sizer.hp(16)),
        Obx(() {
          return Column(
            children: controller.recentActivities.map((activity) {
              return Container(
                margin: EdgeInsets.only(bottom: Sizer.hp(16)),
                padding: EdgeInsets.all(Sizer.wp(16)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFEDEEF7)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _getActivityColor(activity.type),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _getActivityIcon(activity.type),
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: Sizer.wp(8)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity.title,
                            style: AppTextStyle.f14W400().copyWith(
                              color: const Color(0xFF484848),
                            ),
                          ),
                          SizedBox(height: Sizer.hp(8)),
                          Text(
                            activity.description,
                            style: AppTextStyle.f12W400().copyWith(
                              color: const Color(0xFF484848),
                            ),
                          ),
                        ],
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
