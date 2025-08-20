import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDateTimePickerRow extends StatelessWidget {
  final Rx<DateTime> selectedDate;
  final Rx<TimeOfDay> selectedTime;
  final Function(DateTime) onDatePicked;
  final Function(TimeOfDay) onTimePicked;

  const CustomDateTimePickerRow({
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
        Expanded(
          child: OutlinedButton(
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
            child: Obx(() => Text(
              "${selectedDate.value.toLocal()}".split(' ')[0],
              style: const TextStyle(color: Color(0xFF4E53B1)),
            )),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: selectedTime.value,
              );
              if (picked != null) {
                onTimePicked(picked);
              }
            },
            child: Obx(() => Text(
              selectedTime.value.format(context),
              style: const TextStyle(color: Color(0xFF4E53B1)),
            )),
          ),
        ),
      ],
    );
  }
}
