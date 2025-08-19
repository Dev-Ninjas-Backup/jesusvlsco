import 'package:flutter/material.dart';

import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import 'poll_option_field.dart';

class QuestionCard extends StatelessWidget {
  final int index;
  final TextEditingController questionController;
  final List<TextEditingController> optionControllers;
  final VoidCallback onRemoveQuestion;
  final VoidCallback onAddOption;
  final Function(int) onRemoveOption;

  const QuestionCard({
    super.key,
    required this.index,
    required this.questionController,
    required this.optionControllers,
    required this.onRemoveQuestion,
    required this.onAddOption,
    required this.onRemoveOption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title row
          Row(
            children: [
              Text(
                "${index + 1}. Question",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF4E53B1),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.grey),
                onPressed: onRemoveQuestion,
              ),
            ],
          ),

          /// Question Input
          CustomTextField(
            hintText: "Enter your question",
            controller: questionController,
          ),
          const SizedBox(height: 10),

          /// Options List
          Column(
            children: List.generate(optionControllers.length, (i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: PollOptionField(
                  controller: optionControllers[i],
                  onRemove: () => onRemoveOption(i),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),

          /// Add option button (purple filled)
          CustomButton(
            text: "+ Add option",
            onPressed: onAddOption,
            decorationColor: Color(0xFF4E53B1), // purple bg
            textColor: Colors.white,
            borderRadius: 8,
            isExpanded: true, // full width
          )
        ],
      ),
    );
  }
}
