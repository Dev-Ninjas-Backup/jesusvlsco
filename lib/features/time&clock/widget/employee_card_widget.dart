import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/time&clock/controller/assign_employee_controller.dart';

class EmployeeCardWidget extends StatelessWidget {
  final EmployeeModel employee;
  final Function(int) onSchedulePressed;

  const EmployeeCardWidget({
    super.key,
    required this.employee,
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
                image: NetworkImage(employee.avatar),
                fit: BoxFit.cover,
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
                  // Name and position
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            employee.name,
                            style: AppTextStyle.f18W600().copyWith(
                              color: const Color(0xFF5B5B5B),
                              height: 1.5,
                            ),
                          ),
                          // Active indicator
                          if (employee.isActive)
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
                        employee.position,
                        style: AppTextStyle.f16W600().copyWith(
                          color: AppColors.primary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: Sizer.hp(8)),

                  // Time and project count
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
                            '${employee.projectCount}',
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
                    'Off Day: ${employee.offDay}',
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
        itemCount: employee.scheduleSlots.length,
        separatorBuilder: (context, index) => SizedBox(width: Sizer.wp(12)),
        itemBuilder: (context, index) {
          final isSelected = employee.scheduleSlots[index];

          return GestureDetector(
            onTap: () => onSchedulePressed(index),
            child: Container(
              width: Sizer.hp(81),
              height: Sizer.hp(81),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border.all(color: AppColors.primary, width: 2)
                    : Border.all(color: const Color(0xFF484848)),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(169, 183, 221, 0.08),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  isSelected ? Icons.check : Icons.add,
                  size: Sizer.wp(24),
                  color: isSelected
                      ? AppColors.primary
                      : const Color(0xFF484848),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
