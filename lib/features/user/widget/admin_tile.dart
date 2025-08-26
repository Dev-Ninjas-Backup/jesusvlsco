import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/user/controller/admin_list_controller.dart';

class AdminTile extends StatelessWidget {
  final Admin admin;
  final VoidCallback onChanged;

  const AdminTile({super.key, required this.admin, required this.onChanged});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Obx(
          () => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Checkbox(
              value: admin.isSelected.value,
              onChanged: (_) => onChanged(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            title: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  //backgroundImage: NetworkImage(ImagePath.user1),
                  child: FittedBox(
                    child: Icon(Icons.person),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    admin.email,
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
              admin.employeeID.toString(),
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }
}
