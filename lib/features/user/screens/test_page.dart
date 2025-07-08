import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.textWhite,
        backgroundColor: Colors.white,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'Announcement',
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(20),
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              // Handle menu action if needed
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar Widget
          _buildSearchBarWidget(),

          SizedBox(height: Sizer.hp(16)),

          // Announcement Card Widget
          _buildAnnouncementCard(),
          _buildAnnouncementCard(),
          _buildAnnouncementCard(),
        ],
      ),
    );
  }

  // Search Bar Widget
  Widget _buildSearchBarWidget() {
    return Column(
      children: [
        // Search TextField
        Padding(
          padding: EdgeInsets.only(
            left: Sizer.wp(16),
            right: Sizer.wp(16),
            top: Sizer.hp(24),
          ),
          child: Container(
            height: Sizer.hp(48),
            width: Sizer.wp(360),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizer.wp(8)),
              border: Border.all(
                color: AppColors.textSecondary.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                hintText: 'Search articles',
                hintStyle: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(14),
                  color: AppColors.textSecondary.withOpacity(0.6),
                ),
                suffixIcon: Container(
                  padding: EdgeInsets.all(
                    8,
                  ), // This creates smaller visual appearance
                  child: SvgPicture.asset(
                    'assets/icons/search-normal.svg',
                    height: Sizer.hp(20),
                    width: Sizer.wp(20),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Sizer.wp(16),
                  vertical: Sizer.hp(12),
                ),
              ),
            ),
          ),
        ),
    
        SizedBox(height: Sizer.hp(16)),
    _filter()
      ],
    );
  }









  // Announcement Card Widget
  Widget _buildAnnouncementCard() {
    return Padding(
      padding:  EdgeInsets.only(left: Sizer.wp(16), right: Sizer.wp(16)),
      child: Container(
        width: Sizer.wp(360),
        // margin: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(Sizer.wp(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time and Date
            Padding(
              padding: EdgeInsets.all(Sizer.wp(16)),
              child: Text(
                'Today at 03:00 pm',
                style: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(12),
                  color: AppColors.textSecondary.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
      
            // Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
              child: Text(
                'New Leave Policy Effective July 2025',
                style: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(16),
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
      
            // Description
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizer.wp(16),
                vertical: Sizer.hp(8),
              ),
              child: Text(
                'We have updated our leave policy to...',
                style: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(14),
                  color: AppColors.textSecondary.withOpacity(0.8),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
      
            // Buttons Row
            Padding(
              padding: EdgeInsets.all(Sizer.wp(16)),
              child: Row(
                children: [
                  // Response Button
                  Container(
                    height: Sizer.hp(36),
                    padding: EdgeInsets.symmetric(horizontal: Sizer.wp(20)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Sizer.wp(18)),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Handle response action
                      },
                      borderRadius: BorderRadius.circular(Sizer.wp(18)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.remove_red_eye_outlined,
                            color: AppColors.primary,
                            size: Sizer.wp(16),
                          ),
                          SizedBox(width: Sizer.wp(6)),
                          Text(
                            'Response',
                            style: AppTextStyle.regular().copyWith(
                              fontSize: Sizer.wp(13),
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      
                  SizedBox(width: Sizer.wp(12)),
      
                  // Read Receipt Button
                  Expanded(
                    child: Container(
                      height: Sizer.hp(36),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(Sizer.wp(18)),
                      ),
                      child: InkWell(
                        onTap: () {
                          // Handle read receipt action
                        },
                        borderRadius: BorderRadius.circular(Sizer.wp(18)),
                        child: Center(
                          child: Text(
                            'Read receipt',
                            style: AppTextStyle.regular().copyWith(
                              fontSize: Sizer.wp(13),
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Widget _filter(){
  return 
          // Filter and Date Buttons Row
          Padding(
            padding:  EdgeInsets.only(left: Sizer.wp(16), right: Sizer.wp(16)),
            child: Container(
          
              width: Sizer.wp(360),
              child: Row(
                children: [
                  // Filter Button
                  Expanded(
                    child: Container(
                      height: Sizer.hp(40),
                      decoration: BoxDecoration(
                        color: AppColors.textWhite,
                        borderRadius: BorderRadius.circular(Sizer.wp(8)),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          // Handle filter action
                        },
                        borderRadius: BorderRadius.circular(Sizer.wp(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.filter_list,
                              color: AppColors.primary,
                              size: Sizer.wp(18),
                            ),
                            SizedBox(width: Sizer.wp(8)),
                            Text(
                              'Filter',
                              style: AppTextStyle.regular().copyWith(
                                fontSize: Sizer.wp(14),
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              
                  SizedBox(width: Sizer.wp(12)),
              
                  // Date Button
                  Expanded(
                    child: Container(
                      height: Sizer.hp(40),
                      decoration: BoxDecoration(
                        color: AppColors.textWhite,
                        borderRadius: BorderRadius.circular(Sizer.wp(8)),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          // Handle date action
                        },
                        borderRadius: BorderRadius.circular(Sizer.wp(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: AppColors.primary,
                              size: Sizer.wp(18),
                            ),
                            SizedBox(width: Sizer.wp(8)),
                            Text(
                              'Date',
                              style: AppTextStyle.regular().copyWith(
                                fontSize: Sizer.wp(14),
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: Sizer.wp(4)),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.primary,
                              size: Sizer.wp(18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
}