import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/recognition/widgets/gridview_card.dart';

class AddTopic extends StatelessWidget {
  const AddTopic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Sizer.wp(16)),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.button2),
                borderRadius: BorderRadius.all(Radius.circular(Sizer.wp(12))),
              ),
              height: Sizer.hp(180),
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(Sizer.wp(16)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Your Custom Topic',
                      style: AppTextStyle.regular().copyWith(
                        fontSize: Sizer.wp(18),
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    _customTextField('Topic Title'),
                    Row(
                      children: [
                        Flexible(
                          child: _commonButton(
                            () {
                              Get.back();
                            },
                            bgcolor: AppColors.primary,
                            textcolor: AppColors.textWhite,
                            text: 'Create topic',
                          ),
                        ),

                        SizedBox(width: Sizer.wp(8)),
                        Flexible(
                          child: _commonButton(
                            () {},
                            bgcolor: AppColors.primary,
                            textcolor: AppColors.textWhite,
                            text: 'Cancel',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text(
            'Select icon',
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(18),
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: Sizer.wp(16)),
            child: _buildGridView(),
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
      'Add Topic',
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

Widget _customTextField(String hinttext, {Icon? icon, VoidCallback? onPress}) {
  return InkWell(
    onTap: onPress,
    child: SizedBox(
      height: Sizer.hp(45),
      width: Sizer.wp(360),
      child: TextField(
        maxLines: 2,
        decoration: InputDecoration(
          suffixIcon: icon,
          hintText: hinttext,
          hintStyle: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(14),
            color: AppColors.textfield,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizer.wp(8)),
            borderSide: BorderSide(color: AppColors.border, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizer.wp(8)),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
      ),
    ),
  );
}

Widget _commonButton(
  VoidCallback onPress, {
  String? text,
  Color? bgcolor,
  Color? textcolor,
  Color? brcolor,
}) {
  return InkWell(
    onTap: onPress,
    child: Container(
      height: Sizer.hp(40),
      decoration: BoxDecoration(
        color: bgcolor,
        border: Border.all(width: 1, color: brcolor ?? Colors.transparent),
        borderRadius: BorderRadius.circular(Sizer.wp(8)),
      ),
      child: Padding(
        padding: EdgeInsets.all(Sizer.wp(10)),
        child: Center(
          child: Text(
            text ?? 'Next',
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(14),
              fontWeight: FontWeight.w400,
              color: textcolor,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildGridView() {
  return Padding(
    padding: EdgeInsets.only(left: Sizer.wp(16), right: Sizer.wp(16)),
    child: SizedBox(
      height: Sizer.hp(200),
      width: double.infinity,
      child: gridview_card(), // Assuming gridview_card widget exists
    ),
  );
}
