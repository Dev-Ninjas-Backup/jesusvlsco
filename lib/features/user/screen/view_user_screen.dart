import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/bottom_navigation/controller/admin_bottom_navigation_scaffold_controller.dart';
import 'package:jesusvlsco/features/bottom_navigation/screen/admin_bottom_navigation_scaffold.dart';

import '../controller/add_user_controller.dart';
import '../widget/profile_view_toggle_widget.dart';
import '../widget/view_info_card_widget.dart';
import '../widget/view_profile_header_widget.dart';
import '../widget/view_user_from_widget.dart';

class ViewUserScreen extends StatelessWidget {
  const ViewUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminBottomNavigationController bottomNavigationController =
        Get.find<AdminBottomNavigationController>();
    final controller = Get.put(AddUserController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            const ViewProfileHeaderWidget(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => ProfileViewToggleWidget(
                        selectedRole:
                            controller.selectedRole.value ?? 'Employee',
                        onRoleChanged: (role) {
                          controller.setRole(role);
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    const ViewInfoCardWidget(),

                    const SizedBox(height: 32),

                    const Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6366F1),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const ViewUserFromWidget(),

                    const SizedBox(height: 32),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Get.back(),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              side: const BorderSide(color: Color(0xFFE5E7EB)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Previous',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              // Navigate to next screen
                              Get.offAll(AdminBottomNavigationScaffold());
                              bottomNavigationController.changeIndex(2);
                              
                              Get.snackbar(
                                'Success',
                                'Profile updated successfully!',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: const Color(0xFF6366F1),
                                colorText: Colors.white,
                                duration: const Duration(seconds: 2),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6366F1),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
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
