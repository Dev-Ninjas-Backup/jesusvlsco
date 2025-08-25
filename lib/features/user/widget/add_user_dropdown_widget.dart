import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/add_user_controller.dart';

Widget buildDropdownField(
  String label,
  String hint,
  List<String> options,
  AddUserController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: Obx(
            () => DropdownButton<String>(
              isExpanded: true,
              hint: Text(hint, style: const TextStyle(color: Colors.grey)),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              value: _getValueForLabel(label, controller),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    style: const TextStyle(color: Colors.grey),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue == null) return;
                _setValueForLabel(label, newValue, controller);
              },
            ),
          ),
        ),
      ),
    ],
  );
}

String? _getValueForLabel(String label, AddUserController controller) {
  switch (label.toLowerCase()) {
    case 'gender':
      return controller.selectedGender.value;
    case 'job title':
      return controller.selectedJobTitle.value;
    case 'department':
      return controller.selectedDepartment.value;
    case 'city':
      return controller.selectedCity.value;
    case 'state':
      return controller.selectedState.value;
    default:
      return null;
  }
}

void _setValueForLabel(
  String label,
  String value,
  AddUserController controller,
) {
  switch (label.toLowerCase()) {
    case 'gender':
      controller.selectedGender.value = value;
      break;
    case 'job title':
      controller.selectedJobTitle.value = value;
      break;
    case 'department':
      controller.selectedDepartment.value = value;
      break;
    case 'city':
      controller.selectedCity.value = value;
      break;
    case 'state':
      controller.selectedState.value = value;
      break;
    default:
      break;
  }
}
