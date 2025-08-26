
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class UserWidelist extends StatefulWidget {
  
  final List<Map<String, dynamic>>? data;
  final Function(int, bool)? onCheckboxChanged;
  final Function(Map<String, dynamic>)? onItemTap;

  const UserWidelist({super.key, this.data, this.onCheckboxChanged, this.onItemTap});

  @override
  State<UserWidelist> createState() => _UserWidelistState();
}

class _UserWidelistState extends State<UserWidelist> {
  final ScrollController _scrollController = ScrollController();
  double _sliderValue = 0.0;
  double _maxScrollExtent = 0.0;
  
  List<Map<String, dynamic>> get items => widget.data ?? _defaultData;

  static final List<Map<String, dynamic>> _defaultData = List.generate(6, (i) => {
    'id': i,
    'name': 'Task ${i + 1} - Shopping Center',
    'isSelected': false,
    'startTime': '${10 + i}/12/2024 at ${12 + i}:00 PM',
    'dueDate': '${10 + i}/12/2024 at ${12 + i}:00 PM',
    'assignTo': ['John Doe', 'Jane Smith', 'Alice Brown', 'Bob Wilson', 'Carol Davis', 'David Johnson'][i],
    'status': ['Open', 'In Progress', 'Completed', 'Pending', 'Open', 'In Progress'][i],
    'label': ['High', 'Medium', 'Low', 'High', 'Medium', 'Low'][i],
    'avatarUrl': "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
  });

  @override
  void initState() {
    super.initState();
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
      if (_scrollController.hasClients && _maxScrollExtent != _scrollController.position.maxScrollExtent) {
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
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: Sizer.wp(1200),
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) => _buildItem(items[index], index),
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: AppColors.border1,
      child: Row(
        children: [
          SizedBox(width: 60, child: Checkbox(value: true, onChanged: null, activeColor: AppColors.primary)),
          ...[
            "Title", "Status", "Label", "Start Time", "Due Date", "Assign To"
          ].map((text) => SizedBox(
            width: Sizer.wp(200),
            child: Text(
              text,
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(16),
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildItem(Map<String, dynamic> item, int index) {
    final status = item['status'] ?? 'Open';
    final statusColor = status == 'Completed' ? AppColors.success : 
                      status == 'In Progress' ? AppColors.primary : AppColors.success;
    final statusBg = status == 'Completed' ? AppColors.list : AppColors.button2;

    return InkWell(
      onTap: () => widget.onItemTap?.call(item),
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: index % 2 == 0 ? Colors.white : Colors.grey[50],
          border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              child: Checkbox(
                value: item['isSelected'] ?? false,
                onChanged: (value) => widget.onCheckboxChanged?.call(index, value ?? false),
                activeColor: AppColors.primary,
              ),
            ),
            
            _buildCell(item['name'], Sizer.wp(200)),
            const SizedBox(width: 21),
            
            _buildStatusButton(status, statusBg, statusColor),
            const SizedBox(width: 24),
            
            _buildStatusButton(item['label'] ?? 'Open', AppColors.button2, AppColors.text),
            const SizedBox(width: 24),
            
            _buildCell(item['startTime'], Sizer.wp(150)),
            const SizedBox(width: 24),
            
            _buildCell(item['dueDate'], Sizer.wp(150)),
            const SizedBox(width: 24),
            
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: item['avatarUrl'] != null ? NetworkImage(item['avatarUrl']) : null,
                  child: item['avatarUrl'] == null ? const Icon(Icons.person, size: 20) : null,
                ),
                const SizedBox(width: 8),
                _buildCell(item['assignTo'], Sizer.wp(150)),
              ],
            ),
            const SizedBox(width: 16),
            
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
        style: AppTextStyle.regular().copyWith(fontSize: Sizer.wp(14), color: AppColors.text),
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
            fontSize: Sizer.wp(14),
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget _buildSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
              BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
            ],
          ),
          child: const SizedBox.shrink(),
        ),
        tooltip:  FlutterSliderTooltip(disabled: true),
      ),
    );
  }
}