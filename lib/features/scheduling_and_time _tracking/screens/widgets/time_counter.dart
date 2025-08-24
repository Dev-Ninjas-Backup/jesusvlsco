import 'package:flutter/material.dart';

class CustomTimeCounter extends StatelessWidget {
  final String? hintText1;
  final String? hintText2;
  final String? hintText3;
  final String? text;
  const CustomTimeCounter({
    super.key,
    this.text,
    this.hintText1,
    this.hintText2,
    this.hintText3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Regular', style: TextStyle(fontSize: 16)),

              SizedBox(width: 1),

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

                  hintText: hintText1,
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

                  hintText: hintText2,

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

                  hintText: hintText3,

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
            child: Text(text ?? '', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
