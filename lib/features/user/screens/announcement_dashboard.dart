import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class AnnouncementDashboard extends StatelessWidget {
  const AnnouncementDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        shadowColor: AppColors.textWhite,
        backgroundColor: Colors.white,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: (){},
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
          Container(
            width: Sizer.wp(360),
            height: Sizer.hp(50),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.textSecondary.withOpacity(0.1),
                  blurRadius: Sizer.wp(10),
                  offset: Offset(0, Sizer.hp(2)),
              )],
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Sizer.wp(16)),
                bottomRight: Radius.circular(Sizer.wp(16)),
              ),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                ),
            ),
            
            
            )
        ],
      ),
    );
  }
}