import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/poll/create_new_poll/screen/create_new_poll_screen.dart';
import 'package:jesusvlsco/features/survey_and_poll/create_new_survey_screen/controller/create_new_survey_screen_controller.dart';
import 'package:jesusvlsco/features/survey_and_poll/create_new_survey_screen/controller/open_ended_field_controller.dart';
import 'package:jesusvlsco/features/survey_and_poll/create_new_survey_screen/controller/rating_field_controller.dart';
import 'package:jesusvlsco/features/survey_and_poll/create_new_survey_screen/widget/custom_survey_button.dart';
import 'package:jesusvlsco/features/survey_and_poll/create_new_survey_screen/widget/drop_down_field_dialog.dart';
import 'package:jesusvlsco/features/survey_and_poll/create_new_survey_screen/widget/open_ended_field_dialog.dart';
import 'package:jesusvlsco/features/survey_and_poll/create_new_survey_screen/widget/rating_field_dialog.dart';
import 'package:jesusvlsco/features/survey_and_poll/save_template/screen/save_template_screen.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_publish_screen/create_new_survey_screen/screen/publish_create_new_survey_screen.dart';

class CreateNewSurveyScreen extends StatelessWidget {
  final CreateNewSurveyScreenController controller = Get.put(
    CreateNewSurveyScreenController(),
  );
  CreateNewSurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create New',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0XFF4E53B1),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Type"),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: 'Survey',
                        border: OutlineInputBorder(),
                      ),
                      icon: Icon(Icons.keyboard_arrow_down_outlined),
                      items: ['Survey', 'Poll']
                          .map(
                            (option) => DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            ),
                          )
                          .toList(),
                      onChanged: (value) async {
                        if (value == 'Poll') {
                          Get.back();
                          Get.to(CreateNewPollScreen());
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    Text("Survey Title"),
                    SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter survey title here',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text("Description"),
                    SizedBox(height: 8),
                    TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Enter survey description here',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Add a field",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF4E53B1),
                ),
              ),
              Divider(thickness: 1, color: Colors.grey.shade300),
              SizedBox(height: 16),
              CustomSurveyButton(
                iconData: Icon(Icons.check_box),
                textTitle: "Dropdown",
                onPressedAction: () {
                  if (!Get.isRegistered<CreateNewSurveyScreenController>()) {
                    Get.put(CreateNewSurveyScreenController());
                  }

                  showDialog(
                    context: context,
                    builder: (_) => DropdownFieldDialog(),
                  );
                },
              ),
              SizedBox(height: 12),
              CustomSurveyButton(
                iconData: Icon(Icons.menu),
                textTitle: "Open ended",
                onPressedAction: () {
                  // Add your open-ended action here
                  if (!Get.isRegistered<OpenEndedFieldController>()) {
                    Get.put(OpenEndedFieldController());
                  }

                  showDialog(
                    context: context,
                    builder: (_) => OpenEndedFieldDialog(),
                  );
                },
              ),
              SizedBox(height: 12),
              CustomSurveyButton(
                iconData: Icon(Icons.star_border_rounded),
                textTitle: "Rating",
                onPressedAction: () {
                  // Add your rating action here
                  if (!Get.isRegistered<RatingFieldController>()) {
                    Get.put(RatingFieldController());
                  }

                  showDialog(
                    context: context,
                    builder: (_) => RatingFieldDialog(),
                  );
                },
              ),
              SizedBox(height: 16),
              Text(
                "Survey title",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF4E53B1),
                ),
              ),
              Divider(thickness: 1, color: Colors.grey.shade300),
              SizedBox(height: 16),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.menu),
                              SizedBox(width: 8),
                              Text("Please Write your full name"),
                              Spacer(),
                              Icon(Icons.delete),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: CustomSurveyButton(
                      textTitle: "Save Template",
                      borderColor: Color(0XFF4E53B1),
                      iconData: null,
                      mainAxisAlignment: MainAxisAlignment.center,
                      onPressedAction: () {
                        Get.to(SaveTemplateScreen());
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomSurveyButton(
                      textTitle: "publish",
                      bgColor: Color(0xFF4E53B1),
                      fgColor: Colors.white,
                      iconData: null,
                      mainAxisAlignment: MainAxisAlignment.center,
                      onPressedAction: () {
                        // Add your publish action here
                        //Get.to(CreateNewPollTwoScreen());
                        Get.to(CreateNewSurveyPublishScreen());
                      },
                    ),
                  ),
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
