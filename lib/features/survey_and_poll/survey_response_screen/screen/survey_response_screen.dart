import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/survey_and_poll/create_new_survey_screen/widget/custom_survey_button.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_report/screen/survey_report_screen.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_response_screen/widget/first_green_circular_container.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_response_screen/widget/question_1_container.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_response_screen/widget/second_red_circular_container.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_response_screen/widget/third_participation_container.dart';

class SurveyResponseScreen extends StatelessWidget {
  const SurveyResponseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Survey Response')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomSurveyButton(
                      textTitle: "Survey Report",
                      bgColor: Color(0xFF4E53B1),
                      fgColor: Colors.white,
                      onPressedAction: () {
                        // Handle survey response action
                        Get.to(SurveyReportScreen());
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomSurveyButton(
                      textTitle: "Survey Response",
                      onPressedAction: () {
                        // Handle survey response action
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text("Owner: Admin"),
              SizedBox(height: 8),
              Text("Status: Active"),
              SizedBox(height: 8),
              Text("Duration: May 1- May 15, 2025"),
              SizedBox(height: 24),
              FirstGreenCircularContainer(),
              SizedBox(height: 24),
              SecondRedCircularContainer(),
              SizedBox(height: 24),
              ThirdParticipationContainer(),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Questions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF4E53B1),
                    ),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(fontSize: 16, color: Color(0xFF4E53B1)),
                  ),
                ],
              ),
              SizedBox(height: 16),
              //Question1Container(),
              SizedBox(
                height: 700,
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Question1Container();
                  },
                ),
              ),

              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
