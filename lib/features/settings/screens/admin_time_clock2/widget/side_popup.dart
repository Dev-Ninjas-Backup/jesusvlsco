import 'package:flutter/material.dart';
import 'package:jesusvlsco/features/settings/screens/admin_time_clock2/widget/side_popup_options.dart';

class SidePopup extends StatelessWidget {
  const SidePopup({super.key});

  void _showPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return const SidePopupOptions();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey.shade400),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      onPressed: () => _showPopup(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'Select',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 5),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
