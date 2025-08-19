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
    return Row(
      children: List.generate(steps.length, (index) {
        final isActive = index + 1 <= currentStep;

        return Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔹 Dot + Line
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    Expanded(
                      child: Container(
                        height: 2,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        color: (index + 1 < currentStep)
                            ? const Color(0xFF4E53B1)
                            : Colors.grey.shade300,
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 6),

              // 🔹 Label under Dot (centered)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  steps[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: currentStep == index + 1
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: currentStep == index + 1
                        ? const Color(0xFF4E53B1)
                        : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
