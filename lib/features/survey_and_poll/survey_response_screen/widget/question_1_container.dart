import 'package:flutter/material.dart';
import 'package:jesusvlsco/features/survey_and_poll/survey_response_screen/widget/custom_pie_chart.dart';

class Question1Container extends StatelessWidget {
  const Question1Container({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question 1 : How satisfied are you with your current job?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text("Answer:"),
          Row(
            children: [
              CustomPieChart(
                size: 100,
                strokeWidth: 25,
                segments: [
                  RingSegment(color: Colors.green, fraction: 0.4),
                  RingSegment(color: Colors.greenAccent, fraction: 0.15),
                  RingSegment(color: Colors.red, fraction: 0.10),
                  RingSegment(color: Colors.orange, fraction: 0.15),
                  RingSegment(color: Colors.yellow, fraction: 0.20),
                ],
              ),
              SizedBox(width: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Answer"),
                  _statisticsRow(
                    circleColor: Colors.green,
                    nameText: "Very Satisfied",
                   // percentage: "15%",
                  ),
                  _statisticsRow(
                    circleColor: Colors.greenAccent,
                    nameText: "Satisfied",
                    //percentage: "40%",
                  ),
                  _statisticsRow(
                    circleColor: Colors.red,
                    nameText: "Neutral",
                   // percentage: "25%",
                  ),
                  _statisticsRow(
                    circleColor: Colors.orange,
                    nameText: "Dissatisfied",
                   // percentage: "15%",
                  ),
                  _statisticsRow(
                    circleColor: Colors.yellow,
                    nameText: "Very Dissatisfied",
                    //percentage: "5%",
                  ),
                  
                ],
              ),
              Spacer(flex: 1,),
              Column(
                children: [
                  SizedBox(height: 16),
                  Text("15%"),
                  Text("40%"),
                  Text("25%"),
                  Text("15%"),
                  Text("5%"),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _statisticsRow({
    required Color circleColor,
    required String nameText,
    //required String percentage,
  }) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Text(nameText),

        //Text(percentage, style: TextStyle(color: Colors.black)),
      ],
    );
  }
}
