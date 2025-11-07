// add_task_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/taskmanagement/controller/taskcontroller.dart';
import 'package:jesusvlsco/features/taskmanagement/widgets/common_button.dart';

// Your custom color class

class Adddetails extends StatelessWidget {
  const Adddetails({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.put(TaskController());
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Sizer.wp(16)),
        child: Column(
          children: [
            Container(
              width: Sizer.wp(360),
              // height: Sizer.hp(686) ,
              decoration: BoxDecoration(
                color: AppColors.textWhite,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textSecondary.withValues(alpha: 0.1),
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
                    SizedBox(height: Sizer.hp(24)),
                    _buildTaskDetailsSection(),
                    SizedBox(height: Sizer.hp(24)),
                    _buildTaskTitleField(
                      controller.titleController,
                      'Task Title',
                      'Enter task title',
                    ),
                    SizedBox(height: Sizer.hp(16)),

                    _buildDescriptionField(controller.descriptionController),
                    _buildAttachmentOption(context, controller),
                    SizedBox(height: Sizer.hp(16)),

                    _buildTaskTitleField(
                      controller.locationController,
                      'Location',
                      'Type location',
                    ),
                    SizedBox(height: Sizer.hp(24)),
                    _buildStartDateSection(context, controller),
                    SizedBox(height: 16),
                    _buildDueDateSection(context, controller),
                    SizedBox(height: 24),
                    _buildLabelsSection(context, controller),
                  ],
                ),
              ),
            ),
            SizedBox(height: Sizer.hp(24)),
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
                    width: Sizer.wp(176), // Adjusted width for the first button
                  ),
                ),

                // Gap between buttons
                SizedBox(width: 10),

                // Second Button
                Flexible(
                  child: customButton(
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
      Icon(Icons.arrow_forward, color: AppColors.primary, size: Sizer.wp(16)),
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

Widget _buildTaskDetailsSection() {
  return Text(
    'Task Details',
    style: AppTextStyle.semiregular().copyWith(
      decoration: TextDecoration.underline,
      fontSize: Sizer.wp(16),
      fontWeight: FontWeight.w600,
      color: AppColors.primary,
    ),
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

Widget _buildDescriptionField(TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Description',
        style: AppTextStyle.semiregular().copyWith(
          fontSize: Sizer.wp(16),
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      SizedBox(height: 8),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border2),
        ),
        child: TextField(
          controller: controller,
          maxLines: 4,
          style: AppTextStyle.semiregular().copyWith(
            color: AppColors.backgroundDark,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(16),
            hintText: 'Type here...',
            hintStyle: AppTextStyle.semiregular().copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildAttachmentOption(BuildContext context, TaskController controller) {
  return Align(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: EdgeInsets.only(top: 8),
      child: InkWell(
        onTap: () => controller.handleAttachment(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.attach_file, size: 16, color: AppColors.textSecondary),
            SizedBox(width: 4),
            Text(
              'Attachment',
              style: AppTextStyle.semiregular().copyWith(
                fontSize: Sizer.wp(14),
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildStartDateSection(BuildContext context, TaskController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Start Date',
        style: AppTextStyle.semiregular().copyWith(
          fontSize: Sizer.wp(14),
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
      ),
      SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () => controller.selectStartDate(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryBackground,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.formatDate(controller.startDate),
                      style: AppTextStyle.semiregular().copyWith(
                        color: Colors.black87,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: InkWell(
              onTap: () => controller.selectStartTime(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryBackground,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border2),
                ),
                child: Text(
                  controller.formatTime(controller.startTime),
                  style: AppTextStyle.semiregular().copyWith(
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          InkWell(
            onTap: () => controller.resetStartDateTime(),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                Icons.close,
                size: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildDueDateSection(BuildContext context, TaskController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Due Date',
        style: AppTextStyle.semiregular().copyWith(
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () => controller.selectDueDate(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryBackground,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.formatDate(controller.dueDate),
                      style: AppTextStyle.semiregular().copyWith(
                        color: Colors.black,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: InkWell(
              onTap: () => controller.selectDueTime(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryBackground,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border2),
                ),
                child: Text(
                  controller.formatTime(controller.dueTime),
                  style: AppTextStyle.semiregular().copyWith(
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          InkWell(
            onTap: () => controller.resetDueDateTime(),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                Icons.close,
                size: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildLabelsSection(BuildContext context, TaskController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Labels',
        style: AppTextStyle.semiregular().copyWith(
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      SizedBox(height: 8),
      InkWell(
        onTap: () => controller.showLabelPicker(context),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border2),
          ),
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: controller.selectedLabels.map((label) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.button2,
                        borderRadius: BorderRadius.circular(Sizer.wp(6)),
                        border: Border.all(color: AppColors.border2, width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            label,
                            style: AppTextStyle.semiregular().copyWith(
                              fontSize: 14,
                              color: AppColors.backgroundDark,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 4),
                          InkWell(
                            onTap: () => controller.removeLabel(label),
                            child: Icon(
                              Icons.close,
                              size: 14,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    ],
  );
}
