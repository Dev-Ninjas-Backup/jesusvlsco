import 'package:flutter/material.dart';
import '../model/response_model.dart';

class ResponseRow extends StatelessWidget {
  final ResponseModel response;

  const ResponseRow({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Checkbox(value: false, onChanged: (_) {}), // can connect later
          const SizedBox(width: 8),

          // Profile Image
          CircleAvatar(
            backgroundImage: NetworkImage(response.imageUrl),
            radius: 18,
          ),
          const SizedBox(width: 12),

          // Name
          Expanded(
            child: Text(
              response.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),

          // Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: response.viewed ? Colors.green.shade50 : Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              response.viewed ? "Viewed" : "Didn't viewed",
              style: TextStyle(
                color: response.viewed ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
