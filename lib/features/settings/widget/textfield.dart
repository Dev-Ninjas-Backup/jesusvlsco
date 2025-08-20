import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? text;
  const CustomTextField({super.key, this.hintText, this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.deepPurple.shade100),
          ),
        ),
        style: TextStyle(color: Colors.black, fontSize: 16),
        cursorColor: Colors.deepPurple,
      ),
    );
  }
}
