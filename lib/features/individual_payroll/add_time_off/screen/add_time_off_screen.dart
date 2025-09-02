import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import '../controller/add_time_off_controller.dart';

class AddTimeOffScreen extends StatelessWidget {
  const AddTimeOffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddTimeOffController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Sizer.wp(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTypeRow(controller),
            SizedBox(height: Sizer.hp(16)),
            _buildAllDayRow(controller),
            SizedBox(height: Sizer.hp(16)),
            _buildDateRow(controller),
            SizedBox(height: Sizer.hp(16)),
            _buildTotalDaysRow(controller),
            SizedBox(height: Sizer.hp(16)),
            _buildNotes(controller),
            SizedBox(height: Sizer.hp(24)),
            _buildSendButton(controller),
            SizedBox(height: Sizer.hp(60)),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeRow(AddTimeOffController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Time off type',
          style: AppTextStyle.f16W600().copyWith(
            color: const Color(0xFF484848),
          ),
        ),
        Obx(
          () => InkWell(
            onTap: () async {
              final sel = await Get.dialog<String?>(
                SimpleDialog(
                  title: const Text('Select type'),
                  children: controller.types
                      .map(
                        (t) => SimpleDialogOption(
                          onPressed: () => Get.back(result: t),
                          child: Text(t),
                        ),
                      )
                      .toList(),
                ),
              );
              if (sel != null) controller.selectType(sel);
            },
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF4E53B1)),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      controller.selectedType.value,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.f14W400().copyWith(
                        color: const Color(0xFF4E53B1),
                      ),
                    ),
                  ),
                  SizedBox(width: Sizer.wp(2)),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF4E53B1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAllDayRow(AddTimeOffController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'All day time off',
          style: AppTextStyle.f16W600().copyWith(
            color: const Color(0xFF484848),
          ),
        ),
        Obx(
          () => Switch(
            value: controller.isAllDay.value,
            onChanged: controller.toggleAllDay,
            activeTrackColor: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildDateRow(AddTimeOffController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Date and time of time off',
          style: AppTextStyle.f16W600().copyWith(
            color: const Color(0xFF484848),
          ),
        ),
        Obx(
          () => InkWell(
            onTap: controller.pickDate,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF4E53B1)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Color(0xFF4E53B1)),
                  SizedBox(width: Sizer.wp(2)),
                  Text(
                    '${controller.selectedDate.value.day.toString().padLeft(2, '0')}/'
                    '${controller.selectedDate.value.month.toString().padLeft(2, '0')}/'
                    '${controller.selectedDate.value.year}',
                    style: AppTextStyle.f14W400().copyWith(
                      color: const Color(0xFF4E53B1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTotalDaysRow(AddTimeOffController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total time off days',
          style: AppTextStyle.f16W600().copyWith(
            color: const Color(0xFF484848),
          ),
        ),
        Obx(
          () => Text(
            controller.totalDays.value,
            style: AppTextStyle.f16W600().copyWith(
              color: const Color(0xFF484848),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotes(AddTimeOffController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes',
          style: AppTextStyle.f16W600().copyWith(
            color: const Color(0xFF484848),
          ),
        ),
        SizedBox(height: Sizer.hp(8)),
        Container(
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
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintText: 'Add manager note',
              hintStyle: AppTextStyle.f12W400().copyWith(
                color: const Color(0xFF949494),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSendButton(AddTimeOffController controller) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
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
        'Add Time Off',
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
