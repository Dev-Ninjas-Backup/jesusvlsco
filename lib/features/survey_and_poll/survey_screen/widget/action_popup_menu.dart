import 'package:flutter/material.dart';

class ActionDialog extends StatelessWidget {
  final void Function()? onView;
  final void Function()? onEdit;
  final void Function()? onDelete;

  const ActionDialog({
    super.key,
    this.onView,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildItem(
              icon: Icons.remove_red_eye,
              label: 'View',
              onTap: () {
                Navigator.pop(context);
                if (onView != null) onView!();
              },
            ),
            const Divider(),
            _buildItem(
              icon: Icons.edit,
              label: 'Edit',
              onTap: () {
                Navigator.pop(context);
                if (onEdit != null) onEdit!();
              },
            ),
            const Divider(),
            _buildItem(
              icon: Icons.delete,
              label: 'Delete',
              iconColor: Colors.red,
              textColor: Colors.red,
              onTap: () {
                Navigator.pop(context);
                if (onDelete != null) onDelete!();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color iconColor = Colors.black,
    Color textColor = Colors.black,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(fontSize: 16, color: textColor)),
        ],
      ),
    );
  }
}
