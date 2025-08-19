import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const ProgressIndicatorWidget({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps * 2 - 1, (index) {
        if (index.isEven) {
          // Dot
          final stepNumber = (index ~/ 2) + 1;
          return _buildProgressDot(stepNumber <= currentStep);
        } else {
          // Line
          final stepNumber = (index ~/ 2) + 1;
          return _buildProgressLine(stepNumber < currentStep);
        }
      }),
    );
  }

  Widget _buildProgressDot(bool isActive) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF6366F1) : const Color(0xFFE5E7EB),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildProgressLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? const Color(0xFF6366F1) : const Color(0xFFE5E7EB),
      ),
    );
  }
}
