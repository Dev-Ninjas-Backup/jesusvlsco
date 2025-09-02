import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/taskmanagement/controller/overduecontroller.dart';

class OverdueTask extends StatelessWidget {
  const OverdueTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: const Color(0xFFF0F0F0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildTaskList()],
        ),
      ),
    );
  }

  // Task List Container
  Widget _buildTaskList() {
    final Overduecontroller overduecontroller = Get.put(Overduecontroller());
    return Container(
      height: Sizer.hp(400),
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
      child: ListView.builder(
        itemCount: overduecontroller.dummyData.length,
        itemBuilder: (context, index) {
          final task = overduecontroller.dummyData[index];
          return _buildTaskRow(task);
        },
      ),
    );
  }

  // Task Row Widget
  Widget _buildTaskRow(OverduetaskModel task) {
    return Padding(
      padding: EdgeInsets.all(Sizer.wp(16)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: AppTextStyle.regular().copyWith(
                        fontSize: Sizer.wp(16),
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    SizedBox(height: Sizer.hp(8)),

                    SizedBox(height: Sizer.hp(8)),
                    _buildTaskLabels(),
                    SizedBox(height: Sizer.hp(8)),
                    _buildUserInfo(),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Sizer.hp(16)),
          Divider(color: AppColors.border2, height: 1),
        ],
      ),
    );
  }

  // Task Labels Section
  Widget _buildTaskLabels() {
    final Overduecontroller overduecontroller = Get.put(Overduecontroller());
    return Row(
      children: [
        Text(
          overduecontroller.dummyData[0].subtitle,
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(14),
            fontWeight: FontWeight.w400,
            color: AppColors.error,
          ),
        ),
        SizedBox(width: Sizer.wp(8)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.button2,
            borderRadius: BorderRadius.circular(Sizer.wp(20)),
            border: Border.all(color: AppColors.border2, width: 1),
          ),
          child: Text(
            "General Tasks",
            style: AppTextStyle.semiregular().copyWith(
              fontSize: 14,
              color: AppColors.backgroundDark,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  // User Info Row
  Widget _buildUserInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: Sizer.wp(15),
          backgroundImage: NetworkImage(
            "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
          ),
        ),
        SizedBox(width: Sizer.wp(8)),
        Text(
          "General Tasks",
          style: AppTextStyle.semiregular().copyWith(
            fontSize: 14,
            color: AppColors.backgroundDark,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: Sizer.wp(20)),
        Icon(
          Icons.comment_rounded,
          color: AppColors.backgroundDark,
          size: Sizer.wp(20),
        ),
        SizedBox(width: Sizer.wp(8)),
        Text(
          "0",
          style: AppTextStyle.semiregular().copyWith(
            fontSize: 14,
            color: AppColors.backgroundDark,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: Sizer.wp(8)),
        Text(
          "Comments",
          style: AppTextStyle.semiregular().copyWith(
            fontSize: 14,
            color: AppColors.backgroundDark,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  // Button Row

  // AppBar
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
}
