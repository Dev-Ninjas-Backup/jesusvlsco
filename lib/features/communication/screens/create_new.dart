
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/communication/screens/new_team.dart';
import 'package:jesusvlsco/features/communication/widgets/custom_appbar.dart';

class CreateNew extends StatelessWidget {
  const CreateNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: Custom_appbar(title: "Create New"),

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
                SvgPicture.asset(
                  'assets/icons/groups_2.svg',
                  height: Sizer.hp(20),
                  width: Sizer.wp(20),
                ),
                SizedBox(width: Sizer.wp(8)),
                TextButton(
                  onPressed: () {
                    Get.to(NewTeam());
                  },
                  child: Text(
                    'New Team',
                    style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(16),
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Sizer.hp(16)),
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
        ],
      ),
    );
  }
}

Widget buildSuggestedUser() {
  return Padding(
    padding: EdgeInsets.all(Sizer.wp(16)),
    child: Container(
      height: Sizer.hp(204),
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
        hintText: 'To : type a name or group',
        hintStyle: AppTextStyle.regular().copyWith(
          fontSize: Sizer.wp(14),
          color: AppColors.text,
        ),

        contentPadding: EdgeInsets.symmetric(
          horizontal: Sizer.wp(16),
          vertical: Sizer.hp(12),
        ),
      ),
    ),
  );
}
