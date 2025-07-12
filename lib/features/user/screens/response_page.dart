
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/models/user_model.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/user/screens/widgets/user_card.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResponsePage extends StatelessWidget {
  const ResponsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        shadowColor: AppColors.textWhite,
        backgroundColor: Colors.white,
        elevation: 4,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.arrow_left,
            color: AppColors.backgroundDark,
            size: Sizer.wp(24),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Response',
          style: AppTextStyle.regular().copyWith(
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
              // Handle menu action if needed
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Progress Cards Section
            SizedBox(height: Sizer.hp(24)),
            Row(
              children: [
                Expanded(
                  child: _buildProgressCard(
                    persentcolor: AppColors.progresstext,
                    title: '210 /250',
                    subtitle: 'Users have viewed',
                    progress: 210 / 250,
                    progressColor: AppColors.progress1,
                    icon: Icons.visibility,
                    iconColor: Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildProgressCard(
                       persentcolor: AppColors.error,
                    title: '40 /250',
                    subtitle: 'Users have not viewed',
                    progress: 40 / 250,
                    progressColor: AppColors.progress2,
                    icon: Icons.visibility_off,
                    iconColor: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // User List Section
            _buildUserListCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard({
    required String title,
    required String subtitle,
    required double progress,
    required Color progressColor,
    required IconData icon,
    required Color iconColor,
    required  Color persentcolor,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizer.wp(12)),
        boxShadow: [
          BoxShadow(
            color: AppColors.border.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        color: AppColors.primaryBackground,
      ),
      width: Sizer.wp(360),
      //  height: Sizer.hp(196),
      child: Padding(
        padding: EdgeInsets.all(Sizer.wp(16)),

        child: Container(
          width: Sizer.wp(159),
          //  height: Sizer.hp(164),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
             borderRadius: BorderRadius.circular(Sizer.wp(12)),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Progress Circle
              Center(
                child: CircularPercentIndicator(
                  radius: Sizer.wp(30.0),
                  lineWidth: 10.0,
                  animation: true,
                  percent: 85 / 100,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: progressColor,
                  backgroundColor: AppColors.secondary,
                ),
              ),
              Center(child: Text("${(progress * 100).toInt()}%",style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(12),
                fontWeight: FontWeight.w600,
                color: persentcolor,))),
              SizedBox(height: Sizer.wp(24)),

              // Title
              Text(
                title,
                style: AppTextStyle.textlarge().copyWith(
                  fontSize: Sizer.wp(18),
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 4),

              // Subtitle
              Text(
                subtitle,
                style: AppTextStyle.textlarge().copyWith(
                  fontSize: Sizer.wp(14),
                  fontWeight: FontWeight.w400,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserListCard() {
   
    // Separate User Data List
    final List<UserData> users = getUserData();  // Fetch from a function or database

    return Container(
      width: Sizer.wp(360),
      // height: Sizer.hp(671),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.border.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
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
                Expanded(
                  child: Text(
                    'Name',
                    style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(16),
                      color: AppColors.text,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  'Status',
                 style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(16),
                      color: AppColors.text,
                      fontWeight: FontWeight.w600,
                ),
              )  ],
            ),
          ),

          // User List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: users.length,
            separatorBuilder: (context, index) =>
                Divider(height: 1, color: AppColors.border),
            itemBuilder: (context, index) {
              final UserData userData = users[index];
              return userdata(user: userData);
            },
          ),
        ],
      ),
    );
  }

  // Function to fetch user data (can be fetched from an API or a database)
  List<UserData> getUserData() {
    return [
      UserData(
        name: 'Cody Fisher',
        avatar: 'assets/images/cody.jpg',
        status: 'Viewed',
        isViewed: true,
      ),
      UserData(
        name: 'Leslie Alexander',
        avatar: 'assets/images/leslie.jpg',
        status: 'Viewed',
        isViewed: true,
      ),
      UserData(
        name: 'Kristin Watson',
        avatar: 'assets/images/kristin.jpg',
        status: 'Viewed',
        isViewed: true,
      ),
      UserData(
        name: 'Robert Fox',
        avatar: 'assets/images/robert.jpg',
        status: 'Viewed',
        isViewed: true,
      ),
      UserData(
        name: 'Jacob Jones',
        avatar: 'assets/images/jacob1.jpg',
        status: 'Didn\'t viewed',
        isViewed: false,
      ),
      UserData(
        name: 'Jacob Jones',
        avatar: 'assets/images/jacob2.jpg',
        status: 'Viewed',
        isViewed: true,
      ),
      UserData(
        name: 'Jacob Jones',
        avatar: 'assets/images/jacob3.jpg',
        status: 'Didn\'t viewed',
        isViewed: false,
      ),
    ];
  }
}


