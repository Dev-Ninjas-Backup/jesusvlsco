import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class ChatDashboard extends StatelessWidget {
  ChatDashboard({super.key});

  // Dummy Data
  final List<Map<String, String>> _dummyData = [
    {
      'name': 'Sarah Johnson',
      'message': 'Thanks for the project....',
      'time': '2 min ago',
      'unread': '2',
    },
    {
      'name': 'Marvin McKinney',
      'message': 'Thanks for the project....',
      'time': '2 min ago',
      'unread': '2',
    },
    {
      'name': 'Kristin Watson',
      'message': 'Thanks for the project....',
      'time': '2 min ago',
      'unread': '2',
    },
    {
      'name': 'Esther Howard',
      'message': 'Thanks for the project....',
      'time': '2 min ago',
      'unread': '2',
    },
    {
      'name': 'Arlene McCoy',
      'message': 'Thanks for the project....',
      'time': '2 min ago',
      'unread': '2',
    },
    {
      'name': 'Kristin Watson',
      'message': 'Thanks for the project....',
      'time': '2 min ago',
      'unread': '2',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.all(Sizer.wp(16)),
        child: _buildUserList(),
      ),
    );
  }

  // User List
  Widget _buildUserList() {
    return ListView.builder(
      itemCount: _dummyData.length,
      itemBuilder: (context, index) {
        return _buildListItem(_dummyData[index]);
      },
    );
  }

  // List Item for each user
  Widget _buildListItem(Map<String, String> data) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Sizer.hp(8),
        horizontal: Sizer.wp(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Profile Avatar
              CircleAvatar(
                radius: Sizer.wp(15),
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1499714608240-22fc6ad53fb2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                ),
              ),
              SizedBox(width: Sizer.wp(12)),
              // Message and time
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['name'] ?? '',
                      style: AppTextStyle.regular().copyWith(
                        fontSize: Sizer.wp(16),
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: Sizer.hp(4)),
                    Text(
                      data['message'] ?? '',
                      style: AppTextStyle.regular().copyWith(
                        fontSize: Sizer.wp(14),
                        color: AppColors.textfield,
                      ),
                    ),
                  ],
                ),
              ),
              // Time and Unread Badge
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    data['time'] ?? '',
                    style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(12),
                      color: AppColors.textSecondary.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(height: Sizer.hp(4)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizer.wp(8),
                      vertical: Sizer.hp(4),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.circle,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      data['unread'] ?? '',
                      style: AppTextStyle.regular().copyWith(
                        fontSize: Sizer.wp(12),
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Sizer.hp(8)),
          Divider(color: AppColors.border2, height: 1), // Divider added here
        ],
      ),
    );
  }
}
