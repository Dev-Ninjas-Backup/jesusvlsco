import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/common/styles/global_text_style.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/sizer.dart';
import '../../communication/screens/admin_chat_screen.dart';
import '../../communication/screens/create_new_chat_screen.dart';
import '../../communication/widgets/chat_dashboard.dart';

class UserCommunicationScreen extends StatefulWidget {
  const UserCommunicationScreen({super.key});

  @override
  State<UserCommunicationScreen> createState() =>
      _UserCommunicationScreenState();
}

class _UserCommunicationScreenState extends State<UserCommunicationScreen> {
  int _selectedTabIndex = 0;
  // Default selected tab index
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Sizer.wp(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chat',
                  style: AppTextStyle.regular().copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(CreateNew());
                      },
                      child: Container(
                        height: Sizer.hp(34),
                        width: Sizer.wp(34),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Sizer.wp(8)),
                          child: SvgPicture.asset(
                            "assets/icons/edit.svg",

                            height: Sizer.hp(18),
                            width: Sizer.wp(18),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Sizer.wp(8)),
                  ],
                ),
              ],
            ),
          ),
          // Search Text Field
          Padding(
            padding: EdgeInsets.only(
              left: Sizer.wp(16),
              right: Sizer.wp(16),
              bottom: Sizer.hp(16),
            ),
            child: _buildSearchTextField(),
          ),
          // Custom Tab Bar
          Padding(
            padding: EdgeInsets.only(left: Sizer.wp(16), right: Sizer.wp(16)),
            child: _buildTabBar(),
          ),
          // Placeholder for Tab Content
          Expanded(child: _buildTabContent()),
        ],
      ),
    );
  }

  // Custom Tab Bar widget
  Widget _buildTabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildTabBarItem('All', 0),
        _buildTabBarItem('Unread', 1),
        _buildTabBarItem('Team', 2),
      ],
    );
  }

  // Tab Bar Item with Active State Management
  Widget _buildTabBarItem(String text, int index) {
    bool isSelected = _selectedTabIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Sizer.wp(8)),
        padding: EdgeInsets.symmetric(
          vertical: Sizer.hp(10),
          horizontal: Sizer.wp(20),
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : AppColors.background, // Background color change
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: Sizer.wp(16),
            fontWeight: FontWeight.w500,
            color: isSelected
                ? Colors.white
                : AppColors.primary, // Text color change
          ),
        ),
      ),
    );
  }

  // Placeholder for Tab Content
  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return InkWell(
          onTap: () {
            Get.to(Admin_chatscreen());
          },
          child: ChatDashboard(),
        );
      case 1:
        return _buildUnreadContent();
      case 2:
        return _buildTeamContent();
      default:
        return Container();
    }
  }

  // Placeholder for 'All' tab content
  Widget _buildUnreadContent() {
    return Center(child: Text('Unread Content Goes Here'));
  }

  // Placeholder for 'Team' tab content
  Widget _buildTeamContent() {
    return Center(child: Text('Team Content Goes Here'));
  }

  // Search Text Field Widget
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
          hintText: 'Search',
          hintStyle: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(14),
            color: AppColors.textSecondary.withValues(alpha: 0.6),
          ),
          suffixIcon: Container(
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

  // AppBar Widget
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      shadowColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 0.1,

      title: Text(
        'Communication',
        style: TextStyle(
          fontSize: Sizer.wp(20),
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
    );
  }
}
