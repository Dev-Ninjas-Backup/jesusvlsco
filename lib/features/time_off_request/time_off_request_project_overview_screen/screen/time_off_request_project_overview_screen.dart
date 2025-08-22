import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/time_off_request/time_off_request_project_overview_screen/controller/time_off_request_project_overview_controller.dart';
import 'package:jesusvlsco/features/time_off_request/time_off_request_project_overview_screen/widget/employe_name_row.dart';
import 'package:jesusvlsco/features/time_off_request/time_off_request_project_overview_screen/widget/first_name_container.dart';

// ignore: must_be_immutable
class TimeOffRequestProjectOverviewScreen extends StatelessWidget {
  TimeOffRequestProjectOverviewController controller = Get.put(TimeOffRequestProjectOverviewController());
   TimeOffRequestProjectOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Time Off Request Overview')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Overview Project 1",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF4E53B1),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [Icon(Icons.refresh_outlined), Text("Refresh")],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                "Time-off Requests",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0XFF4E53B1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              FirstNameContainer(
                name: 'Alex Wilson',
                date: 'Mar 28 2025',
                subjectType: 'Doctor appointment',
                statusText: "Pending",
                statusColor: Colors.orange,
                isPending: true,
              ),
              SizedBox(height: 8),
              FirstNameContainer(
                name: 'Jessica Lee',
                date: 'Mar 30 2025',
                subjectType: 'Sick Leave',
                statusText: "Approved",
                statusColor: Colors.green,
                isPending: false,
              ),
              SizedBox(height: 8),
              FirstNameContainer(
                name: 'Kristin Watson',
                date: 'June 02 2025',
                subjectType: 'Personal day',
                statusText: "Declined",
                statusColor: Colors.red,
                isPending: false,
              ),
              SizedBox(height: 8),
              Center(
                child: Text(
                  "End of Requests",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0XFF4E53B1),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Employee Name",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Time-off",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    
                  ),),
                ],
              ),
              Divider(),
              EmployeeNameRow(),
              SizedBox(height: 16,),
            ],
          ),
        ),
      ),
    );
  }
}
