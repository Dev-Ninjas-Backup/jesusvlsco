import 'package:flutter/material.dart';

class CustomTimeCounter extends StatelessWidget {
  const CustomTimeCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Regular', style: TextStyle(fontSize: 16)),
              Text('Overtime', style: TextStyle(fontSize: 16)),
              Text('Paid time off', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),

        SizedBox(height: 5),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  hintText: '8h',
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
                  alignLabelWithHint: true,
                ),
              ),
            ),
            Icon(Icons.add),
            Expanded(
              child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  hintText: '0h',
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
                  alignLabelWithHint: true,
                ),
              ),
            ),
            Icon(Icons.add),
            Expanded(
              child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  hintText: 'Oh',
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
                  alignLabelWithHint: true,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text('Total Paid Hours- 8h', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
