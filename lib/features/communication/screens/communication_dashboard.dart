// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/communication/screens/admin_chat_screen.dart';
import 'package:jesusvlsco/features/communication/screens/chat_info.dart';
import 'package:jesusvlsco/features/communication/screens/create_new_chat_screen.dart';
import 'package:jesusvlsco/features/communication/widgets/chat_dashboard.dart';
import 'package:jesusvlsco/features/communication/controllers/private_chat_controller.dart';
import 'package:jesusvlsco/routes/config/route_constants.dart';

class CommunicationDashboard extends StatefulWidget {
  const CommunicationDashboard({super.key});

  @override
  _CommunicationDashboardState createState() => _CommunicationDashboardState();
}

class _CommunicationDashboardState extends State<CommunicationDashboard> {
  int _selectedTabIndex = 0; // Default selected tab index

  // Get private chat controller for search and connection status
  final PrivateChatController _chatController =
      Get.find<PrivateChatController>();

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
                Row(
                  children: [
                    Text(
                      'Chat',
                      style: AppTextStyle.regular().copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: Sizer.wp(8)),
                    _buildConnectionIndicator(),
                  ],
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
                    InkWell(
                      onTap: () {
                        Get.to(ChatInfoScreen());
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
                            "assets/icons/settings.svg",

                            height: Sizer.hp(18),
                            width: Sizer.wp(18),
                          ),
                        ),
                      ),
                    ),
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

  // Placeholder for 'Unread' tab content
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
        onChanged: (value) => _chatController.searchQuery.value = value,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: 'Search conversations...',
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

  /// Build professional connection indicator (green/red dot)
  Widget _buildConnectionIndicator() {
    return Obx(() {
      final isConnected = _chatController.isConnected;

      return Container(
        width: Sizer.wp(10),
        height: Sizer.wp(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isConnected ? Colors.green : Colors.red,
          boxShadow: [
            BoxShadow(
              color: (isConnected ? Colors.green : Colors.red).withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 0),
            ),
          ],
        ),
      );
    });
  }

  // AppBar Widget
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
        'Communication',
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
          onPressed: () {
            context.pushNamed(RouteNames.drawer);
          },
        ),
      ],
    );
  }
}
