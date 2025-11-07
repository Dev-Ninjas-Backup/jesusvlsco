import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/poll/create_new_poll_two/screen/create_new_poll_two_screen.dart';
import 'package:jesusvlsco/features/survey_and_poll/create_new_survey_screen/widget/custom_survey_button.dart';

class SaveTemplateScreen extends StatelessWidget {
  const SaveTemplateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Save Template',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0XFF4E53B1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 24),
                Text(
                  "Employee Satisfaction Survey Template",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF4E53B1),
                  ),
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Search articles',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: CustomSurveyButton(
                        iconData: Icon(Icons.filter_list),
                        textTitle: "filter",
                        borderColor: Color(0xFF4E53B1),
                        fgColor: Color(0xFF4E53B1),
                        onPressedAction: () {
                          // Handle filter action
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "Add a field",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF4E53B1),
                  ),
                ),
                Divider(thickness: 1, color: Colors.grey.shade300),
                CustomSurveyButton(
                  iconData: Icon(Icons.description),
                  textTitle: "Description",
                  onPressedAction: () {
                    // Add your dropdown action here
                  },
                ),
                SizedBox(height: 12),
                CustomSurveyButton(
                  iconData: Icon(Icons.check_box),
                  textTitle: "Dropdown",
                  onPressedAction: () {
                    // Add your dropdown action here
                  },
                ),
                SizedBox(height: 12),
                CustomSurveyButton(
                  iconData: Icon(Icons.menu),
                  textTitle: "Open ended",
                  onPressedAction: () {
                    // Add your open-ended action here
                  },
                ),
                SizedBox(height: 12),
                CustomSurveyButton(
                  iconData: Icon(Icons.star_border_rounded),
                  textTitle: "Rating",
                  onPressedAction: () {
                    // Add your rating action here
                  },
                ),
                SizedBox(height: 16),
                Text(
                  "Employee Satisfaction Survey Template",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF4E53B1),
                  ),
                ),
                Divider(thickness: 1, color: Colors.grey.shade300),
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
                      textTitle: "Edit",
                      borderColor: Color(0XFF4E53B1),
                      fgColor: Color(0XFF4E53B1),
                      iconData: null,
                      mainAxisAlignment: MainAxisAlignment.center,
                      onPressedAction: () {
                        // Add your save template action here
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: CustomSurveyButton(
                      textTitle: "publish Survey",
                      bgColor: Color(0xFF4E53B1),
                      fgColor: Colors.white,
                      iconData: null,
                      mainAxisAlignment: MainAxisAlignment.center,
                      onPressedAction: () {
                        // Add your publish action here
                        Get.to(CreateNewPollTwoScreen());
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
