import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class AssignedEmployeeList extends StatefulWidget {
  const AssignedEmployeeList({super.key});

  @override
  State<AssignedEmployeeList> createState() => _AssignedEmployeeListState();
}

class _AssignedEmployeeListState extends State<AssignedEmployeeList> {
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
    // Sample employee data
    final List<Map<String, dynamic>> employees = [
      {
        'name': 'Jane Cooper',
        'role': 'Project Manager',
        'project': 'Metro Shopping Center',
        'shift': 'Morning',
        'startTime': '9:00am',
        'endTime': '5:00pm',
        'date': '22/05/2025',
        'avatar':
            'https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      },
      {
        'name': 'Robert Fox',
        'role': 'Construction Site Manager',
        'project': 'Riverside Apartments',
        'shift': 'Night',
        'startTime': '9:00am',
        'endTime': '6:00pm',
        'date': '07/02/2025',
        'avatar':
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      },
      {
        'name': 'Esther Howard',
        'role': 'Assistant Project Manager',
        'project': 'City Bridge Renovations',
        'shift': 'Night',
        'startTime': '9:00am',
        'endTime': '6:00pm',
        'date': '22/06/2025',
        'avatar':
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      },
      {
        'name': 'Desirae Botosh',
        'role': 'Superintendent',
        'project': 'Tech Campus Phase 2',
        'shift': 'Morning',
        'startTime': '9:00am',
        'endTime': '5:00pm',
        'date': '02/02/2025',
        'avatar':
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      },
      {
        'name': 'Marley Stanton',
        'role': 'Coordinator',
        'project': 'Golden Hills Estates',
        'shift': 'Morning',
        'startTime': '9:00am',
        'endTime': '5:00pm',
        'date': '02/02/2025',
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
              color: Color.fromRGBO(169, 183, 221, 0.25),
              offset: Offset(0, 0),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section title
            Padding(
              padding: EdgeInsets.all(Sizer.wp(16)),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Assigned Employee',
                      style: AppTextStyle.f18W600().copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Divider
            Container(height: 1, color: const Color(0xFFE4E5F3)),

            // Scrollable table content
            SizedBox(
              height: Sizer.hp(495),
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: Sizer.wp(824),
                  child: Column(
                    children: [
                      // Header row
                      _buildHeaderRow(),

                      // Employee rows
                      Expanded(
                        child: ListView.builder(
                          itemCount: employees.length,
                          itemBuilder: (context, index) {
                            return _buildEmployeeRow(employees[index]);
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
      height: Sizer.hp(60),
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(20)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _buildHeaderCell('Employee', Sizer.wp(236)),
          _buildHeaderCell('Project Name', Sizer.wp(270)),
          _buildHeaderCell('Shift', Sizer.wp(140)),
          _buildHeaderCell('Date', null), // Flexible width
        ],
      ),
    );
  }

  /// Build a header cell
  Widget _buildHeaderCell(String title, double? width) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(12)),
      child: Text(
        title,
        style: AppTextStyle.f16W600().copyWith(color: AppColors.primary),
      ),
    );
  }

  /// Build an employee row
  Widget _buildEmployeeRow(Map<String, dynamic> employee) {
    return Container(
      height: Sizer.hp(80),
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(20)),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFC8CAE7), width: 1)),
      ),
      child: Row(
        children: [
          // Employee info (name and role with avatar)
          Container(
            width: Sizer.wp(236),
            padding: EdgeInsets.symmetric(horizontal: Sizer.wp(12)),
            child: Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: Sizer.wp(20),
                  backgroundImage: NetworkImage(employee['avatar']),
                ),
                SizedBox(width: Sizer.wp(16)),

                // Name and role
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        employee['name'],
                        style: AppTextStyle.f16W600().copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        employee['role'],
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

          // Project name
          Container(
            width: Sizer.wp(270),
            padding: EdgeInsets.symmetric(horizontal: Sizer.wp(12)),
            child: Text(
              employee['project'],
              style: AppTextStyle.f14W400().copyWith(color: AppColors.text),
            ),
          ),

          // Shift and time
          Container(
            width: Sizer.wp(140),
            padding: EdgeInsets.symmetric(horizontal: Sizer.wp(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  employee['shift'],
                  style: AppTextStyle.f14W400().copyWith(color: AppColors.text),
                ),
                SizedBox(height: Sizer.hp(4)),
                Text(
                  '${employee['startTime']} - ${employee['endTime']}',
                  style: AppTextStyle.f12W400().copyWith(color: AppColors.text),
                ),
              ],
            ),
          ),

          // Date
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizer.wp(12)),
              child: Text(
                employee['date'],
                style: AppTextStyle.f14W400().copyWith(color: AppColors.text),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
