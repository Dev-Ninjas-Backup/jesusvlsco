// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/taskmanagement/controller/celendercontroller.dart';
import 'package:jesusvlsco/features/taskmanagement/widgets/wide_list.dart';

class SubmittedTask extends StatelessWidget {
  const SubmittedTask({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CalendarController());
    return Scaffold(
      appBar: AppBar(
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
          'Task Details',
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchTextField(),
            Padding(
              padding: EdgeInsets.only(
                left: Sizer.wp(16.0),
                right: Sizer.wp(16.0),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //
                  SizedBox(width: Sizer.wp(8)),
                  Expanded(
                    child: _customButton1(
                      width: Sizer.wp(120),
                      color: AppColors.primary,
                      text: "All Task",
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: Sizer.wp(8)),
                  Expanded(
                    child: _customButton1(
                      width: Sizer.wp(100),
                      color: AppColors.primary,
                      text: "Submitted Task",
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Sizer.hp(16)),
            SizedBox(height: Sizer.hp(400), child: WideList()),
          ],
        ),
      ),
    );
  }
}

Widget _buildSearchTextField() {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: Sizer.wp(16),
      vertical: Sizer.hp(24),
    ),
    child: Container(
      height: Sizer.hp(48),
      width: Sizer.wp(360),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(Sizer.wp(10)),
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withValues(alpha: 0.1),
            blurRadius: 3,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: 'Search articles',
          hintStyle: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(14),
            color: AppColors.textSecondary.withValues(alpha: 0.6),
          ),
          suffixIcon: Container(
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              'assets/icons/search-normal.svg',
              height: Sizer.hp(20),
              width: Sizer.wp(20),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: Sizer.wp(16),
            vertical: Sizer.hp(12),
          ),
        ),
      ),
    ),
  );
}

Widget _customButton1({
  required Color color,
  required String text,
  required VoidCallback onPressed,
  required double width,
}) {
  return SizedBox(
    width: width,
    height: Sizer.hp(40),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizer.wp(8)),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTextStyle.regular().copyWith(
          fontSize: Sizer.wp(16),
          color: AppColors.textWhite,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.4)
      ..strokeWidth = 1;

    const dashWidth = 4.0;
    const dashSpace = 3.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
