import 'package:flutter/material.dart';

class PublishCreateSurveyCheckbox extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget? child;

  const PublishCreateSurveyCheckbox({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          value: value,
          onChanged: (val) => onChanged(val ?? false),
          activeColor: const Color(0xFF4E53B1),
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(title),
        ),
        if (value && child != null)
          Padding(
            padding: const EdgeInsets.only(left: 40, bottom: 12),
            child: child!,
          ),
      ],
    );
  }
}
