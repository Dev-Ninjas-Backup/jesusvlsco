import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';

import '../../../core/common/styles/global_text_style.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/sizer.dart';
import '../../communication/widgets/common_button.dart';

class AddMemberScreen extends StatelessWidget {
  const AddMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Custom_appbar(title: 'Add Member'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Sizer.wp(16)),
            child: _buildSearchTextField(),
          ),


          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
            child: Row(
              children: [
                Text(
                  'Suggested',
                  style: AppTextStyle.regular().copyWith(
                    fontSize: Sizer.wp(16),
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizer.wp(16),
              vertical: Sizer.hp(3),
            ),
            child: Divider(color: AppColors.border3, height: 1),
          ),
          buildSuggestedUser(),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: Sizer.hp(24),
                    left: Sizer.wp(16),
                    right: Sizer.wp(16),
                  ),
                  child: customButton(
                    bgcolor: AppColors.primary,
                    brcolor: Colors.transparent,
                    text: "Add Member",
                    textcolor: Colors.white,
                    onPressed: () {},
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildSearchTextField() {
    return Container(
      height: Sizer.hp(48),

      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(Sizer.wp(10)),
      ),
      child: TextField(
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: 'Search Members',
          hintStyle: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(14),
            color: AppColors.text,
          ),

         prefixIcon: Container(
        padding: const EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(Sizer.wp(6)),
          child: SvgPicture.asset(
            "assets/icons/search-normal.svg",

            height: Sizer.hp(20),
            width: Sizer.wp(20),
          ),
        ),
      ),

          contentPadding: EdgeInsets.symmetric(
            horizontal: Sizer.wp(16),
            vertical: Sizer.hp(12),
          ),
        ),
      ),
    );
  }

  Widget buildSuggestedUser() {
    return Padding(
      padding: EdgeInsets.all(Sizer.wp(16)),
      child: Container(
        height: Sizer.hp(215),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          border: Border.all(color: AppColors.border3),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.border3,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [

            const SizedBox(height: 10,),
            Container(
              width: 106,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: AppColors.primary,
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Robert Fox',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white
                    ),
                  ),

                  Icon(Icons.close, color: Colors.white, size: 17,)
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Assuming 10 items as dummy data
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                      ),
                    ),
                    title: Text(
                      'Theresa webb',
                      style: AppTextStyle.regular().copyWith(
                        fontSize: Sizer.wp(16),
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ), // Dummy title
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
