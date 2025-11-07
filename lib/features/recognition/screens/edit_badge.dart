import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/recognition/controllers/badge_controller.dart';
import 'package:jesusvlsco/features/recognition/widgets/gridview_card.dart';

class EditBadge extends StatelessWidget {
  const EditBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizer.wp(16)),
          child: Column(
            children: [
              _buildContainerSection(),

              SizedBox(height: Sizer.hp(16)),
              _buildGridView(),
            ],
          ),
        ),
      ),
    );
  }

  // Optimized Container Section
  Widget _buildContainerSection() {
    return Container(
      width: double.infinity,
      // height: Sizer.hp(643),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: Sizer.hp(16)),
            child: Text(
              'Your Custom Badge',
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(18),
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),

          _buildBadgeIconSection(),

          Padding(
            padding: EdgeInsets.only(left: Sizer.wp(16), right: Sizer.wp(16)),
            child: _buildTextFieldSection("Badge Title"),
          ),
          Padding(
            padding: EdgeInsets.only(left: Sizer.wp(16), right: Sizer.wp(16)),
            child: _buildTextFieldSection(
              "Upload Custom Badge",
              icon: Icon(Icons.camera_alt_outlined, color: AppColors.text),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: Sizer.wp(16), right: Sizer.wp(16)),
            child: _buildTextFieldSection("Badge Category:"),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: Sizer.hp(16),
              left: Sizer.wp(16),
              right: Sizer.wp(16),
            ),
            child: _buildButtonRow(),
          ),
        ],
      ),
    );
  }

  // Badge Icon Section
  Widget _buildBadgeIconSection() {
    final badgeController = Get.put(BadgeController());

    return Padding(
      padding: EdgeInsets.all(Sizer.wp(16)),
      child: Container(
        height: Sizer.hp(329),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.gridcard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Obx(() {
          // Show the selected badge icon based on the current selected index
          final selectedItem =
              badgeController.items[badgeController.selectedIndex.value];

          return Center(
            child: SvgPicture.asset(
              selectedItem.icon,
              height: Sizer.hp(200),
              width: Sizer.wp(200),
            ),
          );
        }),
      ),
    );
  }

  // Reusable TextField Section
  Widget _buildTextFieldSection(String hintText, {Icon? icon}) {
    return Padding(
      padding: EdgeInsets.only(bottom: Sizer.hp(16)),
      child: _customTextField(hintText, icon: icon),
    );
  }

  // Reusable TextField Widget
  Widget _customTextField(String hintText, {Icon? icon}) {
    return SizedBox(
      height: Sizer.hp(45),
      width: Sizer.wp(360),
      child: TextField(
        maxLines: 2,
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hintText,
          hintStyle: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(14),
            color: AppColors.text,
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
    );
  }

  // Reusable Button Row
  Widget _buildButtonRow() {
    return Row(
      children: [
        Flexible(
          child: _buildButton(
            onPressed: () {},
            text: "Create Bridge",
            bgcolor: AppColors.primary,
            brcolor: AppColors.primary,
            textcolor: AppColors.textWhite,
          ),
        ),
        SizedBox(width: Sizer.wp(8)),
        Flexible(
          child: _buildButton(
            onPressed: () {},
            text: "Close",
            bgcolor: AppColors.primaryBackground,
            brcolor: AppColors.border2,
            textcolor: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  // Reusable Button Widget
  Widget _buildButton({
    required VoidCallback onPressed,
    required String text,
    required Color bgcolor,
    required Color brcolor,
    required Color textcolor,
  }) {
    return InkWell(
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
    );
  }

  // Reusable GridView
  Widget _buildGridView() {
    return SizedBox(
      height: Sizer.hp(200),
      width: double.infinity,
      child: gridview_card(), // Assuming gridview_card widget exists
    );
  }

  // AppBar Section
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
}
