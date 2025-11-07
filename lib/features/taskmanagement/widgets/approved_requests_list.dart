import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class ApprovedRequestsList extends StatefulWidget {
  const ApprovedRequestsList({super.key});

  @override
  State<ApprovedRequestsList> createState() => _ApprovedRequestsListState();
}

class _ApprovedRequestsListState extends State<ApprovedRequestsList> {
  final ScrollController _scrollController = ScrollController();
  double _sliderValue = 0.0;
  double _maxScrollExtent = 0.0;

  @override
  void initState() {
    super.initState();
    // Listen to scroll changes to update slider
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        setState(() {
          _sliderValue = _scrollController.offset;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Update the maximum scroll extent after build
  void _updateMaxScrollExtent() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        setState(() {
          _maxScrollExtent = _scrollController.position.maxScrollExtent;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Sample approved requests data
    final List<Map<String, dynamic>> approvedData = [
      {
        'name': 'Jane Cooper',
        'role': 'Project Manager',
        'timeOff': '22 Days',
        'timeOffRemaining': 'Remaining: 7 days',
        'sickLeave': '10 Days',
        'sickLeaveRemaining': 'Remaining: 2 days',
        'casualLeave': '12 Days',
        'casualLeaveRemaining': 'Remaining: 5 days',
        'unpaidLeave': '8 Days',
        'unpaidLeaveRemaining': 'Remaining: 8 days',
        'status': 'Approved',
        'statusColor': const Color(0xFF1EBD66),
        'statusBgColor': const Color(0xFFD9F0E4),
        'avatar':
            'https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      },
      {
        'name': 'Robert Fox',
        'role': 'Construction Site Manager',
        'timeOff': '22 Days',
        'timeOffRemaining': 'Remaining: 8 days',
        'sickLeave': '10 Days',
        'sickLeaveRemaining': 'Remaining: 3 days',
        'casualLeave': '12 Days',
        'casualLeaveRemaining': 'Remaining: 5 days',
        'unpaidLeave': '8 Days',
        'unpaidLeaveRemaining': 'Remaining: 7 days',
        'status': 'Rejected',
        'statusColor': const Color(0xFFF55059),
        'statusBgColor': const Color(0xFFFFE6E7),
        'avatar':
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      },
      {
        'name': 'Esther Howard',
        'role': 'Assistant Project Manager',
        'timeOff': '22 Days',
        'timeOffRemaining': 'Remaining: 5 days',
        'sickLeave': '10 Days',
        'sickLeaveRemaining': 'Remaining: 1 days',
        'casualLeave': '12 Days',
        'casualLeaveRemaining': 'Remaining: 4 days',
        'unpaidLeave': '8 Days',
        'unpaidLeaveRemaining': 'Remaining: 6 days',
        'status': 'Approved',
        'statusColor': const Color(0xFF1EBD66),
        'statusBgColor': const Color(0xFFD9F0E4),
        'avatar':
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      },
      {
        'name': 'Desirae Botosh',
        'role': 'Superintendent',
        'timeOff': '22 Days',
        'timeOffRemaining': 'Remaining: 10 days',
        'sickLeave': '10 Days',
        'sickLeaveRemaining': 'Remaining: 5 days',
        'casualLeave': '12 Days',
        'casualLeaveRemaining': 'Remaining: 5 days',
        'unpaidLeave': '8 Days',
        'unpaidLeaveRemaining': 'Remaining: 8 days',
        'status': 'Approved',
        'statusColor': const Color(0xFF1EBD66),
        'statusBgColor': const Color(0xFFD9F0E4),
        'avatar':
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      },
      {
        'name': 'Marley Stanton',
        'role': 'Coordinator',
        'timeOff': '22 Days',
        'timeOffRemaining': 'Remaining: 7 days',
        'sickLeave': '10 Days',
        'sickLeaveRemaining': 'Remaining: 2 days',
        'casualLeave': '12 Days',
        'casualLeaveRemaining': 'Remaining: 5 days',
        'unpaidLeave': '8 Days',
        'unpaidLeaveRemaining': 'Remaining: 8 days',
        'status': 'Rejected',
        'statusColor': const Color(0xFFF55059),
        'statusBgColor': const Color(0xFFFFE6E7),
        'avatar':
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      },
    ];

    // Update max scroll extent after build
    _updateMaxScrollExtent();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(169, 183, 221, 0.08),
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            // Scrollable table content
            SizedBox(
              height: Sizer.hp(400),
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: Sizer.wp(1272),
                  child: Column(
                    children: [
                      // Header row
                      _buildHeaderRow(),

                      // Data rows
                      Expanded(
                        child: ListView.builder(
                          itemCount: approvedData.length,
                          itemBuilder: (context, index) {
                            return _buildDataRow(approvedData[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Horizontal slider for scrolling
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizer.wp(16),
                vertical: Sizer.hp(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FlutterSlider(
                      handlerHeight: Sizer.hp(24),
                      handlerWidth: Sizer.wp(40),
                      touchSize: 20,
                      values: [_sliderValue],
                      max: _maxScrollExtent > 0 ? _maxScrollExtent : 100,
                      min: 0,
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        _scrollController.animateTo(
                          lowerValue,
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeInOut,
                        );
                      },
                      trackBar: FlutterSliderTrackBar(
                        activeTrackBarHeight: 12,
                        inactiveTrackBarHeight: 12,
                        activeTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.color4,
                        ),
                        inactiveTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.color4,
                        ),
                      ),
                      handler: FlutterSliderHandler(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const SizedBox.shrink(),
                      ),
                      tooltip: FlutterSliderTooltip(disabled: true),
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

  /// Build the header row for the table
  Widget _buildHeaderRow() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Sizer.wp(16),
        vertical: Sizer.hp(16),
      ),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFC8CAE7), width: 1)),
      ),
      child: Row(
        children: [
          _buildHeaderCell('Employee Name', Sizer.wp(236)),
          _buildHeaderCell('Time-off', Sizer.wp(140)),
          _buildHeaderCell('Sick leave', Sizer.wp(140)),
          _buildHeaderCell('Casual leave', Sizer.wp(140)),
          _buildHeaderCell('Unpaid leave', Sizer.wp(140)),
          _buildHeaderCell('Last Status', Sizer.wp(130)),
        ],
      ),
    );
  }

  /// Build a header cell
  Widget _buildHeaderCell(String title, double width) {
    return SizedBox(
      width: width,
      child: Text(
        title,
        style: AppTextStyle.f18W600().copyWith(color: AppColors.text),
      ),
    );
  }

  /// Build a data row
  Widget _buildDataRow(Map<String, dynamic> data) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Sizer.wp(16),
        vertical: Sizer.hp(24),
      ),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFC8CAE7), width: 1)),
      ),
      child: Row(
        children: [
          // Employee info
          SizedBox(
            width: Sizer.wp(236),
            child: Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: Sizer.wp(20),
                  backgroundImage: NetworkImage(data['avatar']),
                ),
                SizedBox(width: Sizer.wp(16)),

                // Name and role
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['name'],
                        style: AppTextStyle.f16W600().copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        data['role'],
                        style: AppTextStyle.f14W400().copyWith(
                          color: AppColors.textSecondaryGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Time-off
          _buildLeaveCell(
            data['timeOff'],
            data['timeOffRemaining'],
            Sizer.wp(140),
          ),

          // Sick leave
          _buildLeaveCell(
            data['sickLeave'],
            data['sickLeaveRemaining'],
            Sizer.wp(140),
          ),

          // Casual leave
          _buildLeaveCell(
            data['casualLeave'],
            data['casualLeaveRemaining'],
            Sizer.wp(140),
          ),

          // Unpaid leave
          _buildLeaveCell(
            data['unpaidLeave'],
            data['unpaidLeaveRemaining'],
            Sizer.wp(140),
          ),

          // Status
          SizedBox(
            width: Sizer.wp(130),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Sizer.wp(16),
                vertical: Sizer.hp(8),
              ),
              decoration: BoxDecoration(
                color: data['statusBgColor'],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  data['status'],
                  style: AppTextStyle.f16W500().copyWith(
                    color: data['statusColor'],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build a leave cell with days and remaining info
  Widget _buildLeaveCell(String days, String remaining, double width) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            days,
            style: AppTextStyle.f16W600().copyWith(color: AppColors.primary),
          ),
          Text(
            remaining,
            style: AppTextStyle.f14W400().copyWith(
              color: const Color(0xFF1EBD66),
            ),
          ),
        ],
      ),
    );
  }
}
