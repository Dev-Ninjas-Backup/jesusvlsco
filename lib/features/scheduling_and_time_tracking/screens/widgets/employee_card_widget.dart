import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/models/assign_shift_model.dart';

class EmployeeCardWidget extends StatelessWidget {
  final ProjectData projectData;
  final Function(int) onSchedulePressed;

  const EmployeeCardWidget({
    super.key,
    required this.projectData,
    required this.onSchedulePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Employee info card
        _buildEmployeeCard(),
        SizedBox(height: Sizer.hp(12)),
        // Schedule slots
        _buildScheduleSlots(),
      ],
    );
  }

  /// Build employee information card
  Widget _buildEmployeeCard() {
    final user = projectData.user;
    final project = projectData.project;

    return Container(
      height: Sizer.hp(135),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(169, 183, 221, 0.08),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          // Employee avatar
          Container(
            width: Sizer.hp(135),
            height: Sizer.hp(135),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(user.profileUrl),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) =>
                    const AssetImage('assets/images/userprofile.png'),
              ),
            ),
          ),

          // Employee details
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Sizer.wp(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and availability
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              '${user.firstName} ${user.lastName}',
                              style: AppTextStyle.f18W600().copyWith(
                                color: const Color(0xFF5B5B5B),
                                height: 1.5,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (user.isAvailable)
                            Padding(
                              padding: EdgeInsets.all(Sizer.wp(8)),
                              child: Container(
                                width: Sizer.wp(10),
                                height: Sizer.hp(10),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF1EBD66),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Text(
                        project.title, // Using project title as position
                        style: AppTextStyle.f16W600().copyWith(
                          color: AppColors.primary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: Sizer.hp(8)),

                  // Shift count
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: Sizer.wp(20),
                        color: const Color(0xFF949494),
                      ),
                      SizedBox(width: Sizer.wp(8)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.splitscreen,
                            size: Sizer.wp(20),
                            color: const Color(0xFF484848),
                          ),
                          SizedBox(width: Sizer.wp(4)),
                          Text(
                            '${projectData.shifts.length}',
                            style: AppTextStyle.f18W600().copyWith(
                              color: const Color(0xFF484848),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: Sizer.hp(8)),

                  // Off day
                  Text(
                    'Off Day: ${user.offDay.join(", ")}',
                    style: AppTextStyle.f12W400().copyWith(
                      color: AppColors.primary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build schedule slots
  Widget _buildScheduleSlots() {
    return SizedBox(
      height: Sizer.hp(81),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: projectData.shifts.length,
        separatorBuilder: (context, index) => SizedBox(width: Sizer.wp(12)),
        itemBuilder: (context, index) {
          final shift = projectData.shifts[index];
          final dateFormat = DateFormat('MMM dd');
          final timeFormat = DateFormat('HH:mm');
          final shiftDate = dateFormat.format(shift.date);
          final shiftTime =
              '${timeFormat.format(shift.startTime)} - ${timeFormat.format(shift.endTime)}';
          final shiftTitle = shift.title;

          return GestureDetector(
            onTap: () => onSchedulePressed(index),
            child: Container(
              //width: Sizer.hp(100),
              //height: Sizer.hp(81),
              padding: EdgeInsets.all(Sizer.wp(8)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(169, 183, 221, 0.08),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    shiftDate,
                    style: AppTextStyle.f14W600().copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: Sizer.hp(4)),
                  Text(
                    shiftTime,
                    style: AppTextStyle.f12W400().copyWith(
                      color: const Color(0xFF484848),
                    ),
                  ),
                  SizedBox(height: Sizer.hp(4)),
                  Text(
                    shiftTitle,
                    style: AppTextStyle.f12W400().copyWith(
                      color: const Color(0xFF484848),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
