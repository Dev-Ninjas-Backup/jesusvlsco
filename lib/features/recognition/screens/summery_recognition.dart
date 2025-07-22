import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class RecognitionCard extends StatelessWidget {
  const RecognitionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3E2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
                
                children: [
                  const Text(
                    'XYZ recognized',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF374151),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: Sizer.wp(16)),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFBBF24),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lightbulb,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  _UserRow(name: 'Cody Fisher', color: Color(0xFF3B82F6)),
                  _UserRow(name: 'Leslie Alexander', color: Color(0xFFF59E0B)),
                  _UserRow(name: 'Robert Fox', color: Color(0xFF8B5CF6)),
                ],
              ),
            ],
          ),
        ),
        Text(
          "All user can see this recognition",
          style: AppTextStyle.regular().copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.text,
          ),
        ),
      ],
    );
  }
}

class _UserRow extends StatelessWidget {
  final String name;
  final Color color;

  const _UserRow({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Center(
              child: Text(
                name[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }
}

// Minimal usage example
