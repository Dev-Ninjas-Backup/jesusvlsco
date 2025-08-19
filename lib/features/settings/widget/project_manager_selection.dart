import 'package:flutter/material.dart';
import 'package:jesusvlsco/features/settings/widget/textfield_with_dropdown.dart';

class ProjectManagerSelection extends StatelessWidget {
  final List<String> items;
  final ValueNotifier<String?> selectedProjectValue;
  final ValueNotifier<String?> selectedManagerValue;

  const ProjectManagerSelection({
    Key? key,
    required this.items,
    required this.selectedProjectValue,
    required this.selectedManagerValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurple.shade100),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<String?>(
            valueListenable: selectedProjectValue,
            builder: (context, value, child) {
              return TextFieldWithDropDown(
                items: items,
                valueNotifier: selectedProjectValue,
                onChanged: (newValue) {
                  selectedProjectValue.value = newValue;
                },
                labelText: 'Select a project',
                hintText: 'Choose from the list',
                controller: null,
              );
            },
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.location_on_outlined, color: Colors.black, size: 16),
              SizedBox(width: 10),
              Text(
                'New York City',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text('Manager'),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ValueListenableBuilder<String?>(
                  valueListenable: selectedManagerValue,
                  builder: (context, value, child) {
                    return TextFieldWithDropDown(
                      items: items,
                      valueNotifier: selectedManagerValue,
                      onChanged: (newValue) {
                        selectedManagerValue.value = newValue;
                      },
                      labelText: 'Select a manager',
                      hintText: 'Choose from the list',
                      controller: null,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
