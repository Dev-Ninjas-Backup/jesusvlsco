import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_response_screen/screen/survey_response_screen.dart';

import 'package:jesusvlsco/features/survey_and_poll/survey_screen/controller/survey_and_poll_screen_controller.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_screen/widget/filter_dialog.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_screen/widget/proposal_card.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_screen/widget/servey_linear.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_screen/widget/show_alert_box.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_screen/widget/survey_poll_statistic_cirle.dart';
import 'package:jesusvlsco/features/survey_and_poll/view_eye/screen/view_eye_screen.dart';

import '../../response_screen/screen/response_screen.dart';

// ignore: must_be_immutable
class SurveyAndPollScreen extends StatelessWidget {
  SurveyAndPollScreenController controller = Get.put(
    SurveyAndPollScreenController(),
  );
  SurveyAndPollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Survey & Poll",
          style: TextStyle(color: Color(0XFF4E53B1)),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Search Surveys',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              //ActionButtonsRow(),
              ProposalCard(
                onCreatePressed: () {
                  // Handle create action
                  showSurveyCustomAlertBox(context);
                  //Get.to(CreateNewPollScreen());
                },
                onFilterPressed: () {
                  // Handle filter action
                  showDialog(
                    context: context,
                    builder: (_) => const FilterDialog(),
                  );
                },
                onDatePressed: () {
                  // Handle date action
                },
                onMorePressed: () {
                  // Handle more action
                },
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Checkbox(value: false, onChanged: (val) {}),
                  ),
                  Text("Survey Title", style: TextStyle(fontSize: 16)),
                  Spacer(flex: 2),
                  Text("Status", style: TextStyle(fontSize: 16)),
                  Spacer(flex: 1),
                ],
              ),
              Obx(
                () => SizedBox(
                  height: 400,
                  child: SingleChildScrollView(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.surveys.length,
                      itemBuilder: (context, index) {
                        final survey = controller.surveys[index];
                        // ignore: unused_local_variable
                        final isActive = survey.status == "Active";

                        return Row(
                          children: [
                            SizedBox(
                              width: 40,
                              child: Checkbox(
                                value: false,
                                onChanged: (val) {},
                              ),
                            ),
                            Text(survey.title, style: TextStyle(fontSize: 16)),
                            Spacer(flex: 2),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: survey.status == "Completed"
                                    ? Colors.yellow.withOpacity(0.3)
                                    : Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                survey.status,
                                style: TextStyle(
                                  color: survey.status == "Completed"
                                      ? Colors.black
                                      : Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.to(ResponseScreen());
                              },
                              icon: Icon(Icons.more_vert),
                            ),
                            //Spacer(flex: 1),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Surveys & Polls",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4E53B1),
                    ),
                  ),
                  Text(
                    "view all",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4E53B1),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.grey, thickness: 1),
              SurveyPollStatisticCircle(),
              SizedBox(height: 16),
              SurveyPollStatisticCircle(
                title: "Employee Engagement Survey",
                percent: 0.75,
                responseRate: "75%",
                totalResponses: 175,
                totalPeople: 200,
                progressColor: Color(0xFF084298),
                onViewPressed: () {
                  // Handle view action
                  Get.to(ViewEyeScreen());
                },
              ),
              SizedBox(height: 16),
              SurveyPollStatisticCircle(
                title: "Health & Safety Feedback",
                percent: 0.68,
                responseRate: "68%",
                totalResponses: 136,
                totalPeople: 200,
                progressColor: Color(0xFFFF9200),
                onViewPressed: () {
                  // Handle view action
                  Get.to(ViewEyeScreen());
                },
              ),
              SizedBox(height: 16),
              SurveyPollStatisticCircle(
                title: "Benefits Satisfaction Survey",
                percent: 0.62,
                responseRate: "62%",
                totalResponses: 140,
                totalPeople: 200,
                progressColor: Color(0xFF0D6EFD),
                onViewPressed: () {
                  // Handle view action

                  Get.to(SurveyResponseScreen());

                  Get.to(ViewEyeScreen());

                },
              ),
              SizedBox(height: 16),
              SurveyProgressCard(
                title:
                    "How satisfied are you with the current safety protocols on-site?",
                totalResponses: 200,
                status: "Closed",
                options: [
                  SurveyOption("Very Satisfied", 60),
                  SurveyOption("Satisfied", 14),
                  SurveyOption("Neutral", 05),
                  SurveyOption("Dissatisfied", 20),
                  SurveyOption("Very Dissatisfied", 11),
                ],
              ),
              SizedBox(height: 16),
              SurveyProgressCard(
                title:
                    "How satisfied are you with your role in the current project?",
                totalResponses: 200,
                status: "Closed",
                containerBGColor: Colors.amber,
                options: [
                  SurveyOption("Very Satisfied", 60),
                  SurveyOption("Satisfied", 14),
                  SurveyOption("Neutral", 05),
                  SurveyOption("Dissatisfied", 20),
                  SurveyOption("Very Dissatisfied", 11),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
