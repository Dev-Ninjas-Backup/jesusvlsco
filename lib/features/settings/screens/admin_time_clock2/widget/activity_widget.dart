import 'package:flutter/material.dart';

class ActivityWidget extends StatelessWidget {
  final String text;
  final String imagePath;
  const ActivityWidget({
    super.key,
    required this.text,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('12:37 am'),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.deepPurple, width: 1.5),
                ),
                child: CircleAvatar(
                  radius: 10,
                  child: Icon(Icons.pages_outlined, size: 20),
                ),
              ),
              SizedBox(width: 20),
              CircleAvatar(backgroundImage: AssetImage(imagePath)),
              SizedBox(width: 20),
              Text(text),
            ],
          ),
        ],
      ),
    );
  }
}
