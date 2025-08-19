
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/features/settings/screens/admin_details.dart';
import 'package:jesusvlsco/features/settings/screens/company_profile.dart';

class Settings_screen extends StatelessWidget {
  const Settings_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom_appbar(title: "Settings"),
      body: Padding(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 16.0, bottom: 24),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.dividerColor,
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildrows(
                  context,
                  title: "Company Profile",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CompanyProfile(),
                      ),
                    );
                  },
                ),
                _buildrows(context, title: "Admin Details",onTap: (){
                  Get.to(AdminDetails());
                }),
                _buildrows(context, title: "Project Management",),
                _buildrows(context, title: "API & intregations",),
                _buildrows(context, title: "Notifications",),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildrows(
    BuildContext context, {
    required String title,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: onTap,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
  ),
        ),
        Divider(color: AppColors.dividerColor),
      ],
    );
  }
}
