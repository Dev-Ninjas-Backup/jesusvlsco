import 'package:flutter/material.dart';

class ProposalCard extends StatelessWidget {
  final VoidCallback? onCreatePressed;
  final VoidCallback? onFilterPressed;
  final VoidCallback? onDatePressed;
  final VoidCallback? onMorePressed;
  final String? createText;
  final String? filterText;
  final String? dateText;

  const ProposalCard({
    super.key,
    this.onCreatePressed,
    this.onFilterPressed,
    this.onDatePressed,
    this.onMorePressed,
    this.createText,
    this.filterText,
    this.dateText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 3,
      children: [
        // Create Button
        Flexible(
          child: ElevatedButton(
            onPressed: onCreatePressed ?? () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6366F1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, size: 16, color: Colors.white),
                SizedBox(width: 6),
                Text(
                  createText ?? "Create",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
    
        //SizedBox(width: 8),
    
        // Filter Button
        Expanded(
          child: OutlinedButton(
            onPressed: onFilterPressed ?? () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade400),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.tune, size: 16, color: Colors.black87),
                SizedBox(width: 6),
                Text(
                  filterText ?? "Filter",
                  style: TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
    
        //SizedBox(width: 8),
    
        // Date Button
        Expanded(
          child: OutlinedButton(
            onPressed: onDatePressed ?? () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade400),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.black87),
                SizedBox(width: 6),
                Text(
                  dateText ?? "Date",
                  style: TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
    
        //SizedBox(width: 8),
    
        // More Options Button
        OutlinedButton(
          onPressed: onMorePressed ?? () {},
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey.shade400),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            minimumSize: Size(40, 36),
          ),
          child: Icon(Icons.more_vert, size: 16, color: Colors.black87),
        ),
      ],
    );
  }
}
