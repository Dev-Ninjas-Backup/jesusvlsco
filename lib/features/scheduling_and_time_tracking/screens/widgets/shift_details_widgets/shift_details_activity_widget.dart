import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import '../../../controllers/shift_details_controller.dart';

/// Activity section widget for shift details
/// Displays shift activity feed with user actions and timestamps
class ShiftDetailsActivityWidget extends StatelessWidget {
  final ShiftDetailsController controller;

  const ShiftDetailsActivityWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: Sizer.hp(8)),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFE4E5F3), width: 1),
            ),
          ),
          child: Text(
            'Shift Activity',
            style: AppTextStyle.f18W600().copyWith(
              color: AppColors.primary,
              height: 1.5,
            ),
          ),
        ),

        SizedBox(height: Sizer.hp(24)),

        // Activity list
        Obx(
          () => Column(
            children: controller.activities.map((activity) {
              return Container(
                margin: EdgeInsets.only(bottom: Sizer.hp(24)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar
                    Container(
                      width: Sizer.wp(44),
                      height: Sizer.wp(44),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withValues(alpha: 0.1),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                        ),
                        image: activity.userAvatar.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(activity.userAvatar),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: activity.userAvatar.isEmpty
                          ? Icon(
                              Icons.person,
                              size: Sizer.wp(20),
                              color: AppColors.primary,
                            )
                          : null,
                    ),

                    SizedBox(width: Sizer.wp(24)),

                    // Activity content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: activity.action,
                                  style: AppTextStyle.f14W400().copyWith(
                                    color: const Color(0xFF484848),
                                    height: 1.45,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${activity.userName}',
                                  style: AppTextStyle.f16W600().copyWith(
                                    color: AppColors.primary,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Sizer.hp(8)),
                          Text(
                            activity.formattedTime,
                            style: AppTextStyle.f12W400().copyWith(
                              color: const Color(0xFF949494),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
