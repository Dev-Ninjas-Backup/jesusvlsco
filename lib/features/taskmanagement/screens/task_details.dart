// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/taskmanagement/widgets/common_button.dart';

class TaskDetail {
  final String label;
  final dynamic value;
  final bool isHeader;

  TaskDetail({required this.label, required this.value, this.isHeader = false});
}

final List<TaskDetail> dummyTaskDetails = [
  TaskDetail(label: 'City Bridge Renovations', value: '', isHeader: true),
  TaskDetail(
    label: 'Assigned to',
    value: {
      'name': 'Jane Cooper',
      'avatarUrl': 'https://example.com/avatar.jpg',
    },
  ),
  TaskDetail(label: 'Freequency', value: 'One off task'),
  TaskDetail(label: 'Start date', value: '22/06/25 at 10:00 am'),
  TaskDetail(label: 'Start date', value: '23/06/25 at 10:00 am'),
  TaskDetail(label: 'Labels', value: 'General Tasks'),
];

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: const Color(0xFFF0F0F0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(Sizer.wp(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    Divider(color: AppColors.border2, height: 1),
                    SizedBox(height: Sizer.hp(16)),
                    Padding(
                      padding: EdgeInsets.only(left: Sizer.wp(16)),
                      child: Row(
                        children: [
                          Text(
                            dummyTaskDetails[1].label,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: Sizer.wp(16),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: Sizer.wp(20),
                              backgroundImage: NetworkImage(
                                dummyTaskDetails[1].value['avatarUrl'],
                              ),
                            ),
                          ),
                          Text(
                            dummyTaskDetails[1].value['name'],
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: Sizer.wp(16),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: AppColors.border2, height: 1),
                    SizedBox(height: Sizer.hp(16)),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Sizer.wp(16),
                        right: Sizer.wp(16),
                      ),
                      child: Column(
                        children: [
                          _userrow(
                            context,
                            dummyTaskDetails[2].label,
                            dummyTaskDetails[2].value,
                          ),
                          SizedBox(height: Sizer.hp(16)),
                          _userrow(
                            context,
                            dummyTaskDetails[3].label,
                            dummyTaskDetails[3].value,
                          ),
                          SizedBox(height: Sizer.hp(16)),
                          _userrow(
                            context,
                            dummyTaskDetails[4].label,
                            dummyTaskDetails[4].value,
                          ),
                          SizedBox(height: Sizer.hp(16)),
                          Divider(color: AppColors.border2, height: 1),
                          SizedBox(height: Sizer.hp(16)),

                          Row(
                            children: [
                              Text(
                                "Labels",
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: Sizer.wp(16),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: Sizer.hp(16)),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.button2,
                                  borderRadius: BorderRadius.circular(
                                    Sizer.wp(6),
                                  ),
                                  border: Border.all(
                                    color: AppColors.border2,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "General Tasks",
                                      style: AppTextStyle.semiregular()
                                          .copyWith(
                                            fontSize: 14,
                                            color: AppColors.backgroundDark,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _button_row(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      shadowColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 0.1,
      leading: Icon(
        CupertinoIcons.arrow_left,
        color: AppColors.backgroundDark,
        size: Sizer.wp(24),
      ),
      title: Text(
        'Task Details',
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(Icons.arrow_forward, color: AppColors.primary, size: 24),
          const SizedBox(width: 8.0),
          _buildTab('Task Details', true),
          const SizedBox(width: 16.0),
          _buildTab('Comments', false),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isSelected) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.primary : Colors.black54,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            fontSize: 16,
          ),
        ),
        if (isSelected)
          Container(
            margin: const EdgeInsets.only(top: 4),
            height: 2,
            width: 100,
            color: AppColors.primary,
          ),
      ],
    );
  }
}

@override
Widget _userrow(BuildContext context, String title, String subtitle) {
  return Row(
    children: [
      Text(
        title,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: Sizer.wp(16),
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(width: Sizer.hp(16)),
      Text(
        subtitle,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: Sizer.wp(14),
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}

Widget _button_row(BuildContext context) {
  return Row(
    children: [
      Flexible(
        child: customButton(
          textcolor: AppColors.primaryBackground,
          bgcolor: AppColors.progress1,
          brcolor: AppColors.primary,
          text: "Mark task as done",
          onPressed: () {},
          width: Sizer.wp(176),
        ),
      ),
      SizedBox(width: Sizer.wp(16)),
      Flexible(
        child: customButton(
          textcolor: AppColors.primaryBackground,
          bgcolor: Colors.transparent,
          brcolor: AppColors.primary,
          text: "Edit",
          onPressed: () {},
          width: Sizer.wp(176),
        ),
      ),
    ],
  );
}
