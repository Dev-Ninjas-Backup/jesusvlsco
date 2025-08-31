import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeListFilterDialog extends StatelessWidget {
  const EmployeeListFilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final RxMap<String, bool> filters = {
      "All": false,
      "Active": false,
      "Completed": false,
    }.obs;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: filters.keys.map((key) {
                return CheckboxListTile(
                  value: filters[key],
                  onChanged: (val) {
                    filters[key] = val ?? false;

                    final selected = filters.entries
                        .where((e) => e.value)
                        .map((e) => e.key)
                        .toList();

                    if (selected.contains("All")) {
                      // controller.getActiveSurveys(); // Load all
                    } else {
                      // controller.surveys.value = controller.surveys
                      //     .where((s) => selected.contains(s.status))
                      //     .toList();
                    }
                  },
                  title: Text(key),
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
