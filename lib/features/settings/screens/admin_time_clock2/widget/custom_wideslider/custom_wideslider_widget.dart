import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/views/employee_screen.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/custom_wide_slider/wide_slider_controller.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/custom_wide_slider/wide_slider_model.dart';

class CustomWideSliderWidget extends StatelessWidget {
  final controller = Get.put(ProjectOverviewController());

  final List<EmployeeOverview> employees = const [
    EmployeeOverview(
      name: 'Jane Cooper',
      role: 'Project Manager',
      imageUrl: 'https://i.pravatar.cc/150?img=1',
      timeOff: '22',
      sickLeave: 7,
      casualLeave: 10,
      unpaidLeave: 6,
      status: 'Approved',
    ),
    EmployeeOverview(
      name: 'Robert Fox',
      role: 'Construction Site Manager',
      imageUrl: 'https://i.pravatar.cc/150?img=2',
      timeOff: '22',
      sickLeave: 6,
      casualLeave: 10,
      unpaidLeave: 8,
      status: 'Rejected',
    ),
    EmployeeOverview(
      name: 'Esther Howard',
      role: 'Assistant Project Manager',
      imageUrl: 'https://i.pravatar.cc/150?img=3',
      timeOff: '22',
      sickLeave: 5,
      casualLeave: 12,
      unpaidLeave: 6,
      status: 'Approved',
    ),
    EmployeeOverview(
      name: 'Desirae Botosh',
      role: 'Superintendent',
      imageUrl: 'https://i.pravatar.cc/150?img=4',
      timeOff: '22',
      sickLeave: 7,
      casualLeave: 9,
      unpaidLeave: 5,
      status: 'Rejected',
    ),
    EmployeeOverview(
      name: 'Marley Stanton',
      role: 'Coordinator',
      imageUrl: 'https://i.pravatar.cc/150?img=5',
      timeOff: '22',
      sickLeave: 7,
      casualLeave: 10,
      unpaidLeave: 6,
      status: 'Approved',
    ),
  ];

  CustomWideSliderWidget({super.key});

  void _navigateToEmployeeDetails(EmployeeOverview employee) {
    Get.to(() => EmployeeDetailsPage(employee: employee));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          SingleChildScrollView(
            controller: controller.scrollController,
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 8),
                SizedBox(
                  height: 300,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: employees
                          .map((e) => _buildEmployeeRow(e))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx(
              () => Slider(
                value: controller.sliderValue.value,
                onChanged: controller.onSliderChanged,
                min: 0,
                max: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          SizedBox(
            width: 210,
            child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            width: 100,
            child: Text(
              'Project',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              'Sick leave',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              'Casual leave',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              'Unpaid leave',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              'Last Status',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeRow(EmployeeOverview e) {
    return GestureDetector(
      onTap: () => _navigateToEmployeeDetails(e),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 210,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(e.imageUrl),
                      radius: 20,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          e.role,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                child: _buildStat('${e.timeOff} Days', 'Remaining'),
              ),
              SizedBox(
                width: 100,
                child: _buildStat('${e.sickLeave} Days', 'Remaining'),
              ),
              SizedBox(
                width: 100,
                child: _buildStat('${e.casualLeave} Days', 'Remaining'),
              ),
              SizedBox(
                width: 100,
                child: _buildStat('${e.unpaidLeave} Days', 'Remaining'),
              ),
              SizedBox(width: 100, child: _buildStatusChip(e.status)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String top, String bottom) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          top,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF4E53B1),
          ),
        ),
        Text(bottom, style: const TextStyle(fontSize: 12, color: Colors.green)),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    final isApproved = status == 'Approved';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isApproved ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isApproved ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
