// ignore_for_file: unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/user/controllers/announcement_controller.dart';
import 'package:jesusvlsco/features/user/screens/add_announcement.dart';
import 'package:jesusvlsco/features/user/screens/widgets/announcement_card.dart';
import 'package:table_calendar/table_calendar.dart';

// Announcement Model

class AnnouncementDashboard extends StatefulWidget {
  const AnnouncementDashboard({super.key});

  @override
  State<AnnouncementDashboard> createState() => _AnnouncementDashboardState();
}

class _AnnouncementDashboardState extends State<AnnouncementDashboard> {
  final AnnouncementController _announcementController = Get.put(
    AnnouncementController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildSearchBarWidget(),
            SizedBox(height: Sizer.hp(16)),
            _buildAnnouncementsList(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      shadowColor: AppColors.textWhite,
      backgroundColor: Colors.white,
      elevation: 4,
      leading:  Icon(
            CupertinoIcons.arrow_left,
            color: AppColors.backgroundDark,
            size: Sizer.wp(24),
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
          icon:  Icon(
              CupertinoIcons.bars,
              color: AppColors.backgroundDark,
              size: Sizer.wp(24),
            ),
          onPressed: () {
            // Handle menu action if needed
          },
        ),
      ],
    );
  }

  Widget _buildSearchBarWidget() {
    return Column(
      children: [
        _buildSearchTextField(),
        SizedBox(height: Sizer.hp(16)),
        _buildFilterButtons(),
      ],
    );
  }

  Widget _buildSearchTextField() {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizer.wp(16),
        right: Sizer.wp(16),
        top: Sizer.hp(24),
      ),
      child: Container(
        height: Sizer.hp(48),
        width: Sizer.wp(360),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          borderRadius: BorderRadius.circular(Sizer.wp(8)),
          boxShadow: [
            BoxShadow(
              color: AppColors.textSecondary.withOpacity(0.1),
              blurRadius: 3,
              offset: const Offset(0, 4),
            ),
          ],
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
              padding: const EdgeInsets.all(8),
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
    );
  }

  Widget _buildFilterButtons() {
    return Padding(
      padding: EdgeInsets.only(left: Sizer.wp(16), right: Sizer.wp(16)),
      child: SizedBox(
        width: Sizer.wp(360),
        child: Row(
          children: [
            _buildAddButton(context,
            onpress: () {
              Get.to(() => const AddAnnouncement());
            },
            
            ),
            SizedBox(width: Sizer.wp(12)),
            _buildFilterButton(
              context,
              onpress: () {
                _showCustomDialog(context);
              },
            ),
            SizedBox(width: Sizer.wp(12)),
            _buildDateButton(
              onpress: () {
               
              },
            ),
            SizedBox(width: Sizer.wp(12)),
            _deleteButton(() {
          
_announcementController.toggleDelete();
// _announcementController.clickdelete();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context, {VoidCallback? onpress}) {
    return Expanded(
      child: InkWell(
        onTap: onpress,
        child: Container(
          height: Sizer.hp(40),
          width: Sizer.wp(94.67),
          decoration: BoxDecoration(
            color: AppColors.textWhite,
            borderRadius: BorderRadius.circular(Sizer.wp(8)),
            border: Border.all(
              color: AppColors.primary,
              width: 1,
            ),
          ),
          child: InkWell(
            onTap: onpress,
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
    );
  }

  Widget _buildAddButton(BuildContext context, {VoidCallback? onpress}) {
    return Container(
      height: Sizer.hp(40),
      width: Sizer.wp(94.67),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(Sizer.wp(8)),
      ),
      child: InkWell(
        onTap: onpress,
        borderRadius: BorderRadius.circular(Sizer.wp(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white, size: Sizer.wp(18)),
            SizedBox(width: Sizer.wp(8)),
            Text(
              'Add',
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(14),
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _deleteButton(VoidCallback onpress) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: Sizer.hp(40),
        width: Sizer.wp(40),
        decoration: BoxDecoration(
          // color: AppColors.primary,
          borderRadius: BorderRadius.circular(Sizer.wp(6)),
          border: Border.all(color: AppColors.primary, width: 1),
        ),
        child: InkWell(
          onTap: onpress,
          borderRadius: BorderRadius.circular(Sizer.wp(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: SvgPicture.asset(
                  'assets/icons/delete.svg',
                  height: Sizer.hp(20),
                  width: Sizer.wp(20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateButton({VoidCallback? onpress}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          // When the button is pressed, show the calendar
          _showCalendarDialog(context);
        },
        child: Container(
          height: Sizer.hp(40),
          width: Sizer.wp(94.67),
          decoration: BoxDecoration(
            color: AppColors.textWhite,
            borderRadius: BorderRadius.circular(Sizer.wp(8)),
            border: Border.all(
              color: AppColors.primary,
              width: 1,
            ),
          ),
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
    );
  }

  Widget _buildAnnouncementsList() {
    return FutureBuilder(
      future: _announcementController.fetchAnnouncements(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) =>
                SizedBox(height: Sizer.hp(16)),
            itemBuilder: (context, index) => AnnouncementCard(
              announcement:
                  snapshot.data![index],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildAlertBox(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizer.wp(12)),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              // Handle button press
              Get.back();
            },
            child: Text(
              'Category wise',
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(16),
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle button press
              Get.back();
            },
            child: Text(
              'Team wise',
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(16),
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return _buildAlertBox(context);
      },
    );
  }
}

void _showCalendarDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.primaryBackground,
        content: SizedBox(
          width: Sizer.wp(360),
          height: Sizer.hp(367),
          child: TableCalendar(
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),

              selectedDecoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            currentDay: DateTime.now(),
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: DateTime.now(),
            calendarFormat: CalendarFormat.month,
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            onDaySelected: (selectedDay, focusedDay) {
              // Close dialog and perform action on date selection
              Navigator.of(context).pop();
              print('Selected date: $selectedDay');
            },
            onPageChanged: (focusedDay) {
              // Optional: Update the calendar's focused day if needed
            },
          ),
        ),
      );
    },
  );
}
