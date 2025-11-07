import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/features/settings/widget/project_manager_delete.dart';
import 'package:jesusvlsco/features/settings/widget/project_manager_selection.dart';

class ProjectManagement extends StatelessWidget {
  final List<String> items = [
    'Project 1',
    'Second Option',
    'Third Option',
    'Fourth Option',
  ];

  final ValueNotifier<String?> selectedProjectValue = ValueNotifier(null);
  final ValueNotifier<String?> selectedManagerValue = ValueNotifier(null);

  ProjectManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom_appbar(title: "Project Management"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Project',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A55A2),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(Icons.add, color: Color(0xFF4A55A2)),
                      SizedBox(width: 5),
                      Text(
                        'Add New',
                        style: TextStyle(
                          color: Color(0xFF4A55A2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ProjectManagerSelection(items: items),
            SizedBox(height: 20),
            ProjectManagerDelete(items: items),
            SizedBox(height: 20),
            ProjectManagerDelete(items: items),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 45,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Save Changes'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
