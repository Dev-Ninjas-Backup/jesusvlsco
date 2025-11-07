import 'package:flutter/material.dart';
import 'package:jesusvlsco/features/settings/widget/textfield_with_dropdown.dart';

class ProjectManagerSelection extends StatefulWidget {
  final List<String> items;

  const ProjectManagerSelection({super.key, required this.items});

  @override
  State<ProjectManagerSelection> createState() =>
      _ProjectManagerSelectionState();
}

class _ProjectManagerSelectionState extends State<ProjectManagerSelection> {
  late final ValueNotifier<String?> selectedProjectValue;
  late final ValueNotifier<String?> selectedManagerValue;

  @override
  void initState() {
    super.initState();
    selectedProjectValue = ValueNotifier<String?>(null);
    selectedManagerValue = ValueNotifier<String?>(null);
  }

  @override
  void dispose() {
    selectedProjectValue.dispose();
    selectedManagerValue.dispose();
    super.dispose();
  }

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
                items: widget.items,
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
                      items: widget.items,
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
