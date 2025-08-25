import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import '../models/shift_template_model.dart';

/// Controller for Shift Template Screen
/// Manages shift template operations and business logic
class ShiftTemplateController extends GetxController {
  final _logger = Logger();
  final searchController = TextEditingController();

  var searchQuery = ''.obs;
  var isLoading = false.obs;

  /// Observable list of shift templates
  var templates = <ShiftTemplateModel>[
    const ShiftTemplateModel(
      id: '1',
      title: 'Morning Shift',
      startTime: '9:00 am',
      endTime: '5:00 pm',
    ),
    const ShiftTemplateModel(
      id: '2',
      title: 'Night Shift',
      startTime: '10:00 am',
      endTime: '6:00 pm',
    ),
    const ShiftTemplateModel(
      id: '3',
      title: 'Evening Shift',
      startTime: '2:00 pm',
      endTime: '10:00 pm',
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    _logger.i('ShiftTemplateController initialized');
    loadTemplates();
  }

  /// Filter templates based on search query
  List<ShiftTemplateModel> get filteredTemplates {
    if (searchQuery.value.isEmpty) {
      return templates;
    }
    return templates
        .where(
          (template) => template.title.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ),
        )
        .toList();
  }

  /// Load templates from API or local storage
  Future<void> loadTemplates() async {
    try {
      isLoading.value = true;
      _logger.i('Loading shift templates');

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Templates are already initialized above
      // In real implementation, this would fetch from API

      _logger.i('Templates loaded: ${templates.length}');
    } catch (error) {
      _logger.e('Error loading templates: $error');
      EasyLoading.showError('Failed to load templates');
    } finally {
      isLoading.value = false;
    }
  }

  /// Add new template
  void addTemplate() {
    try {
      _logger.i('Opening add template dialog');

      // Show add template dialog or navigate to add template screen
      Get.dialog(_buildAddTemplateDialog(), barrierDismissible: true);
    } catch (error) {
      _logger.e('Error opening add template: $error');
      EasyLoading.showError('Failed to open add template');
    }
  }

  /// Save new template
  Future<void> saveTemplate({
    required String title,
    required String startTime,
    required String endTime,
  }) async {
    try {
      _logger.i('Saving new template: $title');
      isLoading.value = true;

      // Create new template
      final newTemplate = ShiftTemplateModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        startTime: startTime,
        endTime: endTime,
      );

      // Add to list
      templates.add(newTemplate);

      EasyLoading.showSuccess('Template saved successfully');
      Get.back(); // Close dialog

      _logger.i('Template saved: ${newTemplate.id}');
    } catch (error) {
      _logger.e('Error saving template: $error');
      EasyLoading.showError('Failed to save template');
    } finally {
      isLoading.value = false;
    }
  }

  /// Delete template
  Future<void> deleteTemplate(String templateId) async {
    try {
      _logger.i('Deleting template: $templateId');

      templates.removeWhere((template) => template.id == templateId);

      EasyLoading.showSuccess('Template deleted successfully');
      _logger.i('Template deleted: $templateId');
    } catch (error) {
      _logger.e('Error deleting template: $error');
      EasyLoading.showError('Failed to delete template');
    }
  }

  /// Select template and return to previous screen
  void selectTemplate(ShiftTemplateModel template) {
    try {
      _logger.i('Template selected: ${template.title}');

      // Return selected template to previous screen
      Get.back(result: template);

      EasyLoading.showSuccess('Template selected');
    } catch (error) {
      _logger.e('Error selecting template: $error');
      EasyLoading.showError('Failed to select template');
    }
  }

  /// Navigate back
  void goBack() {
    _logger.i('Navigating back from shift template screen');
    Get.back();
  }

  /// Build add template dialog
  Widget _buildAddTemplateDialog() {
    final titleController = TextEditingController();
    final startTimeController = TextEditingController();
    final endTimeController = TextEditingController();

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add New Template',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // Title field
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Template Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Start time field
            TextField(
              controller: startTimeController,
              decoration: const InputDecoration(
                labelText: 'Start Time',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // End time field
            TextField(
              controller: endTimeController,
              decoration: const InputDecoration(
                labelText: 'End Time',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        startTimeController.text.isNotEmpty &&
                        endTimeController.text.isNotEmpty) {
                      saveTemplate(
                        title: titleController.text,
                        startTime: startTimeController.text,
                        endTime: endTimeController.text,
                      );
                    } else {
                      EasyLoading.showError('Please fill all fields');
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onClose() {
    _logger.i('ShiftTemplateController disposing');
    searchController.dispose();
    super.onClose();
  }
}
