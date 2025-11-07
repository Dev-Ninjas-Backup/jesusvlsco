import 'package:flutter/material.dart';

class TextFieldWithDropDown extends StatelessWidget {
  final List<String> items;
  final ValueNotifier<String?> valueNotifier; // Use ValueNotifier
  final String labelText;
  final String? hintText;
  final ValueChanged<String?> onChanged;
  final InputDecoration? decoration;
  final String? text;
  final Color? color;

  const TextFieldWithDropDown({
    super.key,
    this.text,
    this.color,
    required this.items,
    required this.valueNotifier,
    required this.onChanged,
    this.labelText = 'Select an item',
    this.hintText,
    this.decoration,
    required controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: valueNotifier,
      builder: (context, value, child) {
        return SizedBox(
          height: 50,
          child: TextField(
            controller: TextEditingController(text: value),

            decoration:
                decoration ??
                InputDecoration(
                  hintText: hintText,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.deepPurple.shade100),
                  ),
                  suffixIcon: PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    onSelected: onChanged,
                    itemBuilder: (BuildContext context) {
                      return items.map<PopupMenuEntry<String>>((String value) {
                        return PopupMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList();
                    },
                  ),
                ),
          ),
        );
      },
    );
  }
}
