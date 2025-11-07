import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/user_profile_controller.dart';

class UserFormWidget extends StatelessWidget {
  const UserFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserProfileController>();

    return Obx(
      () => Column(
        children: [
          _buildFormField(
            'First name',
            controller.firstNameController,
            isEditable: controller.isEditing.value,
          ),
          const SizedBox(height: 20),
          _buildFormField(
            'Last name',
            controller.lastNameController,
            isEditable: controller.isEditing.value,
          ),
          const SizedBox(height: 20),
          _buildFormField(
            'Phone number',
            controller.phoneController,
            isEditable: controller.isEditing.value,
          ),
          const SizedBox(height: 20),
          _buildFormField(
            'Email ID',
            controller.emailController,
            isEditable: false,
          ),
          const SizedBox(height: 20),
          _buildDateField(
            'Date of birth',
            _formatDate(controller.selectedDateOfBirth.value),
          ),
          const SizedBox(height: 20),
          _buildDropdownField(
            'Gender',
            controller.selectedGender.value ?? 'Not specified',
            () {
              if (!controller.isEditing.value) {
                return; // only editable in edit mode
              }
              List<Map<String, String>> genders = [
                {'label': 'Male', 'value': 'MALE'},
                {'label': 'Female', 'value': 'FEMALE'},
                {'label': 'Other', 'value': 'OTHER'},
                {'label': 'Prefer not to say', 'value': 'PREFER_NOT_TO_SAY'},
              ];

              Get.bottomSheet(
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: genders.map((gender) {
                      return ListTile(
                        title: Text(gender['label']!),
                        onTap: () {
                          controller.selectedGender.value =
                              gender['value']; // send backend-friendly value
                          Get.back();
                        },
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),
          _buildFormField(
            'Employee ID',
            controller.employeeIdController,
            isEditable: false,
          ),

          const SizedBox(height: 20),
          _buildDropdownField(
            'Job Title',
            controller.selectedJobTitle.value ?? 'Not specified',
            () {},
            // () => _showJobTitleBottomSheet(controller),
          ),
          const SizedBox(height: 20),
          _buildFormField(
            'Address',
            controller.addressController,
            isEditable: controller.isEditing.value,
          ),
          const SizedBox(height: 20),
          _buildDropdownField(
            'City',
            controller.selectedCity.value ?? 'Not specified',
            () {},
            // () => _showCityBottomSheet(controller),
          ),
          const SizedBox(height: 20),
          _buildDropdownField(
            'State',
            controller.selectedState.value ?? 'Not specified',
            () {},
            // () => _showStateBottomSheet(controller),
          ),
          const SizedBox(height: 20),
          _buildDropdownField(
            'Country',
            controller.selectedCountry.value ?? 'Not specified',
            () {},
          ),
          const SizedBox(height: 20),
          _buildFormField(
            'Nationality',
            controller.nationalityController,
            isEditable: controller.isEditing.value,
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(
    String label,
    TextEditingController controller, {
    bool isEditable = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: !isEditable,
          decoration: InputDecoration(
            filled: true,
            fillColor: isEditable ? Colors.white : Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            hintText: controller.text.isEmpty ? 'Not specified' : null,
            hintStyle: TextStyle(color: Colors.grey.shade500),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: value == 'Not specified'
                        ? Colors.grey.shade500
                        : Colors.black87,
                  ),
                ),
              ),
              const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String value, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      color: value == 'Not specified'
                          ? Colors.grey.shade500
                          : Colors.black87,
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Not specified';
    return '${date.day}, ${_getMonthName(date.month)} ${date.year}';
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

}
