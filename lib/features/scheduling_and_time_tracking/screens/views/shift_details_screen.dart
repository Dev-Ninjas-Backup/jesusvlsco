import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/shift_details_controller.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/time_sheet_appbar.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/shift_details_widgets/shift_details_date_time_widget.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/shift_details_widgets/shift_details_form_widget.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/shift_details_widgets/shift_details_tasks_widget.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/shift_details_widgets/shift_details_action_buttons_widget.dart';

class ShiftDetailsScreen extends StatelessWidget {
  final controller = Get.put(ShiftDetailsController());
  final Map<String, dynamic>? extra;

  ShiftDetailsScreen({super.key, this.extra});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const TimeSheetAppBar(title: "Shift Details"),
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Sizer.hp(24)),

                    // Date and Time Section
                    ShiftDetailsDateTimeWidget(controller: controller),

                    SizedBox(height: Sizer.hp(20)),

                    // Form Fields Section
                    ShiftDetailsFormWidget(controller: controller),

                    // Shift Tasks Section
                    ShiftDetailsTasksWidget(controller: controller),

                    SizedBox(height: Sizer.hp(20)),

                    // Action Buttons
                    ShiftDetailsActionButtonsWidget(controller: controller),

                    SizedBox(height: Sizer.hp(32)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
