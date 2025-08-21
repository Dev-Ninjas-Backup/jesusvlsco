// Employee Details Page
import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/features/time&clock/widget/custom_time_button.dart';
import 'package:jesusvlsco/features/time&clock/widget/custom_wide_slider/custom_wide_slider_widget.dart';
import 'package:jesusvlsco/features/time&clock/widget/custom_wide_slider/wide_slider_model.dart';
import 'package:jesusvlsco/features/time&clock/widget/date_picker_container.dart';
import 'package:jesusvlsco/features/time&clock/widget/time_counter.dart';

class EmployeeDetailsPage extends StatelessWidget {
  final EmployeeOverview employee;

  const EmployeeDetailsPage({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${employee.name} Details')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CustomTimeButton(
                      height: 40,
                      textcolor: Colors.white,
                      iconColor: Colors.white,
                      bgColor: AppColors.primary,
                      icon: Icons.add,
                      text: 'Add',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomTimeButton(
                      textcolor: Colors.white,
                      height: 40,
                      bgColor: Colors.green,
                      text: 'Approve',
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
                  DatePickerContainer(),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomTimeButton(
                      icon: Icons.file_download_outlined,
                      iconColor: Colors.white,
                      textcolor: Colors.white,
                      height: 40,
                      bgColor: Colors.green,
                      text: 'Approve',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(employee.imageUrl),
                        radius: 50,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${employee.name}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.message_outlined, color: AppColors.primary),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Chat with user',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
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
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.primary),
                child: Center(
                  child: Text(
                    'June 23 - June 29',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              CustomWideSliderWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
