import 'package:flutter/material.dart';

class SurveyTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SurveyTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 0.9),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Flexible text: will shrink / ellipsize if needed
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(width: 12),

          // Constrain the button width so it never grows beyond available space
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 88,
              maxWidth: 120,
              minHeight: 36,
              maxHeight: 40,
            ),
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E53B1),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),

              ),
              child: const Text(
                "Take survey",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
