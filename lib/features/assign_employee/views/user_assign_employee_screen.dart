import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/common/widgets/custom_button.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/assign_employee/controller/user_schedule_controller.dart';
import 'package:jesusvlsco/features/assign_employee/views/user_add_unavailability_screen.dart';

class AssignEmployeeScreen extends StatelessWidget {
  final ScheduleController controller = Get.put(ScheduleController());

  AssignEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          "Assign Employee",
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(18),
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildHeaderView(),
            const SizedBox(height: 16),
            _buildFilterView(context),
            const SizedBox(height: 24),
            _buildEmployeeAvailabilityHeader(),
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildEmployeeList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Shift Scheduling Project 1",
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(18),
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        CustomButton(
          onPressed: () {},
          text: 'Publish',
          textColor: Colors.white,
          decorationColor: AppColors.primary,
          leadingIcon: Icon(
            Icons.notifications_none_outlined,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Sizer.wp(12)),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: const Color(0xFF4E53B1),
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Obx(
              () => DropdownButton<String>(
                value: controller.dropdownValue.value,
                items: controller.dropdownItems
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: AppTextStyle.regular().copyWith(
                            fontSize: Sizer.wp(12),
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (val) => controller.dropdownValue.value = val!,
                underline: const SizedBox(),
                isExpanded: true,
              ),
            ),
          ),
        ),
        SizedBox(width: Sizer.wp(6)),
        Expanded(
          // flex: 3,
          child: InkWell(
            onTap: () async {
              // Date Range Picker logic would go here
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: controller.selectedDate.value,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (picked != null) {
                controller.selectedDate.value = picked;
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: const Color(0xFF4E53B1),
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                "Aug 3",
                style: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(12),
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: Sizer.wp(6)),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Get.to(AddUnavailabilityScreen());
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              side: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: const Color(0xFF4E53B1),
              ),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text(
              'My Availability',
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(12),
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmployeeAvailabilityHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Employee Availability",
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(16),
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            "5 active",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search Employee",

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  Widget _buildEmployeeList() {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.employees.length,
        itemBuilder: (context, index) {
          final emp = controller.employees[index];
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        emp["image"]!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              emp["name"]!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          emp["role"]!,
                          style: const TextStyle(
                            color: Color(0xFF4F46E5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text("Off Day: ${emp["offDay"]}"),
                      ],
                    ),
                  ],
                ),
              ),
              // Add plus buttons only after the first employee
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (i) => Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 234, 233, 233),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.add, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          );
        },
      ),
    );
  }
}
