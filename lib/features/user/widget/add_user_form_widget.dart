import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/add_user_controller.dart';
import 'add_user_dropdown_widget.dart';

Widget buildFormFields(AddUserController controller) {
  return Column(
    children: [
      _buildTextField(
        'First name',
        'Enter first name',
        controller.firstNameController,
      ),
      const SizedBox(height: 20),
      _buildTextField(
        'Last name',
        'Enter last name here',
        controller.lastNameController,
      ),
      const SizedBox(height: 20),
      _buildTextField(
        'Phone number',
        'Enter phone number here',
        controller.phoneController,
      ),
      const SizedBox(height: 20),
      _buildTextField(
        'Email ID',
        'Enter Email ID here',
        controller.emailController,
      ),
      const SizedBox(height: 20),
      buildDropdownField('Gender', 'Select State', [
        'Male',
        'Female',
        'Other',
      ], controller),
      const SizedBox(height: 20),
      _buildTextField(
        'Employee ID',
        'Enter employee ID here',
        controller.employeeIdController,
      ),
      const SizedBox(height: 20),
      buildDropdownField('Job Title', 'Select job title here', [
        'Software Engineer',
        'Product Manager',
        'Designer',
        'QA Engineer',
      ], controller),
      const SizedBox(height: 20),
      buildDropdownField('Department', 'Select Department', [
        'IT',
        'DEVELOPMENT',
        'HR',
        'FINANCE',
        'MARKETING',
        'SEALS',
      ], controller),
      const SizedBox(height: 20),
      _buildTextField('Address', 'Enter Address', controller.addressController),
      const SizedBox(height: 20),
      buildDropdownField('City', 'Select city', [
        'New York',
        'Los Angeles',
        'Chicago',
        'Houston',
      ], controller),
      const SizedBox(height: 20),
      buildDropdownField('State', 'Select state', [
        'California',
        'New York',
        'Texas',
        'Florida',
      ], controller),
      const SizedBox(height: 20),
      _buildDateField('Date of birth', 'Select date', controller),
    ],
  );
}

Widget _buildTextField(
  String label,
  String hint,
  TextEditingController textController,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: textController,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF6366F1)),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    ],
  );
}

Widget buildAddressField(
  String label,
  String hint,
  AddUserController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 8),
      GestureDetector(
        onTap: () => controller.selectAddress(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(hint, style: const TextStyle(color: Colors.grey)),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildDateField(
  String label,
  String hint,
  AddUserController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 8),
      GestureDetector(
        onTap: () => controller.selectDate(),
        child: Obx(() {
          final dob = controller.selectedDateOfBirth.value;
          final display = dob != null
              ? dob.toIso8601String()//'${dob.day}/${dob.month}/${dob.year}'
              : hint;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  display,
                  style: TextStyle(
                    color: dob != null ? Colors.black : Colors.grey,
                  ),
                ),
                const Icon(Icons.calendar_today, color: Colors.grey, size: 20),
              ],
            ),
          );
        }),
      ),
    ],
  );
}
