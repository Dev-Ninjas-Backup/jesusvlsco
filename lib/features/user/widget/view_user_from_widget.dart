import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/add_user_controller.dart';

class ViewUserFromWidget extends StatelessWidget {
  const ViewUserFromWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddUserController>();

    return Obx(
      () => Column(
        children: [
          _buildFormField('First name', controller.firstNameController.text),
          const SizedBox(height: 20),
          _buildFormField('Last name', controller.lastNameController.text),
          const SizedBox(height: 20),
          _buildFormField('Phone number', controller.phoneController.text),
          const SizedBox(height: 20),
          _buildFormField('Email ID', controller.emailController.text),
          const SizedBox(height: 20),
          _buildDateField(
            'Date of birth',
            _formatDate(controller.selectedDateOfBirth.value),
          ),
          const SizedBox(height: 20),
          _buildDropdownField(
            'Gender',
            controller.selectedGender.value ?? 'Female',
            () => _showGenderBottomSheet(controller),
          ),
          const SizedBox(height: 20),
          _buildFormField('Employee ID', controller.employeeIdController.text),
          const SizedBox(height: 20),
          _buildFormField('Job Title', ''),
          const SizedBox(height: 20),
          _buildDropdownField(
            'Job Title',
            controller.selectedJobTitle.value ??
                '1901 Thornridge Cir, Shiloh, Hawaii, 811063',
            () => _showJobTitleBottomSheet(controller),
          ),
          const SizedBox(height: 20),
          _buildFormField('Address', controller.addressController.text),
          const SizedBox(height: 20),
          _buildDropdownField(
            'City',
            controller.selectedCity.value ?? 'America',
            () => _showCityBottomSheet(controller),
          ),
          const SizedBox(height: 20),
          _buildDropdownField(
            'State',
            controller.selectedState.value ?? 'Los angeles',
            () => _showStateBottomSheet(controller),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, String value) {
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
          child: Text(
            value.isEmpty ? 'Not specified' : value,
            style: TextStyle(
              fontSize: 16,
              color: value.isEmpty ? Colors.grey[500] : Colors.black87,
            ),
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
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
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
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
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
    if (date == null) return '25, July 1998';
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

  void _showGenderBottomSheet(AddUserController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Gender',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            ...controller.genderOptions
                .map(
                  (gender) => ListTile(
                    title: Text(gender),
                    trailing: controller.selectedGender.value == gender
                        ? const Icon(Icons.check, color: Color(0xFF6366F1))
                        : null,
                    onTap: () {
                      controller.selectedGender.value = gender;
                      Get.back();
                    },
                  ),
                )
                ,
          ],
        ),
      ),
    );
  }

  void _showJobTitleBottomSheet(AddUserController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Job Title',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            ...controller.jobTitleOptions
                .map(
                  (title) => ListTile(
                    title: Text(title),
                    trailing: controller.selectedJobTitle.value == title
                        ? const Icon(Icons.check, color: Color(0xFF6366F1))
                        : null,
                    onTap: () {
                      controller.selectedJobTitle.value = title;
                      Get.back();
                    },
                  ),
                )
                ,
          ],
        ),
      ),
    );
  }

  void _showCityBottomSheet(AddUserController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select City',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            ...controller.cityOptions
                .map(
                  (city) => ListTile(
                    title: Text(city),
                    trailing: controller.selectedCity.value == city
                        ? const Icon(Icons.check, color: Color(0xFF6366F1))
                        : null,
                    onTap: () {
                      controller.selectedCity.value = city;
                      Get.back();
                    },
                  ),
                )
                ,
          ],
        ),
      ),
    );
  }

  void _showStateBottomSheet(AddUserController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select State',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            ...controller.stateOptions
                .map(
                  (state) => ListTile(
                    title: Text(state),
                    trailing: controller.selectedState.value == state
                        ? const Icon(Icons.check, color: Color(0xFF6366F1))
                        : null,
                    onTap: () {
                      controller.selectedState.value = state;
                      Get.back();
                    },
                  ),
                )
                ,
          ],
        ),
      ),
    );
  }
}
