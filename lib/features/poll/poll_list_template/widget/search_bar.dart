import 'package:flutter/material.dart';

class SearchBarWithFilter extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onFilterTap;

  const SearchBarWithFilter({
    super.key,
    required this.onChanged,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search articles",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: onFilterTap,
          icon: const Icon(Icons.filter_list, color: Color(0xFF4E53B1)),
          label: const Text(
            "Filter",
            style: TextStyle(color: Color(0xFF4E53B1)),
          ),
        ),
      ],
    );
  }
}
