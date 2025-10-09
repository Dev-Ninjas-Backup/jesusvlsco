import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

import '../../../../../core/services/storage_service.dart';

class UserWidelist extends StatefulWidget {
  final Function(int, bool)? onCheckboxChanged;
  final Function(Map<String, dynamic>)? onItemTap;

  const UserWidelist({super.key, this.onCheckboxChanged, this.onItemTap});

  @override
  State<UserWidelist> createState() => _UserWidelistState();
}

class _UserWidelistState extends State<UserWidelist> {
  final ScrollController _scrollController = ScrollController();
  double _sliderValue = 0.0;
  double _maxScrollExtent = 0.0;
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchTasks();
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

  Future<void> _fetchTasks() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final token = await StorageService.getAuthToken();

      final response = await http.get(
        Uri.parse(
          'https://lgcglobalcontractingltd.com/js/employee/project/task/all?page=1&limit=10',
        ),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['success'] == true) {
          final tasks = List<Map<String, dynamic>>.from(
            jsonData['data']['data'],
          );
          setState(() {
            _items = tasks.map((task) {
              return {
                'id': task['id'],
                'name': task['title'],
                'isSelected': false,
                'startTime': _formatDateTime(task['startTime']),
                'dueDate': _formatDateTime(task['endTime']),
                'assignTo': task['assignTo']['name'],
                'status': _capitalize(task['status']),
                'label': _capitalize(task['labels']),
                'avatarUrl': task['assignTo']['profileUrl'],
              };
            }).toList();
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
            _errorMessage = jsonData['message'] ?? 'Failed to fetch tasks';
          });
        }
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to fetch tasks: HTTP ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error fetching tasks: $e';
      });
    }
  }

  String _formatDateTime(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate).toLocal();
      return DateFormat('MM/dd/yyyy \'at\' hh:mm a').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  void _updateMaxScrollExtent() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients &&
          _maxScrollExtent != _scrollController.position.maxScrollExtent) {
        setState(() {
          _maxScrollExtent = _scrollController.position.maxScrollExtent;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _updateMaxScrollExtent();

    return Column(
      children: [
        Expanded(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : _errorMessage != null
              ? Center(
                  child: Text(
                    _errorMessage!,
                    style: AppTextStyle.regular().copyWith(
                      fontSize: 16,
                      color: AppColors.accent,
                    ),
                  ),
                )
              : _items.isEmpty
              ? Center(
                  child: Text(
                    'No tasks available',
                    style: AppTextStyle.semibold().copyWith(
                      fontSize: 18,
                      color: AppColors.textSecondary,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: Sizer.wp(1300),
                    child: Column(
                      children: [
                        _buildHeader(),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _items.length,
                            itemBuilder: (context, index) =>
                                _buildItem(_items[index], index),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        _buildSlider(),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
      color: AppColors.border1,
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Checkbox(
              value: _items.every((item) => item['isSelected'] == true),
              onChanged: (value) {
                if (value != null) {
                  for (int i = 0; i < _items.length; i++) {
                    setState(() {
                      _items[i]['isSelected'] = value;
                    });
                    widget.onCheckboxChanged?.call(i, value);
                  }
                }
              },
              activeColor: AppColors.primary,
            ),
          ),
          ...[
            "Title",
            "Status",
            "Label",
            "Start Time",
            "Due Date",
            "Assign To",
          ].map(
            (text) => SizedBox(
              width: Sizer.wp(200),
              child: Text(
                text,
                style: AppTextStyle.regular().copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(Map<String, dynamic> item, int index) {
    final status = item['status'] ?? 'Open';
    final statusColor = status == 'Completed'
        ? AppColors.success
        : status == 'In Progress'
        ? AppColors.primary
        : AppColors.success;
    final statusBg = status == 'Completed' ? AppColors.list : AppColors.button2;

    return InkWell(
      onTap: () => widget.onItemTap?.call(item),
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
        decoration: BoxDecoration(
          color: index % 2 == 0 ? Colors.white : Colors.grey[50],
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              child: Checkbox(
                value: item['isSelected'] ?? false,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _items[index]['isSelected'] = value;
                    });
                    widget.onCheckboxChanged?.call(index, value);
                  }
                },
                activeColor: AppColors.primary,
              ),
            ),
            _buildCell(item['name'], Sizer.wp(200)),
            SizedBox(width: Sizer.wp(21)),
            _buildStatusButton(status, statusBg, statusColor),
            SizedBox(width: Sizer.wp(24)),
            _buildStatusButton(
              item['label'] ?? 'Medium',
              AppColors.button2,
              AppColors.text,
            ),
            SizedBox(width: Sizer.wp(24)),
            _buildCell(item['startTime'], Sizer.wp(150)),
            SizedBox(width: Sizer.wp(24)),
            _buildCell(item['dueDate'], Sizer.wp(150)),
            SizedBox(width: Sizer.wp(24)),
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: item['avatarUrl'] != null
                      ? NetworkImage(item['avatarUrl'])
                      : null,
                  child: item['avatarUrl'] == null
                      ? Icon(Icons.person, size: 20)
                      : null,
                ),
                SizedBox(width: Sizer.wp(8)),
                _buildCell(item['assignTo'], Sizer.wp(150)),
              ],
            ),
            SizedBox(width: Sizer.wp(16)),
            SvgPicture.asset(
              'assets/icons/forum.svg',
              width: Sizer.wp(20),
              height: Sizer.wp(20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String? text, double width) {
    return SizedBox(
      width: width,
      child: Text(
        text ?? '',
        style: AppTextStyle.regular().copyWith(
          fontSize: 14,
          color: AppColors.text,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildStatusButton(String text, Color bgColor, Color textColor) {
    return Container(
      width: Sizer.wp(130),
      height: 40,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Text(
          text,
          style: AppTextStyle.regular().copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget _buildSlider() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizer.wp(16),
        vertical: Sizer.hp(8),
      ),
      child: FlutterSlider(
        handlerHeight: Sizer.hp(24),
        handlerWidth: Sizer.wp(40),
        touchSize: 20,
        values: [_sliderValue],
        max: _maxScrollExtent > 0 ? _maxScrollExtent : 100,
        min: 0,
        onDragging: (_, lowerValue, __) {
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
    );
  }
}
