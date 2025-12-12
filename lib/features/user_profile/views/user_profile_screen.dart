import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/widgets/custom_button.dart';
import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/user_profile/controller/user_profile_controller.dart';
import 'package:jesusvlsco/features/user_profile/widgets/user_form_widget.dart';
import 'package:jesusvlsco/features/user/widget/view_profile_header_widget.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserProfileController());

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
                    _buildHeaderView(controller),
                    SizedBox(height: Sizer.hp(32)),
                    const Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6366F1),
                      ),
                    ),
                    SizedBox(height: Sizer.hp(24)),
                    const UserFormWidget(),
                    SizedBox(height: Sizer.hp(32)),
                    Container(
                      height: Sizer.hp(50),
                      margin: const EdgeInsets.all(15),
                      child: CustomButton(
                        // isLoading: controller.isLoading.value,
                        textColor: Colors.white,
                        isExpanded: true,
                        onPressed: controller.updateProfile,
                        text: 'Save Settings',
                        decorationColor: AppColors.primary,
                      ),
                    ),
                    Container(
                      height: Sizer.hp(50),
                      margin: const EdgeInsets.all(15),
                      child: CustomButton(
                        textColor: Colors.white,
                        isExpanded: true,
                        onPressed: () {
                          StorageService.logout();
                        },

                        text: 'Logout',
                        decorationColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Replace the _buildHeaderView method in your UserProfileScreen with this:
  Widget _buildHeaderView(UserProfileController controller) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE5E7EB), width: 2),
              ),
              child: ClipOval(
                child:
                    controller.profileImageUrl.value != null &&
                        controller.profileImageUrl.value!.isNotEmpty
                    ? Image.network(
                        controller.profileImageUrl.value!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade300,
                            child: const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.grey,
                            ),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: double.infinity),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        controller.displayName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Flexible(
                      child: Text(
                        controller.displayJobTitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: controller.displayJobTitle == 'No Job Title'
                              ? Colors.grey.shade500
                              : Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: ElevatedButton(
                onPressed: () {
                  if (controller.isEditing.value) {
                    controller.updateProfile();
                  } else {
                    controller.isEditing.value = true;
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  minimumSize: const Size(60, 40),
                ),
                child: Obx(
                  () => controller.isLoading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(controller.isEditing.value ? 'Save' : 'Edit'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
