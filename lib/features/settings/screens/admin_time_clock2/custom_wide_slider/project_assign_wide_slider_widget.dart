import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/settings/screens/admin_time_clock2/custom_wide_slider/project_assign_wide_slider_controller.dart';
import 'package:jesusvlsco/features/settings/screens/admin_time_clock2/widget/side_popup.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/views/employee_screen.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/screens/widgets/custom_wide_slider/wide_slider_model.dart';

class ProjectAssignWideSliderWidget extends StatelessWidget {
  final controller = Get.put(EmployeeTimeSchemeController());

  final List<EmployeeOverview> employees = const [
    EmployeeOverview(
      name: 'Jane Cooper',
      role: 'Project Manager',
      imageUrl: 'https://i.pravatar.cc/150?img=1',
      timeOff: 'Riverside Apartments',
      sickLeave: 7,
      casualLeave: 10,
      unpaidLeave: 6,
      status: 'Approved',
    ),
    EmployeeOverview(
      name: 'Robert Fox',
      role: 'Construction Site Manager',
      imageUrl: 'https://i.pravatar.cc/150?img=2',
      timeOff: 'JesusVLSCO',
      sickLeave: 6,
      casualLeave: 10,
      unpaidLeave: 8,
      status: 'Rejected',
    ),
    EmployeeOverview(
      name: 'Esther Howard',
      role: 'Assistant Project Manager',
      imageUrl: 'https://i.pravatar.cc/150?img=3',
      timeOff: 'Riverside Apartments',
      sickLeave: 5,
      casualLeave: 12,
      unpaidLeave: 6,
      status: 'Approved',
    ),
    EmployeeOverview(
      name: 'Desirae Botosh',
      role: 'Superintendent',
      imageUrl: 'https://i.pravatar.cc/150?img=4',
      timeOff: 'Riverside Apartments',
      sickLeave: 7,
      casualLeave: 9,
      unpaidLeave: 5,
      status: 'Rejected',
    ),
    EmployeeOverview(
      name: 'Marley Stanton',
      role: 'Coordinator',
      imageUrl: 'https://i.pravatar.cc/150?img=5',
      timeOff: 'Riverside Apartments',
      sickLeave: 7,
      casualLeave: 10,
      unpaidLeave: 6,
      status: 'Approved',
    ),
  ];

  ProjectAssignWideSliderWidget({super.key});

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
            child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            width: 200,
            child: Text(
              'Project',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text('Start', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            width: 120,
            child: Text('End', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            width: 120,
            child: Text(
              'Total Hours',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              'Daily Total',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              'Weekly Total',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              'Regular',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              'OvertimeX1.5',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text('Notes', style: TextStyle(fontWeight: FontWeight.bold)),
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

                    Text(
                      e.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 200, child: _buildStat()),
              SizedBox(width: 120, child: _buildStatTime('${e.sickLeave} AM')),
              SizedBox(
                width: 120,
                child: _buildStatTime('${e.casualLeave} PM'),
              ),
              SizedBox(
                width: 120,
                child: _buildStatTime('${e.unpaidLeave} Hours'),
              ),
              SizedBox(
                width: 120,
                child: _buildStatTime('${e.unpaidLeave} Hours'),
              ),
              SizedBox(
                width: 120,
                child: _buildStatTime('${e.unpaidLeave} Hours'),
              ),
              SizedBox(
                width: 120,
                child: _buildStatTime('${e.unpaidLeave} Hours'),
              ),
              SizedBox(
                width: 120,
                child: _buildStatTime('${e.unpaidLeave} USD'),
              ),
              SizedBox(width: 120, child: _buildStatTime('View Notes')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [SidePopup()],
    );
  }

  Widget _buildStatTime(String top) {
    return Text(
      top,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFF4E53B1),
      ),
    );
  }
}
