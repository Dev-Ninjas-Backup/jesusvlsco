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
          () => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                // Checkbox
                Checkbox(
                  value: team.isSelected.value,
                  onChanged: (_) => onChanged(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                // First 50%: Avatar + Title
                Expanded(
                  flex: 1,
                  child: Row(
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
                ),

                // Second 50%: ID text
                Expanded(
                  flex: 1,
                  child: Text(
                    team.id ?? 'N/A',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }
}
