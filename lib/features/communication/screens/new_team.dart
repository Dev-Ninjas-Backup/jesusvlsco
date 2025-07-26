import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/communication/widgets/custom_appbar.dart';
import 'package:jesusvlsco/features/taskmanagement/widgets/common_button.dart';

class NewTeam extends StatelessWidget {
  const NewTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom_appbar(title: "New Team"),
      body: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Sizer.wp(24)),
                  child: Container(
                    width: Sizer.wp(166),
                    height: Sizer.hp(48),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBackground,
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(Sizer.wp(10)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: Sizer.wp(24)),
                        SvgPicture.asset(
                          "assets/icons/home.svg",
                          height: Sizer.hp(24),
                          width: Sizer.wp(24),
                        ),
                        SizedBox(width: Sizer.wp(8)),
                        Text(
                          'Add Image',
                          style: AppTextStyle.regular().copyWith(
                            fontSize: Sizer.wp(16),
                            fontWeight: FontWeight.w500,
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              left: Sizer.wp(16),
              top: Sizer.hp(16),
              right: Sizer.wp(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create team name",
                  style: TextStyle(
                    fontSize: Sizer.wp(16),
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                SizedBox(height: Sizer.hp(8)),
                _buildSearchTextField(),
              ],
            ),
          ),
          SizedBox(height: Sizer.hp(16)),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: Sizer.wp(16)),
                child: Text(
                  "Choose members",
                  style: TextStyle(
                    fontSize: Sizer.wp(18),
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Sizer.hp(16)),
          _buildropdownrow(title: 'Select Team'),
          _buildropdownrow(title: 'Select specific members'),
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
                    brcolor: AppColors.primary,
                    text: "Create New Team",
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
        hintText: 'Enter team name here ',
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

Widget _buildDropdown() {
  return Container(
    width: double.infinity,
    height: Sizer.hp(48),
    decoration: BoxDecoration(
      color: AppColors.primaryBackground,
      border: Border.all(color: AppColors.border),
      borderRadius: BorderRadius.circular(Sizer.wp(10)),
    ),
    child: Padding(
      padding: EdgeInsets.all(Sizer.wp(12)),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Aligning items to both ends
        children: [
          Expanded(
            child: DropdownButton<String>(
              underline: Container(),
              isExpanded: true, // Make dropdown take full width
              value: "Select Team", // Keep the default value as "Select Team"
              style: TextStyle(color: AppColors.text),
              onChanged: (String? newValue) {
                // No logic is applied here as per the design you provided
              },
              items: _listItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          //
        ],
      ),
    ),
  );
}

Widget _buildropdownrow({String? title}) {
  return Padding(
    padding: EdgeInsets.only(
      left: Sizer.wp(16),
      top: Sizer.hp(16),
      right: Sizer.wp(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: TextStyle(
            fontSize: Sizer.wp(16),
            fontWeight: FontWeight.w600,
            color: AppColors.text,
          ),
        ),
        SizedBox(height: Sizer.hp(8)),
        _buildDropdown(),
      ],
    ),
  );
}

List<String> _listItems = ["Select Team", "Team1", "Team2", "Team3", "Team4"];
List<String> _listItems1 = ["Select Team", "Team1", "Team2", "Team3", "Team4"];
List<String> _listItems2 = ["Select Team", "Team1", "Team2", "Team3", "Team4"];
