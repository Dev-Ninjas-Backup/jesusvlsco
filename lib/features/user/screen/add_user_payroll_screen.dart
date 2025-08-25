import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/user/widget/appbar_widget.dart';
import '../controller/add_user_controller.dart';
import '../widget/payroll_form_fields_widget.dart';
import '../widget/progress_indigator_widget.dart';
import '../widget/section_header_widget.dart';

class AddUserPayrollScreen extends StatelessWidget {
  const AddUserPayrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      AddUserController(),
    ); // Only put if not already initialized

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            buildAppBar(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeaderWidget(
                      title: 'Payroll, Time-off & Break Time',
                      subtitle:
                          'Fill in the details below to add a new employee to the system.',
                    ),

                    const SizedBox(height: 16),

                    Obx(
                      () => ProgressIndicatorWidget(
                        currentStep: controller.currentStep.value,
                        totalSteps: 4,
                      ),
                    ),

                    const SizedBox(height: 32),

                    const PayrollFormFieldsWidget(),

                    const SizedBox(height: 40),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: controller.savePayroll,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6366F1),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: controller.cancelEducation,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: const BorderSide(color: Color(0xFF6366F1)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Color(0xFF6366F1),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
