import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/features/taskmanagement/widgets/common_button.dart';

class AdminDetails extends StatelessWidget {
  const AdminDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom_appbar(title: "Admin Details"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/userprofile.png'),
                ),
              ),
              const SizedBox(height: 24),
              _cutomtextfield(context),
              const SizedBox(height: 16),
              const Text('Phone Number'),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: '(907) 555-0101',
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              const Text('Email Address'),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: 'michelle.rivera@example.com',
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 24),
              const Text(
                'Password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text('Change your password to keep your account secure.'),
              const SizedBox(height: 8),
              customButton(
                text: 'Change password',
                onPressed: () {},
                bgcolor: AppColors.primary,
                brcolor: AppColors.primary,
                textcolor: AppColors.textWhite,
                width: double.infinity,
              ),
              const SizedBox(height: 24),
              const Text(
                'Link accounts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text('Connect your account with social logins.'),
              const SizedBox(height: 16),
              _buildSocialLink(
                'Facebook',
                'Not connected',
                () {},
                context,
                true,
              ),
              const SizedBox(height: 10),
              _buildSocialLink(
                'Twitter',
                'Not connected',
                () {},
                context,
                true,
              ),
              const SizedBox(height: 10),
              _buildSocialLink(
                'Google',
                'Not connected',
                () {},
                context,
                false,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: customButton(
                      text: 'Edit',
                      onPressed: () {},
                      bgcolor: AppColors.primary,
                      brcolor: AppColors.primary,
                      textcolor: AppColors.textWhite,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: customButton(
                      text: 'Save',
                      onPressed: () {},
                      bgcolor: AppColors.primary,
                      brcolor: AppColors.primary,
                      textcolor: AppColors.textWhite,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLink(
    String title,
    String subtitle,
    VoidCallback onPressed,
    BuildContext context,
    bool isConnected,
    
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(color: Colors.grey)),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isConnected ? AppColors.primary : Colors.grey,
            ),
            color: isConnected
                ? AppColors.primary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextButton(onPressed: onPressed, child: Text('Connect',style: TextStyle(
            color:isConnected?AppColors.textWhite: AppColors.primary,
          ),)),
        ),
      ],
    );
  }
}


  @override
  Widget _cutomtextfield(BuildContext context) {
    return Column(
      children: [
        const Text('Full name'),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: 'Brooklyn Simmons',
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
      ],
    );
  }

