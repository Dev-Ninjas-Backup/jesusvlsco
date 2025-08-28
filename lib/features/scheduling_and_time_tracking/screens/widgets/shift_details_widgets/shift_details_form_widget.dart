import 'package:flutter/material.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/shift_details_controller.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';

/// Form section widget for shift details
/// Contains all form fields for shift information
class ShiftDetailsFormWidget extends StatelessWidget {
  final ShiftDetailsController controller;

  const ShiftDetailsFormWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Shift Title
        _buildFormField(
          label: 'Shift Title',
          hintText: 'Type Here',
          controller: controller.shiftTitleController,
        ),

        SizedBox(height: Sizer.hp(24)),

        // Job
        _buildFormField(
          label: 'Job',
          hintText: 'Type Job',
          controller: controller.jobController,
          isDropdown: false,
        ),
        SizedBox(height: Sizer.hp(24)),

        // Location
        _buildFormField(
          label: 'Location',
          hintText: 'Type Location',
          controller: controller.locationController,
          suffixIcon: GestureDetector(
            onTap: () => controller.pickCurrentLocation(),
            child: const Icon(Icons.my_location, color: Colors.blue),
          ),
        ),

        SizedBox(height: Sizer.hp(24)),

        // Note
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFormField(
              label: 'Description',
              hintText: 'Type Description',
              controller: controller.noteController,
              maxLines: 4,
            ),
          ],
        ),
      ],
    );
  }

  /// Build individual form field widget
  Widget _buildFormField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    bool isDropdown = false,
    int maxLines = 1,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.f16W600().copyWith(
            color: const Color(0xFF484848),
            height: 1.5,
          ),
        ),
        SizedBox(height: Sizer.hp(8)),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(Sizer.wp(12)),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFC8CAE7)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: AppTextStyle.f12W400().copyWith(
              color: const Color(0xFF949494),
              height: 1.5,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTextStyle.f12W400().copyWith(
                color: const Color(0xFF949494),
                height: 1.5,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              isDense: true,
              suffixIcon: isDropdown
                  ? Icon(
                      Icons.keyboard_arrow_down,
                      size: Sizer.wp(20),
                      color: const Color(0xFF949494),
                    )
                  : suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
