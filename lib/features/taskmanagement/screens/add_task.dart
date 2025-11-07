// add_task_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/taskmanagement/controller/taskcontroller.dart';
import 'package:jesusvlsco/features/taskmanagement/screens/add_moredetails.dart';
import 'package:jesusvlsco/features/taskmanagement/widgets/common_button.dart';

// Your custom color class

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.put(TaskController());
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body:
          // padding: EdgeInsets.all(Sizer.wp(16)),
          Padding(
            padding: EdgeInsets.only(
              left: Sizer.wp(16.0),
              right: Sizer.wp(16.0),
              top: Sizer.hp(24.0),
              bottom: Sizer.hp(24.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: Sizer.wp(360),
                      // height: Sizer.hp(324),
                      decoration: BoxDecoration(
                        color: AppColors.textWhite,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.textSecondary.withValues(
                              alpha: 0.1,
                            ),
                            blurRadius: 3,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(Sizer.wp(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildNewTaskHeader(),

                            Divider(color: AppColors.border1, thickness: 2),
                            SizedBox(height: Sizer.hp(16)),
                            _buildTaskTitleField(
                              controller.titleController,
                              'Task Title',
                              'Type Here',
                            ),
                            SizedBox(height: Sizer.hp(16)),
                            _buildTaskTitleField(
                              controller.titleController,
                              'Assign to',
                              'Select',
                            ),
                            SizedBox(height: Sizer.hp(65)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: Sizer.hp(30),
                                  width: Sizer.wp(30),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary,
                                  ),
                                  child: Center(
                                    child: Icon(Icons.add, color: Colors.white),
                                  ),
                                ),

                                InkWell(
                                  onTap: () {
                                    Get.to(Adddetails());
                                  },
                                  child: Text(
                                    'Add more details',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.color1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(color: AppColors.border1, thickness: 2),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // First Button
                    Flexible(
                      child: customButton(
                        textcolor: AppColors.primaryBackground,
                        bgcolor: AppColors.primary,
                        brcolor: Colors.transparent,
                        text: 'Publish Task',
                        onPressed: () => {},
                        width: Sizer.wp(
                          176,
                        ), // Adjusted width for the first button
                      ),
                    ),

                    // Gap between buttons
                    SizedBox(width: 10),

                    // Second Button
                    Flexible(
                      child: customButton(
                        textcolor: AppColors.textPrimary,

                        bgcolor: AppColors.primaryBackground,
                        brcolor: AppColors.primary,
                        text: 'Draft Task',
                        onPressed: () => {},
                        width: Sizer.wp(
                          176,
                        ), // Adjusted width for the second button
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) {
  return AppBar(
    shadowColor: AppColors.textWhite,
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
      'Add Task',
      style: AppTextStyle.regular().copyWith(
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
        onPressed: () {
          // Handle menu action if needed
        },
      ),
    ],
  );
}

Widget _buildNewTaskHeader() {
  return Row(
    children: [
      Icon(Icons.add, color: AppColors.primary, size: Sizer.wp(20)),
      SizedBox(width: 8),
      Text(
        'New Task',
        style: AppTextStyle.regular().copyWith(
          color: AppColors.primary,
          fontSize: Sizer.wp(18),
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

Widget _buildTaskTitleField(
  TextEditingController controller,
  String title,
  String hintText,
) {
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: Text(
          title,
          style: AppTextStyle.semiregular().copyWith(
            fontSize: Sizer.wp(16),
            fontWeight: FontWeight.w500,
            color: AppColors.text,
          ),
        ),
      ),
      SizedBox(width: 8),
      Expanded(
        flex: 3,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Sizer.wp(8)),
            border: Border.all(color: AppColors.border2),
          ),
          child: TextField(
            controller: controller,
            style: AppTextStyle.semiregular().copyWith(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
              hintText: hintText,
              hintStyle: AppTextStyle.semiregular().copyWith(
                color: Color(0xFF9CA3AF),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
