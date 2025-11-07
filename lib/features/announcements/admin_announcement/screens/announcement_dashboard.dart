// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/models/Announcemodel.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/announcements/admin_announcement/controllers/announcement_controller.dart';
import 'package:jesusvlsco/features/announcements/admin_announcement/screens/add_announcement.dart';
import 'package:jesusvlsco/features/announcements/admin_announcement/widgets/announcement_card.dart';
import 'package:table_calendar/table_calendar.dart';

// Announcement Model
class AnnouncementDashboard extends StatefulWidget {
  const AnnouncementDashboard({super.key});

  @override
  State<AnnouncementDashboard> createState() => _AnnouncementDashboardState();
}

final AnnouncementController _announcementController = Get.put(
  AnnouncementController(),
);

class _AnnouncementDashboardState extends State<AnnouncementDashboard> {
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
            SizedBox(height: Sizer.hp(24)),
            _pagination(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      shadowColor: AppColors.textWhite,
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
          icon: Icon(
            CupertinoIcons.bars,
            color: AppColors.backgroundDark,
            size: Sizer.wp(24),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchBarWidget() {
    return Column(
      children: [
        _buildSearchTextField(),
        // SizedBox(height: Sizer.hp(16)),
        _buildFilterButtons(),
      ],
    );
  }

  Widget _buildSearchTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizer.wp(16),
        vertical: Sizer.hp(24),
      ),
      child: Container(
        height: Sizer.hp(48),
        width: Sizer.wp(360),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(Sizer.wp(10)),

          boxShadow: [
            BoxShadow(
              color: AppColors.textSecondary.withValues(alpha: 0.1),
              blurRadius: 3,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: 'Search articles',
            hintStyle: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(14),
              color: AppColors.textSecondary.withValues(alpha: 0.6),
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
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
      child: Row(
        children: [
          _buildActionButton(
            label: 'Add',
            icon: Icons.add,
            color: AppColors.primary,
            onpress: () => Get.to(() => const AddAnnouncement()),
          ),
          SizedBox(width: Sizer.wp(12)),
          _buildActionButton(
            label: 'Filter',
            icon: Icons.filter_list,
            color: AppColors.primary,
            onpress: () => _showCustomDialog(context),
          ),
          SizedBox(width: Sizer.wp(12)),
          _buildActionButton(
            label: 'Date',
            icon: Icons.calendar_today,
            color: AppColors.primary,
            onpress: () => _showCalendarDialog(context),
          ),
          SizedBox(width: Sizer.wp(12)),
          _deleteButton(() {
            _announcementController.toggleDelete();
            _showDeleteDialog(context);
          }),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onpress,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onpress,
        child: Container(
          height: Sizer.hp(40),
          width: Sizer.wp(94.67),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(Sizer.wp(8)),
            border: Border.all(color: color, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: Sizer.wp(18)),
              SizedBox(width: Sizer.wp(8)),
              Text(
                label,
                style: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(14),
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
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
          borderRadius: BorderRadius.circular(Sizer.wp(6)),
          border: Border.all(color: AppColors.primary, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/delete.svg',
              height: Sizer.hp(20),
              width: Sizer.wp(20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementsList() {
    final AnnouncementController announcementController = Get.put(
      AnnouncementController(),
    );
    return SizedBox(
      height: Sizer.hp(500),
      child: Obx(() {
        // Fetch paginated announcements from the controller
        List<AnnouncementModel> pagedAnnouncements = announcementController
            .getPagedAnnouncements();

        if (pagedAnnouncements.isEmpty) {
          return const Center(child: Text('No announcements available.'));
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: pagedAnnouncements.length,
          itemBuilder: (context, index) {
            // Build the announcement card using the paginated data
            return Padding(
              padding: EdgeInsets.symmetric(vertical: Sizer.hp(8)),
              child: AnnouncementCard(announcement: pagedAnnouncements[index]),
            );
          },
        );
      }),
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
              showCategoryChecklistPopup(context);
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
              showteamChecklistPopup(context);
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

  void showCategoryChecklistPopup(BuildContext context) {
    // List to store checkbox state for each category
    List<bool> checkboxStates = List.generate(
      _announcementController.categories.length,
      (index) => false,
    );

    // Show the AlertDialog
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: SizedBox(
            width: Sizer.wp(328),
            height: Sizer.hp(208),

            child: ListView.builder(
              itemCount: _announcementController.categories.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(_announcementController.categories[index]),
                  value: checkboxStates[index],
                  onChanged: (bool? value) {
                    checkboxStates[index] = value!;
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Done',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showteamChecklistPopup(BuildContext context) {
    // List to store checkbox state for each category
    List<bool> checkboxStates = List.generate(
      _announcementController.teams.length,
      (index) => false,
    );

    // Show the AlertDialog
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: SizedBox(
            width: Sizer.wp(328),
            height: Sizer.hp(208),

            child: ListView.builder(
              itemCount: _announcementController.teams.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(_announcementController.teams[index]),
                  value: checkboxStates[index],
                  onChanged: (bool? value) {
                    checkboxStates[index] = value!;
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Done',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDeleteAlert(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizer.wp(12)),
      ),
      title: Column(
        children: [
          Icon(
            Icons.cancel_outlined,
            color: AppColors.error,
            size: Sizer.wp(48),
          ),
          Text(
            "Are you sure",
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(20),
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: Text(
        "Do you want to delete these records? This process cannot be undone",
        style: AppTextStyle.regular().copyWith(
          fontSize: Sizer.wp(16),
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: CupertinoButton(
                color: AppColors.error,
                child: Text(
                  "Delete",
                  style: AppTextStyle.regular().copyWith(
                    fontSize: Sizer.wp(16),
                    color: AppColors.primaryBackground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  _announcementController.clickdelete();
                  Get.back();
                },
              ),
            ),
            Expanded(
              child: CupertinoButton(
                // style: CupertinoButton.bordered,
                child: Text(
                  "Cancel",
                  style: AppTextStyle.regular().copyWith(
                    fontSize: Sizer.wp(16),
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ],
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

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return _buildDeleteAlert(context);
      },
    );
  }

  void _showCalendarDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryBackground,
          content: SizedBox(
            width: Sizer.wp(360),
            height: Sizer.hp(380),
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
                Navigator.of(context).pop();
                if (kDebugMode) {
                  print('Selected date: $selectedDay');
                }
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
}

Widget _pagination() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      2, // Assuming there are 2 pages
      (index) {
        return GestureDetector(
          onTap: () {
            _announcementController.changePage(
              index + 1,
            ); // Set current page to tapped index (1-based)
          },
          child: Obx(
            () => Container(
              margin: EdgeInsets.symmetric(
                horizontal: 8,
              ), // Add space between boxes
              width: Sizer.wp(36), // Width of the box
              height: Sizer.hp(36), // Height of the box
              decoration: BoxDecoration(
                color: _announcementController.currentPage.value == index + 1
                    ? AppColors
                          .primary // Highlight selected page with blue
                    : Colors
                          .transparent, // Default color for non-selected pages
                borderRadius: BorderRadius.circular(8), // Rounded corners
                border: Border.all(
                  color: _announcementController.currentPage.value == index + 1
                      ? AppColors.primary
                      : AppColors.border, // Border color
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  '${index + 1}', // Display page number (index + 1 for 1-based indexing)
                  style: AppTextStyle.regular().copyWith(
                    fontSize: 14,
                    color:
                        _announcementController.currentPage.value == index + 1
                        ? Colors
                              .white // White text for selected page
                        : Colors.black, // Black text for non-selected pages
                    fontWeight: FontWeight.bold, // Bold text
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
