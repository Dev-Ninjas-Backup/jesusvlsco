import 'package:flutter/material.dart';
import 'package:jesusvlsco/features/settings/widget/custom_switch.dart';

class NotificationContainer extends StatelessWidget {
  final String text;
  const NotificationContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: TextStyle(fontSize: 16)),
            CustomSwitch(),
          ],
        ),
        Divider(color: Colors.grey.shade300, thickness: 1),
      ],
    );
  }
}
