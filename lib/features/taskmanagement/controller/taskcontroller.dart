// task_controller.dart
// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  // Text Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  
  // Date and Time
  DateTime _startDate = DateTime(2025, 6, 23);
  TimeOfDay _startTime = TimeOfDay(hour: 8, minute: 0);
  DateTime _dueDate = DateTime(2025, 6, 23);
  TimeOfDay _dueTime = TimeOfDay(hour: 8, minute: 0);
  
  // Labels
  final List<String> _selectedLabels = ['General Tasks'];
  final List<String> _availableLabels = [
    'General Tasks', 
    'Work', 
    'Personal', 
    'Urgent', 
    'Important'
  ];

  // Getters
  DateTime get startDate => _startDate;
  TimeOfDay get startTime => _startTime;
  DateTime get dueDate => _dueDate;
  TimeOfDay get dueTime => _dueTime;
  List<String> get selectedLabels => _selectedLabels;
  List<String> get availableLabels => _availableLabels;

  // Date and Time formatting
  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  String formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'am' : 'pm';
    return "${hour == 0 ? 12 : hour}:${time.minute.toString().padLeft(2, '0')} $period";
  }

  // Date and Time selection methods
  Future<void> selectStartDate(BuildContext context) async {
    try {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _startDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        helpText: 'Select Start Date',
        cancelText: 'Cancel',
        confirmText: 'OK',
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF4E53B1),
              colorScheme: ColorScheme.light(
                primary: Color(0xFF4E53B1),
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ), dialogTheme: DialogThemeData(backgroundColor: Colors.white),
            ),
            child: child!,
          );
        },
      );
      if (picked != null && picked != _startDate) {
        _startDate = picked;
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error selecting start date: $e');
      }
      _showSnackBar(context, 'Error selecting date');
    }
  }

  Future<void> selectStartTime(BuildContext context) async {
    try {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: _startTime,
        helpText: 'Select Start Time',
        cancelText: 'Cancel',
        confirmText: 'OK',
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF4E53B1),
              colorScheme: ColorScheme.light(
                primary: Color(0xFF4E53B1),
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: child!,
          );
        },
      );
      if (picked != null && picked != _startTime) {
        _startTime = picked;
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error selecting start time: $e');
      }
      _showSnackBar(context, 'Error selecting time');
    }
  }

  Future<void> selectDueDate(BuildContext context) async {
    try {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dueDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        helpText: 'Select Due Date',
        cancelText: 'Cancel',
        confirmText: 'OK',
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF4E53B1),
              colorScheme: ColorScheme.light(
                primary: Color(0xFF4E53B1),
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ), dialogTheme: DialogThemeData(backgroundColor: Colors.white),
            ),
            child: child!,
          );
        },
      );
      if (picked != null && picked != _dueDate) {
        _dueDate = picked;
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error selecting due date: $e');
      }
      _showSnackBar(context, 'Error selecting date');
    }
  }

  Future<void> selectDueTime(BuildContext context) async {
    try {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: _dueTime,
        helpText: 'Select Due Time',
        cancelText: 'Cancel',
        confirmText: 'OK',
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF4E53B1),
              colorScheme: ColorScheme.light(
                primary: Color(0xFF4E53B1),
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: child!,
          );
        },
      );
      if (picked != null && picked != _dueTime) {
        _dueTime = picked;
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error selecting due time: $e');
      }
      _showSnackBar(context, 'Error selecting time');
    }
  }

  // Reset date/time methods
  void resetStartDateTime() {
    _startDate = DateTime.now();
    _startTime = TimeOfDay.now();
    update();
  }

  void resetDueDateTime() {
    _dueDate = DateTime.now();
    _dueTime = TimeOfDay.now();
    update();
  }

  // Label management
  void addLabel(String label) {
    if (!_selectedLabels.contains(label)) {
      _selectedLabels.add(label);
      update();
    }
  }

  void removeLabel(String label) {
    _selectedLabels.remove(label);
    update();
  }

  void toggleLabel(String label) {
    if (_selectedLabels.contains(label)) {
      removeLabel(label);
    } else {
      addLabel(label);
    }
  }

  // Show label picker
  void showLabelPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Labels',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4E53B1),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _availableLabels.length,
                  itemBuilder: (context, index) {
                    final label = _availableLabels[index];
                    final isSelected = _selectedLabels.contains(label);
                    return ListTile(
                      title: Text(
                        label,
                        style: TextStyle(
                          color: Color(0xFF5B5B5B),
                          fontSize: 16,
                        ),
                      ),
                      trailing: Checkbox(
                        value: isSelected,
                        onChanged: (bool? value) {
                          toggleLabel(label);
                          Navigator.pop(context);
                        },
                        activeColor: Color(0xFF4E53B1),
                      ),
                      onTap: () {
                        toggleLabel(label);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Task creation methods
  Map<String, dynamic> createTaskData(String status) {
    return {
      'title': titleController.text.trim(),
      'description': descriptionController.text.trim(),
      'location': locationController.text.trim(),
      'startDate': _startDate.toIso8601String(),
      'startTime': '${_startTime.hour}:${_startTime.minute}',
      'dueDate': _dueDate.toIso8601String(),
      'dueTime': '${_dueTime.hour}:${_dueTime.minute}',
      'labels': List.from(_selectedLabels),
      'status': status,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  bool validateTask() {
    return titleController.text.trim().isNotEmpty;
  }

  void publishTask(BuildContext context) {
    if (!validateTask()) {
      _showSnackBar(context, 'Please enter a task title', isError: true);
      return;
    }

    final task = createTaskData('published');
    print('Publishing task: $task');

    _showSnackBar(context, 'Task published successfully!');
    Navigator.pop(context, task);
  }

  void saveDraft(BuildContext context) {
    final task = createTaskData('draft');
    print('Saving draft: $task');

    _showSnackBar(context, 'Task saved as draft!', backgroundColor: Color(0xFF5B5B5B));
    Navigator.pop(context, task);
  }

  void handleAttachment(BuildContext context) {
    _showSnackBar(context, 'Attachment feature not implemented');
  }

  // Helper methods
  void _showSnackBar(BuildContext context, String message, {bool isError = false, Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor ?? (isError ? Colors.red : Color(0xFF4E53B1)),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Dispose method
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    super.dispose();
  }
}