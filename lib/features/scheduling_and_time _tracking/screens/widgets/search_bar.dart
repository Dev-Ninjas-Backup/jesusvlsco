import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        hintText: 'Search...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), ),
        contentPadding: EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}
