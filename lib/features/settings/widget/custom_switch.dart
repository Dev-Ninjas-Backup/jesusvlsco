import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final ValueNotifier<bool> isSwitched = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isSwitched,
      builder: (context, value, child) {
        return Switch(
          value: value,
          onChanged: (newValue) {
            isSwitched.value = newValue;
          },
        );
      },
    );
  }
}
