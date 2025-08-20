import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class FirstGreenCircularContainer extends StatelessWidget {
  const FirstGreenCircularContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300,width: 1),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 50.0,
            startAngle: 290,
            lineWidth: 24.0,
            percent: 0.33, // 33%
            center: Text(
              "33%",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            progressColor: Colors.green,
            backgroundColor: Colors.grey.shade300,
            circularStrokeCap: CircularStrokeCap.round,
            animation: true,
            animationDuration: 800,
          ),
          SizedBox(width: 16),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '80',
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: ' / ',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                TextSpan(
                  text: '200',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                TextSpan(
                  text: ' users completed',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}