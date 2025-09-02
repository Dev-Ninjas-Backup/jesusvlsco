import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_screen/controller/survey_and_poll_screen_controller.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_screen/widget/action_popup_menu.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_screen/widget/filter_dialog.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_screen/widget/proposal_card.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_screen/widget/servey_linear.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_screen/widget/show_alert_box.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_screen/widget/survey_poll_statistic_cirle.dart';

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
        //actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
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
              ProposalCard(
                onCreatePressed: () {
                  showSurveyCustomAlertBox(context);
                },
                onFilterPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const FilterDialog(),
                  );
                },
                onDatePressed: () {
                  controller.pickDate(context);
                },
                onMorePressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ActionDialog(
                      onView: () => debugPrint('View tapped'),
                      onEdit: () => debugPrint('Edit tapped'),
                      //onDelete: () => debugPrint('Delete tapped'),
                      onDelete:
                          //delete function will work here
                          controller.selectedSurveys.values.any(
                            (selected) => selected,
                          )
                          ? () => controller.deleteSelectedSurveys()
                          : null,

                      //Get.snackbar("alert", "delete success");
                    ),
                  );
                },
              ),
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value:
                          controller.selectedSurveys.values.every(
                            (selected) => selected,
                          ) &&
                          controller.surveys.isNotEmpty,
                      onChanged: (value) {
                        for (var survey in controller.surveys) {
                          controller.selectedSurveys[survey.id] =
                              value ?? false;
                        }
                        controller.selectedSurveys.refresh();
                        //controller.isSelectedUser.value = value ??false;
                      },
                    ),
                  ),
                  Text("Survey Title", style: TextStyle(fontSize: 16)),
                  Spacer(flex: 2),
                  Text("Status", style: TextStyle(fontSize: 16)),
                  Spacer(flex: 1),
                ],
              ),
              Obx(
                () => controller.isLoading.value
                    ? SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : SizedBox(
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
                                    child: Obx(
                                      () => Checkbox(
                                        value:
                                            controller.selectedSurveys[survey
                                                .id] ??
                                            false,
                                        onChanged: (value) => controller
                                            .toggleSurveySelection(survey.id),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      survey.title,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Spacer(flex: 2),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: survey.status == "Completed"
                                          // ignore: deprecated_member_use
                                          ? Colors.yellow.withValues(alpha: 0.3)
                                          // ignore: deprecated_member_use
                                          : Colors.green.withValues(alpha: 0.1),
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
                                ],
                              );
                            },
                          ),
                        ),
                      ),
              ),

              //survey circular statistics
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
              //
              Obx(
                () => controller.isLoadingAnalytics.value
                    ? SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.surveyAnalytics.length,
                        itemBuilder: (context, index) {
                          final analytics = controller.surveyAnalytics[index];

                          return Column(
                            children: [
                              SurveyPollStatisticCircle(
                                title: analytics.title,
                                percent: analytics.responsePercentage / 100,
                                responseRate:
                                    "${analytics.responsePercentage.toInt()}%",
                                totalResponses: analytics.respondedCount,
                                totalPeople: analytics.totalAssigned,
                                progressColor: _getProgressColor(
                                  analytics.responsePercentage,
                                ),
                                onViewPressed: () {
                                  Get.snackbar(
                                    "Info:",
                                    "View is not completed",
                                  );
                                  //Get.to(ViewEyeScreen());
                                  // You can pass the surveyId to the next screen
                                  // Get.to(SurveyResponseScreen(surveyId: analytics.surveyId));
                                },
                              ),
                              SizedBox(height: 16),
                            ],
                          );
                        },
                      ),
              ),
              SizedBox(height: 16),

              //survey linear statistics
              Obx(
                () => controller.isLoadingPoolResponses.value
                    ? SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Column(
                        children: List.generate(
                          controller.poolResponses.length,
                          (index) {
                            final poolResponse =
                                controller.poolResponses[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: SurveyProgressCard(
                                title: poolResponse.title,
                                totalResponses: poolResponse.totalResponse,
                                status: poolResponse.totalResponse > 0
                                    ? "Closed"
                                    : "Open",
                                containerBGColor: poolResponse.totalResponse > 0
                                    ? Colors.amber
                                    : Colors.green,
                                options: poolResponse.options
                                    .map(
                                      (option) => SurveyOption(
                                        option.option,
                                        option.responsePercentage.toInt(),
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          },
                        ),
                      ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Color _getProgressColor(double percentage) {
    if (percentage >= 80) {
      return Colors.green;
    } else if (percentage >= 60) {
      return Color(0xFF0D6EFD);
    } else if (percentage >= 40) {
      return Color(0xFFFF9200);
    } else {
      return Colors.red;
    }
  }
}
