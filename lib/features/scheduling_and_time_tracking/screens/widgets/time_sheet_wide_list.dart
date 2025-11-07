// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class TimeSheetWideList extends StatefulWidget {
  const TimeSheetWideList({super.key});

  @override
  State<TimeSheetWideList> createState() => _TimeSheetWideListState();
}

class _TimeSheetWideListState extends State<TimeSheetWideList> {
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
    List<Map<String, dynamic>> shoppingCenters = [
      {
        'name': 'Metro Shopping Center',
        'isSelected': true,
        'startTime': '10/12/2024 at 12:00 PM',
        'dueDate': '10/12/2024 at 12:00 PM',
        'assignTo': 'John Doe',
        'infoIcon': 'assets/icons/forum.svg',
      },
      {
        'name': 'Downtown Plaza Mall',
        'isSelected': false,
        'startTime': '11/12/2024 at 1:00 PM',
        'dueDate': '11/12/2024 at 1:00 PM',
        'assignTo': 'Jane Smith',
        'infoIcon': 'assets/icons/forum.svg',
      },
      {
        'name': 'City Center Shopping Complex',
        'isSelected': false,
        'startTime': '12/12/2024 at 2:00 PM',
        'dueDate': '12/12/2024 at 2:00 PM',
        'assignTo': 'Alice Brown',
        'infoIcon': 'assets/icons/forum.svg',
      },
      // Add more items as needed
    ];

    // Update max scroll extent after build
    _updateMaxScrollExtent();

    return Column(
      children: [
        // XSlider for horizontal scrolling control

        // Main scrollable content
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header section (with grey background)
                  Container(
                    height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: AppColors.border1, // Grey background
                      border: Border(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Checkbox
                        Checkbox(
                          value: true,
                          onChanged: (bool? value) {},
                          activeColor: AppColors.primary,
                        ),

                        // Shopping center name
                        _header_item(context, "Title"),

                        // Shopping center name header
                        _header_item(context, "Status"),

                        // Info header
                        _header_item(context, "Label"),

                        // First button header
                        _header_item(context, "Start Time"),

                        // Second button header
                        _header_item(context, "Due Date"),

                        // First date header
                        _header_item(context, "Assign To"),
                      ],
                    ),
                  ),

                  // List items dynamically from the map
                  ...shoppingCenters.map((center) {
                    return Container(
                      height: 80,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Checkbox
                          Checkbox(
                            value: center['isSelected'],
                            onChanged: (bool? value) {},
                            activeColor: AppColors.primary,
                          ),
                          SizedBox(width: Sizer.wp(12)),

                          // Shopping center name
                          SizedBox(
                            width: Sizer.wp(200),
                            child: Text(
                              center['name'],
                              style: AppTextStyle.regular().copyWith(
                                fontSize: Sizer.wp(14),
                                color: AppColors.text,
                              ),
                            ),
                          ),
                          SizedBox(width: Sizer.wp(21)),

                          // Info icon
                          SvgPicture.asset(
                            center['infoIcon'],
                            width: Sizer.wp(20),
                            height: Sizer.wp(20),
                          ),
                          SizedBox(width: Sizer.wp(24)),

                          // First button (Open)
                          Container(
                            width: Sizer.wp(130),
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.list,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Center(
                              child: Text(
                                "Open",
                                style: AppTextStyle.regular().copyWith(
                                  fontSize: Sizer.wp(14),
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.success,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: Sizer.wp(24)),

                          // Second button (Open)
                          Container(
                            width: Sizer.wp(130),
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.button2,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Center(
                              child: Text(
                                "Open",
                                style: AppTextStyle.regular().copyWith(
                                  fontSize: Sizer.wp(14),
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: Sizer.wp(24)),

                          // Start time (dummy data)
                          SizedBox(
                            width: Sizer.wp(150),
                            child: Text(
                              center['startTime'],
                              style: AppTextStyle.regular().copyWith(
                                fontSize: Sizer.wp(14),
                                color: AppColors.text,
                              ),
                            ),
                          ),
                          SizedBox(width: Sizer.wp(24)),

                          // Due date (dummy data)
                          SizedBox(
                            width: Sizer.wp(150),
                            child: Text(
                              center['dueDate'],
                              style: AppTextStyle.regular().copyWith(
                                fontSize: Sizer.wp(14),
                                color: AppColors.text,
                              ),
                            ),
                          ),
                          SizedBox(width: Sizer.wp(24)),

                          // Avatar (dummy data)
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
                            ),
                          ),
                          SizedBox(width: Sizer.wp(8)),

                          // Assign to (dummy data)
                          SizedBox(
                            width: Sizer.wp(200),
                            child: Text(
                              center['assignTo'],
                              style: AppTextStyle.regular().copyWith(
                                fontSize: Sizer.wp(14),
                                color: AppColors.text,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: Sizer.hp(30),
                      width: Sizer.wp(30),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: Center(
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: Sizer.wp(8)),
                    Text(
                      "Add Task",
                      style: AppTextStyle.regular().copyWith(
                        fontSize: Sizer.wp(14),
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                      duration: Duration(milliseconds: 100),
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: SizedBox.shrink(), // Invisible widget
                  ),
                  tooltip: FlutterSliderTooltip(disabled: true),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _header_item(BuildContext context, String text) {
  return SizedBox(
    width: Sizer.wp(200),
    child: Text(
      text,
      style: AppTextStyle.regular().copyWith(
        fontSize: Sizer.wp(16),
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      ),
    ),
  );
}
