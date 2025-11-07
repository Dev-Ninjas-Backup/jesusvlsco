
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/recognition/screens/create_bridge.dart';
import 'package:jesusvlsco/features/recognition/widgets/gridview_card.dart';
class CreateRecognition extends StatelessWidget {
  const CreateRecognition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSelectBadgeRow(),
            SizedBox(height: Sizer.hp(16)),
            gridview_card(),
            Text(
              "Attach a messsage:",
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(16),
                color: AppColors.text,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: Sizer.hp(8)),
            _customTextField("Write a message"),
            SizedBox(height: Sizer.hp(8)),
            Text(
              "Recognition will be visible to :",
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(16),
                color: AppColors.text,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: Sizer.hp(8)),
            _customTextField("Select a option", icon: Icon(Icons.arrow_drop_down),),
            SizedBox(height: Sizer.hp(8)),
        
            Row(
              children: [
                Checkbox(value: true, onChanged: (value) {}),
                Text(
                  "Notify viewer via push notification",
                  style: AppTextStyle.regular().copyWith(
                    fontSize: Sizer.wp(14),
                    color: AppColors.text,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: Sizer.hp(8)),
            _customTextField("XYZ company recognition K & others "),
            SizedBox(height: Sizer.hp(8)),
        
            Row(
              children: [
                Checkbox(value: true, onChanged: (value) {}),
                Text(
                  "Allow user to like & comment on this update",
                  style: AppTextStyle.regular().copyWith(
                    fontSize: Sizer.wp(14),
                    color: AppColors.text,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _buildSelectBadgeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Select badge : ",
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(16),
            color: AppColors.text,
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            _categoryButton(() {}),
            SizedBox(width: Sizer.wp(8)),
            _commonButton(
              () {
                Get.to(CreateBridge());
              },
              text: "Create",
              bgcolor: AppColors.textWhite,
              brcolor: AppColors.primary,
            ),
          ],
        ),
      ],
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

  Widget _categoryButton(VoidCallback onPress) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: Sizer.hp(40),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          border: Border.all(width: 1, color: AppColors.primary),
          borderRadius: BorderRadius.circular(Sizer.wp(8)),
        ),
        child: Padding(
          padding: EdgeInsets.all(Sizer.wp(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Category",
                style: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(14),
                  fontWeight: FontWeight.w400,
                  color: AppColors.primary,
                ),
              ),
              Icon(Icons.arrow_drop_down, color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }
}



Widget _customTextField(String hinttext,{Icon? icon,VoidCallback? onPress}) {
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
