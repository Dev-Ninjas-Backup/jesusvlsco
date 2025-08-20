import 'package:flutter/material.dart';

class ProgressIndicatorWithLabels extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const ProgressIndicatorWithLabels({
    super.key,
    required this.currentStep,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 🔹 Top Row: Dots + Lines
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(steps.length, (index) {
              final isActive = index + 1 <= currentStep;

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dot
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF4E53B1)
                          : Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                  ),

                  // Line (only if not last step)
                  if (index != steps.length - 1)
                    Container(
                      width: 60, // 🔹 Fixed line width
                      height: 2,
                      color: (index + 1 < currentStep)
                          ? const Color(0xFF4E53B1)
                          : Colors.grey.shade300,
                    ),
                ],
              );
            }),
          ),

          const SizedBox(height: 6),

          /// 🔹 Bottom Row: Labels
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(steps.length, (index) {
              final isActive = index + 1 == currentStep;

              return Container(
                width: 74, // 🔹 fixed width per label
                alignment: Alignment.center,
                child: Text(
                  steps[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color: isActive
                        ? const Color(0xFF4E53B1)
                        : Colors.grey,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
