
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/user_list_controller.dart'; // assuming EmployeeProfile is here

class UserTile extends StatelessWidget {
  final EmployeeProfile employee;

  const UserTile({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    final profile = employee.profile;

    return Column(
      children: [
        Obx(() => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Checkbox(
                value: employee.isSelected.value,
                onChanged: (val) {
                  employee.isSelected.value = val ?? false;
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${profile.firstName} ${profile.lastName}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              trailing: Text(
                employee.employeeID.toString(),
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            )),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }
}

