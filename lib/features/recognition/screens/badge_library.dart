import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/recognition/screens/add_topic.dart';
import 'package:jesusvlsco/features/recognition/screens/send_recognition.dart';
import 'package:jesusvlsco/features/recognition/widgets/gridview_card.dart';

class BadgeLibrary extends StatelessWidget {
  const BadgeLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildActionButtons(),
            _buildCategoryButtonRow(),
            _buildSectionTitleWithButton("Milestone:", "Add topic"),
            _buildGridView(),
            _buildSectionTitleWithButton("Good job:", "Add topic"),
            _buildGridView(),
            _buildSectionTitleWithButton("Anniversary:", "Add topic"),
            _buildGridView(),
          ],
        ),
      ),
    );
  }

  // Optimized Action Buttons Section
  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.all(Sizer.wp(16)),
      child: Row(
        children: [
          _buildButton(
            onPressed: () {
              Get.to(SendRecognition());
            },
            text: "Send recognition",
            bgcolor: AppColors.textWhite,
            brcolor: AppColors.primary,
            textcolor: AppColors.primary,
          ),
          SizedBox(width: Sizer.wp(8)),
          _buildButton(
            onPressed: () {
              Get.to(BadgeLibrary());
            },
            text: "Badge library",
            bgcolor: AppColors.primary,
            brcolor: AppColors.primary,
            textcolor: AppColors.textWhite,
          ),
        ],
      ),
    );
  }

  // Reusable Section for Category Button with Icon and Text
  Widget _buildCategoryButtonRow() {
    return Padding(
      padding: EdgeInsets.only(right: Sizer.wp(16), bottom: Sizer.hp(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildCategoryButton(
            onPress: () {},
            iconprefix: Icons.calendar_month,
            iconsuffix: Icons.arrow_drop_down,
            text: "Date",
            bgcolor: AppColors.textWhite,
            brcolor: AppColors.primary,
            textcolor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  // Reusable Section Title with Add Button
  Widget _buildSectionTitleWithButton(String title, String buttonText) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizer.wp(16),
        right: Sizer.wp(16),
        bottom: Sizer.hp(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(18),
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          _buildCategoryButton(
            iconsuffix: Icons.add,
            onPress: () {
              Get.to(AddTopic());
            },
            iconprefix: Icons.add,
            text: buttonText,
            bgcolor: AppColors.textWhite,
            brcolor: AppColors.primary,
            textcolor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  // Reusable GridView
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

  // AppBar Section
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
        'Badge Library',
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

  // Reusable Common Button (Primary Action Button)
  Widget _buildButton({
    required VoidCallback onPressed,
    required String text,
    required Color bgcolor,
    required Color brcolor,
    required Color textcolor,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: Sizer.hp(40),
          decoration: BoxDecoration(
            color: bgcolor,
            border: Border.all(width: 1.5, color: brcolor),
            borderRadius: BorderRadius.circular(Sizer.wp(8)),
          ),
          child: Padding(
            padding: EdgeInsets.all(Sizer.wp(10)),
            child: Center(
              child: FittedBox(
                child: Text(
                  text,
                  style: AppTextStyle.regular().copyWith(
                    fontSize: Sizer.wp(14),
                    fontWeight: FontWeight.w400,
                    color: textcolor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Reusable Category Button (With Icon)
  Widget _buildCategoryButton({
    required VoidCallback onPress,
    required IconData iconprefix,
    required IconData iconsuffix,
    required String text,
    required Color bgcolor,
    required Color brcolor,
    required Color textcolor,
  }) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: Sizer.hp(40),
        decoration: BoxDecoration(
          color: bgcolor,
          border: Border.all(width: 1.5, color: brcolor),
          borderRadius: BorderRadius.circular(Sizer.wp(8)),
        ),
        child: Padding(
          padding: EdgeInsets.all(Sizer.wp(10)),
          child: Row(
            children: [
              Icon(iconprefix, color: AppColors.primary),
              SizedBox(width: Sizer.wp(8)),
              Text(
                text,
                style: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(14),
                  fontWeight: FontWeight.w400,
                  color: textcolor,
                ),
              ),
              SizedBox(width: Sizer.wp(8)),
              Icon(iconsuffix, color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }
}
