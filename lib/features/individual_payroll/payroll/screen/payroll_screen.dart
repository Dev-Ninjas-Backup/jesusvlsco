import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/individual_payroll/payroll/controller/payroll_controller.dart';
import 'package:jesusvlsco/features/individual_payroll/payroll/widget/action_buttons.dart';
import 'package:jesusvlsco/features/individual_payroll/payroll/widget/my_requests.dart';
import 'package:jesusvlsco/features/individual_payroll/payroll/widget/recent_activity.dart';
import 'package:jesusvlsco/features/individual_payroll/payroll/widget/user_profile.dart';
import 'package:jesusvlsco/features/individual_payroll/payroll/widget/time_period_and_table.dart';

import '../../../../core/utils/constants/colors.dart';

class IndividualPayrollScreen extends StatelessWidget {
  const IndividualPayrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IndividualPayrollController());

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Sizer.wp(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildActionButtons(controller),
                    SizedBox(height: Sizer.hp(24)),
                    _buildCurrentStatusSection(controller),
                    SizedBox(height: Sizer.hp(32)),
                    _buildMyRequestsSection(controller),
                    SizedBox(height: Sizer.hp(32)),
                    _buildRecentActivitySection(controller),
                    SizedBox(height: Sizer.hp(32)),
                    _buildUserProfileSection(controller),
                    SizedBox(height: Sizer.hp(32)),
                    _buildTimePeriodSection(controller),
                    SizedBox(height: Sizer.hp(24)),
                    _buildScheduleTable(controller),
                    SizedBox(height: Sizer.hp(60)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(IndividualPayrollController controller) {
    return ActionButtons(controller: controller);
  }

  Widget _buildCurrentStatusSection(IndividualPayrollController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Current Status",
          style: AppTextStyle.f18W600().copyWith(
            color: const Color(0xFF4E53B1),
          ),
        ),
        SizedBox(height: Sizer.hp(8)),
        Obx(() {
          return Text(
            controller.currentDate.value,
            style: AppTextStyle.f12W400().copyWith(
              color: const Color(0xFF484848),
            ),
          );
        }),
        SizedBox(height: Sizer.hp(24)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatusItem("Clock In", controller.clockInTime.value),
            _buildStatusItem("Clock Out", controller.clockOutTime.value),
            _buildStatusItem("Hours Today", controller.hoursToday.value),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusItem(String title, String value) {
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
        Text(
          value,
          style: AppTextStyle.f16W600().copyWith(
            color: const Color(0xFF484848),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMyRequestsSection(IndividualPayrollController controller) {
    return MyRequestsSection(controller: controller);
  }

  Widget _buildRecentActivitySection(IndividualPayrollController controller) {
    return RecentActivitySection(controller: controller);
  }

  Widget _buildUserProfileSection(IndividualPayrollController controller) {
    return UserProfileSection(controller: controller);
  }

  Widget _buildTimePeriodSection(IndividualPayrollController controller) {
    return TimePeriodSection(controller: controller);
  }

  Widget _buildScheduleTable(IndividualPayrollController controller) {
    return ScheduleTable(controller: controller);
  }
}

PreferredSizeWidget _buildAppBar() {
  return AppBar(
    shadowColor: Colors.white,
    backgroundColor: Colors.white,
    elevation: 0.1,
    leading: IconButton(
      icon: Icon(
        CupertinoIcons.arrow_left,
        color: AppColors.backgroundDark,
        size: Sizer.wp(24),
      ),
      onPressed: () {
        Get.back();
      },
    ),
    title: Text(
      'Payroll',
      style: TextStyle(
        fontSize: Sizer.wp(20),
        color: AppColors.primary,
        fontWeight: FontWeight.w700,
      ),
    ),
    centerTitle: true,
    actions: [
      IconButton(
        icon: Icon(
          CupertinoIcons.bars,
          color: AppColors.backgroundDark,
          size: Sizer.wp(24),
        ),
        onPressed: () {},
      ),
    ],
  );
}
