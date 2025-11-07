// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/models/user_model.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';


class userdata extends StatelessWidget {
  const userdata({
    super.key,
    required this.user,
  });

  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: false,
              onChanged: (value) {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 16),
    
          // Avatar
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primary,
            child: Text(
              user.name
                  .split(' ')
                  .map((e) => e[0])
                  .join()
                  .toUpperCase(),
              style: AppTextStyle.semiregular().copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
    
          // Name
          Expanded(
            child: Text(
              user.name,
              style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(16),
            color: AppColors.text,
            fontWeight: FontWeight.w600,
          ),
            ),
          ),
    
          // Status
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: user.isViewed
                  ? Colors.green[50]
                  : Colors.red[50],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              user.status,
              style: AppTextStyle.semiregular().copyWith(
                color: user.isViewed
                    ? Colors.green[700]
                    : Colors.red[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}