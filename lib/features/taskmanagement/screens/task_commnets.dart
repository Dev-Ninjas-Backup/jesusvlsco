// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class TaskCommnets extends StatelessWidget {
  const TaskCommnets({super.key});

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

                    _commnetsection(context),
                  ],
                ),
              ),
            ),
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
          _buildTab('Task Details', false),
          const SizedBox(width: 16.0),
          _buildTab('Comments', true),
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

Widget _commnetsection(BuildContext context) {
  return Row(
    children: [
      CircleAvatar(
        radius: Sizer.wp(20),
        backgroundImage: NetworkImage(
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
        ),
      ),
      SizedBox(width: Sizer.hp(8)),

      Expanded(
        child: Container(
          height: Sizer.hp(40),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Sizer.wp(8)),
            border: Border.all(color: AppColors.border2),
          ),
          child: TextField(
            controller: TextEditingController(),
            style: AppTextStyle.semiregular().copyWith(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
              hintText: "Write a comment",
              hintStyle: AppTextStyle.semiregular().copyWith(
                color: Color(0xFF9CA3AF),
              ),
            ),
          ),
        ),
      ),
      SizedBox(width: Sizer.hp(8)),
      SvgPicture.asset(
        'assets/icons/send.svg',
        height: Sizer.hp(24),
        width: Sizer.wp(24),
      ),
    ],
  );
}
