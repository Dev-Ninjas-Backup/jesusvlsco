import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import '../controller/add_shift_controller.dart';

class AddShiftScreen extends StatelessWidget {
  const AddShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddShiftController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Sizer.wp(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProjectRow(controller),
            SizedBox(height: Sizer.hp(20)),
            _buildDateTimeRow(controller),
            SizedBox(height: Sizer.hp(20)),
            _buildDateTimeRow(controller, isEnd: true),
            SizedBox(height: Sizer.hp(24)),
            Text(
              'Shift attachments',
              style: AppTextStyle.f16W600().copyWith(
                color: const Color(0xFF484848),
              ),
            ),
            SizedBox(height: Sizer.hp(12)),
            _buildNoteBox(controller),
            SizedBox(height: Sizer.hp(24)),
            _buildSendButton(controller),
            SizedBox(height: Sizer.hp(60)),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectRow(AddShiftController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Project',
          style: AppTextStyle.f16W600().copyWith(
            color: const Color(0xFF484848),
          ),
        ),
        SizedBox(height: Sizer.hp(8)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Obx(() {
                return InkWell(
                  onTap: () async {
                    final sel = await Get.dialog<String?>(
                      SimpleDialog(
                        title: const Text('Select project'),
                        children: controller.projects
                            .map(
                              (p) => SimpleDialogOption(
                                onPressed: () => Get.back(result: p),
                                child: Text(p),
                              ),
                            )
                            .toList(),
                      ),
                    );
                    if (sel != null) controller.selectProject(sel);
                  },
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF4E53B1)),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            controller.selectedProject.value,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.f14W400().copyWith(
                              color: const Color(0xFF4E53B1),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF4E53B1),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            SizedBox(width: Sizer.wp(12)),
            Container(
              width: 90,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFEDEEF7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total hours',
                    style: AppTextStyle.f12W400().copyWith(
                      color: const Color(0xFF4E53B1),
                    ),
                  ),
                  SizedBox(height: Sizer.hp(8)),
                  Obx(
                    () => Text(
                      controller.totalHours.value,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.f16W600().copyWith(
                        color: const Color(0xFF4E53B1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateTimeRow(
    AddShiftController controller, {
    bool isEnd = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              isEnd ? 'Ends' : 'Starts',
              style: AppTextStyle.f14W400().copyWith(
                color: const Color(0xFF484848),
              ),
            ),
            SizedBox(width: Sizer.wp(12)),
            Obx(() {
              final date = isEnd
                  ? controller.endDate.value
                  : controller.startDate.value;
              return InkWell(
                onTap: isEnd
                    ? controller.pickEndDate
                    : controller.pickStartDate,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 123),
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF484848)),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppTextStyle.f14W400().copyWith(
                              color: const Color(0xFF484848),
                            ),
                          ),
                        ),
                        SizedBox(width: Sizer.wp(8)),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF484848),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
        Row(
          children: [
            Text(
              'At',
              style: AppTextStyle.f14W400().copyWith(
                color: const Color(0xFF484848),
              ),
            ),
            SizedBox(width: Sizer.wp(12)),
            Obx(() {
              final time = isEnd
                  ? controller.endTime.value
                  : controller.startTime.value;
              return InkWell(
                onTap: isEnd
                    ? controller.pickEndTime
                    : controller.pickStartTime,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 80),
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF484848)),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            time.format(Get.context!),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppTextStyle.f14W400().copyWith(
                              color: const Color(0xFF484848),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildNoteBox(AddShiftController controller) {
    return Container(
      width: double.infinity,
      height: 109,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFC8CAE7)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller.noteController,
        maxLines: null,
        expands: true,
        decoration: InputDecoration(
          hintText: 'Add manager note',
          hintStyle: AppTextStyle.f12W400().copyWith(
            color: const Color(0xFF949494),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildSendButton(AddShiftController controller) {
    return InkWell(
      onTap: controller.sendForApproval,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFD9F0E3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'Send for approval',
            style: AppTextStyle.f16W500().copyWith(
              color: const Color(0xFF1EBD66),
            ),
          ),
        ),
      ),
    );
  }

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
        'Add Shift',
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
