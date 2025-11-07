import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/shift_template_controller.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/shift_emplate_widgets/shift_template_search_widget.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/shift_emplate_widgets/shift_template_list_widget.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/shift_emplate_widgets/shift_template_add_button_widget.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/time_sheet_appbar.dart';

/// Shift Template Screen
/// Displays available shift templates with search functionality
class ShiftTemplateScreen extends StatelessWidget {
  const ShiftTemplateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    Get.put(ShiftTemplateController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const TimeSheetAppBar(title: "Shift Template"),
      body: SafeArea(
        child: Column(
          children: [
            // Main Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
                child: Column(
                  children: [
                    SizedBox(height: Sizer.hp(32)),

                    // Content Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(Sizer.wp(24)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(169, 183, 221, 0.25),
                            offset: const Offset(0, 0),
                            blurRadius: 12,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shifts',
                                style: AppTextStyle.f16W600().copyWith(
                                  color: AppColors.primary,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: Sizer.hp(8)),
                              Text(
                                'Drag and drop to the schedule',
                                style: AppTextStyle.f14W400().copyWith(
                                  color: AppColors.primary,
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: Sizer.hp(16)),

                          // Search Field
                          const ShiftTemplateSearchWidget(),

                          SizedBox(height: Sizer.hp(16)),

                          // Templates List
                          const ShiftTemplateListWidget(),
                        ],
                      ),
                    ),

                    SizedBox(height: Sizer.hp(32)),

                    // Add Template Button
                    const ShiftTemplateAddButtonWidget(),

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
