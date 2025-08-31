import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/user/model/team_list_model.dart';

class TeamTile extends StatelessWidget {
  final TeamListModel team;
  final VoidCallback onChanged;

  const TeamTile({super.key, required this.team, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Checkbox(
              value: team.isSelected.value,
              onChanged: (_) => onChanged(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            title: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: team.image != null && team.image!.isNotEmpty
                      ? NetworkImage(team.image!)
                      : null,
                  child: team.image == null || team.image!.isEmpty
                      ? const Icon(Icons.group)
                      : null,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    team.title,
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
              team.id ?? 'N/A',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }
}