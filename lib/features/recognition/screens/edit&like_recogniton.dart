// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/recognition/screens/summery_recognition.dart';

class EditAndLikeRecognition extends StatelessWidget {
  const EditAndLikeRecognition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Sizer.wp(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  'assets/icons/edit.svg',
                  height: Sizer.hp(32),
                  width: Sizer.wp(32),
                ),
                SizedBox(width: Sizer.wp(8)),
                SvgPicture.asset(
                  'assets/icons/deletecircle.svg',
                  height: Sizer.hp(32),
                  width: Sizer.wp(32),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
            child: Divider(color: AppColors.border2, height: 1),
          ),
          RecognitionCard(),
          Padding(
            padding: EdgeInsets.only(
              left: Sizer.wp(16),
              right: Sizer.wp(16),
              bottom: Sizer.hp(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "19/11/2022 at 11:00 AM",
                  style: AppTextStyle.regular().copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.text,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye_outlined,
                      color: AppColors.text,
                      size: Sizer.wp(12),
                    ),
                    SizedBox(width: Sizer.wp(5)),
                    Text(
                      "10 people can see this",
                      style: AppTextStyle.regular().copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(Sizer.wp(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/emoji.svg',
                      height: Sizer.hp(20),
                      width: Sizer.wp(20),
                    ),
                    SizedBox(width: Sizer.wp(5)),
                    Text(
                      "1",
                      style: AppTextStyle.regular().copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "1",
                      style: AppTextStyle.regular().copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.text,
                      ),
                    ),
                    SizedBox(width: Sizer.wp(5)),
                    Text(
                      "Comments",
                      style: AppTextStyle.regular().copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
            child: Divider(color: AppColors.border2, height: 1),
          ),
        ],
      ),
    );
  }
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
      'Edit Bridge',
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
