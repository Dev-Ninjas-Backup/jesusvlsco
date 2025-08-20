import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SecondRedCircularContainer extends StatelessWidget {
  const SecondRedCircularContainer({
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
            startAngle: 60,
            lineWidth: 24.0,
            percent: 0.67, 
            center: Text(
              "67%",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            progressColor: Colors.red,
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
                  text: '120',
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