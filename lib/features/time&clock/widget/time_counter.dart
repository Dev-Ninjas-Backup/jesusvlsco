import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:jesusvlsco/features/settings/widget/textfield.dart';

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
            children: [Text('data'), Text('data'), Text('data')],
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
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  constraints: BoxConstraints.tightFor(height: 40),
                  border: OutlineInputBorder(),
                  hintText: 'Enter text here',
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
                  alignLabelWithHint: true,
                ),
              ),
            ),
            Icon(Icons.add),
            Expanded(
              child: Column(children: [CustomTextField(hintText: 'text')]),
            ),
            Icon(Icons.add),
            Expanded(
              child: Column(children: [CustomTextField(hintText: 'text')]),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: Text('data')),
        ),
      ],
    );
  }
}
