import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/widgets/custom_button.dart';
 // make sure path is correct

class PublishCreateSurveyDatePickerRow extends StatelessWidget {
  final Rx<DateTime> selectedDate;
  final Rx<TimeOfDay> selectedTime;
  final Function(DateTime) onDatePicked;
  final Function(TimeOfDay) onTimePicked;

  const PublishCreateSurveyDatePickerRow({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onDatePicked,
    required this.onTimePicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Date Picker Button
        Expanded(
          child: CustomButton(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: selectedDate.value,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                onDatePicked(picked);
              }
            },
            text: "${selectedDate.value.toLocal()}".split(' ')[0],
            textColor: const Color(0xFF4E53B1),
            borderColor: const Color(0xFF4E53B1),
            decorationColor: Colors.white,
            fontWeight: FontWeight.w500,
            borderRadius: 8,
            isExpanded: true,
          ),
        ),

        const SizedBox(width: 12),

        /// Time Picker Button
        Expanded(
          child: CustomButton(
            onPressed: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: selectedTime.value,
              );
              if (picked != null) {
                onTimePicked(picked);
              }
            },
            text: selectedTime.value.format(context),
            textColor: const Color(0xFF4E53B1),
            borderColor: const Color(0xFF4E53B1),
            decorationColor: Colors.white,
            fontWeight: FontWeight.w500,
            borderRadius: 8,
            isExpanded: true,
          ),
        ),
      ],
    );
  }
}
