import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/core/utils/helpers/spacing_helper.dart';
import 'package:jesusvlsco/features/dashboard/admin_dashboard/controllers/dashboard_controller.dart';
import 'package:jesusvlsco/features/settings/screens/admin_time_clock2/screen/pending.dart';
import 'package:jesusvlsco/features/settings/screens/admin_time_clock2/widget/activity_widget.dart';
import 'package:jesusvlsco/features/settings/screens/admin_time_clock2/widget/date_picker.dart';
import 'package:jesusvlsco/features/settings/screens/admin_time_clock2/widget/second_date_picker/second_datepicker.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/custom_time_button.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/custom_wide_slider/custom_wide_slider_widget.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/search_bar.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/time_counter.dart';

class TimeAndClockScreen extends StatefulWidget {
  const TimeAndClockScreen({super.key});

  @override
  State<TimeAndClockScreen> createState() => _TimeAndClockScreenState();
}

class _TimeAndClockScreenState extends State<TimeAndClockScreen> {
  DashboardController dashboardController = Get.put(DashboardController());
  int _selectedTab = 0; // 0 for Timesheet, 1 for Payroll

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom_appbar(title: "Time Sheet"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: Column(
            children: [
              // Tab buttons
              Row(
                children: [
                  Expanded(
                    child: CustomTimeButton(
                      height: 40,
                      text: 'Timesheet',
                      textcolor: _selectedTab == 0
                          ? Colors.white
                          : Color(0xFF4A55A2),
                      brColor: Color(0xFF4A55A2),
                      bgColor: _selectedTab == 0
                          ? Color(0xFF4A55A2)
                          : Colors.transparent,
                      onTap: () {
                        setState(() {
                          _selectedTab = 0;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomTimeButton(
                      height: 40,
                      text: 'Payroll',
                      textcolor: _selectedTab == 1
                          ? Colors.white
                          : Color(0xFF4A55A2),
                      brColor: Color(0xFF4A55A2),
                      bgColor: _selectedTab == 1
                          ? Color(0xFF4A55A2)
                          : Colors.transparent,
                      onTap: () {
                        setState(() {
                          _selectedTab = 1;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              _selectedTab == 0
                  ? _buildTimesheetContent()
                  : _buildPayrollContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimesheetContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Time Period:', style: TextStyle(fontSize: 16)),
            SizedBox(width: 10),
            DatePicker(),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),

                child: GestureDetector(
                  onTap: () {
                    Get.to(PendingRequest());
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Text('1', style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          'Pending Request',
                          style: TextStyle(color: Colors.orange, fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        CustomTimeCounter(
          text: 'Totoal Hours- 8h',
          hintText1: '8h',
          hintText2: '0h',
          hintText3: '0h',
        ),
        SizedBox(height: 20),
        CustomSearchBar(),
        SizedBox(height: 20),
        CustomWideSliderWidget(),
        SizedBox(height: 20),
        _buildMapLocationView(),
        SizedBox(height: 20),
        Text(
          'Activity',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        SecondDatepicker(),
        SizedBox(height: 10),
        ActivityWidget(
          text: 'Jone Cooper Completed a Task',
          imagePath: 'assets/images/user01.svg',
        ),
        ActivityWidget(
          text: 'Jone Cooper Completed a Task',
          imagePath: 'assets/images/user01.svg',
        ),
        ActivityWidget(
          text: 'Jone Cooper Completed a Task',
          imagePath: 'assets/images/user01.svg',
        ),
        ActivityWidget(
          text: 'Jone Cooper Completed a Task',
          imagePath: 'assets/images/user01.svg',
        ),
      ],
    );
  }

  Widget _buildPayrollContent() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomTimeButton(
                text: 'Quikbooks',
                icon: Icons.check,
                brColor: AppColors.primary,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: CustomTimeButton(
                width: 180,
                text: 'Export',
                icon: Icons.file_download_outlined,
                brColor: AppColors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Time Period:', style: TextStyle(fontSize: 16)),
            SizedBox(width: 10),
            DatePicker(),
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.all(8),
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Text('1', style: TextStyle(color: Colors.white)),
                    ),
                    Text(
                      'Pending Req..',
                      style: TextStyle(color: Colors.orange, fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        CustomTimeCounter(
          text: 'Total Paid Hours- 202.75',
          hintText1: '183.75h',
          hintText2: '11h',
          hintText3: '11',
        ),
        SizedBox(height: 20),
        CustomSearchBar(),
        SizedBox(height: 30),
        CustomWideSliderWidget(),
      ],
    );
  }

  Widget _buildMapLocationView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMapTitleView(),
        Divider(
          color: AppColors.dividerColor,
          thickness: 1,
          height: Sizer.hp(16),
        ),
        SpacingHelper.h16(),
        Container(
          padding: EdgeInsets.all(Sizer.wp(16)),
          decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.circular(Sizer.wp(12)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFA9B7DD).withValues(alpha: 0.08),
                offset: const Offset(0, 4),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Sizer.wp(12)),
                child: SizedBox(
                  height: Sizer.hp(200),
                  width: double.infinity,
                  child: Obx(
                    () => GoogleMap(
                      onMapCreated: dashboardController.onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: dashboardController.initialCameraPosition,
                        zoom: 15,
                      ),
                      markers: dashboardController.markers,
                      myLocationEnabled: false,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                    ),
                  ),
                ),
              ),
              SpacingHelper.h12(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLegendItem(
                    'assets/icons/map_green_marker.png',
                    'Location 1',
                  ),
                  _buildLegendItem(
                    'assets/icons/map_yellow_marker.png',
                    'Location 2',
                  ),
                  _buildLegendItem(
                    'assets/icons/map_red_marker.png',
                    'Location 3',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String assetPath, String label) {
    return Expanded(
      child: Row(
        children: [
          Image.asset(assetPath, width: Sizer.wp(20), height: Sizer.wp(20)),
          SpacingHelper.w8(),
          Flexible(
            child: Text(
              label,
              style: AppTextStyle.f14W400().copyWith(
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapTitleView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Map Location',
          style: AppTextStyle.f18W600().copyWith(color: AppColors.primary),
        ),
        SizedBox(),
      ],
    );
  }
}
