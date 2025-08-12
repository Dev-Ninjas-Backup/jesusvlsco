import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/user_list_controller.dart';

class UserTile extends StatelessWidget {
  final User user;
  final VoidCallback onChanged;

  const UserTile({super.key, required this.user, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Checkbox(
              value: user.isSelected.value,
              onChanged: (_) => onChanged(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            title: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(user.imageUrl),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    user.name,
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
              user.code,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }
}
