import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/features/settings/widget/api_custom_button.dart';
import 'package:jesusvlsco/features/settings/widget/custom_switch.dart';
import 'package:jesusvlsco/features/settings/widget/textfield_with_dropdown.dart';

class ApiAndIntegration extends StatelessWidget {
  final List<String> items = ['*********'];
  final ValueNotifier<String?> valueNotifier = ValueNotifier<String?>(null);
  final TextEditingController controller = TextEditingController();
  ApiAndIntegration({super.key});

  void onChanged(String? value) {
    valueNotifier.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom_appbar(title: 'API & Integrations'),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Automatic Synchronization',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  CustomSwitch(),
                ],
              ),
              Text('Automatically sync data between integrated services.'),

              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available Integrations',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFF4A55A2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            'Add New',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ApiCustomButtonContainer(
                text: 'Connect',
                title: 'Gusto',
                icon: Icons.add,
                bgcolor: Colors.green,
              ),
              SizedBox(height: 20),
              ApiCustomButtonContainer(
                width: 150,
                text: 'Connect',
                title: 'Quickbooks online',
                icon: Icons.check,
                bgcolor: Colors.green,
              ),
              SizedBox(height: 20),
              ApiCustomButtonContainer(
                text: 'Connect',
                title: 'Xero(UK)',
                subTitle: 'Email marketing and newseletter integration.',
                icon: Icons.add,
                bgcolor: Colors.green,
              ),
              SizedBox(height: 20),
              ApiCustomButtonContainer(
                text: 'Connect',
                title: 'Github',
                subTitle: 'Connect to your repositories and track issues',
                icon: Icons.add,
                bgcolor: Colors.green,
              ),
              SizedBox(height: 20),
              Text(
                'API Access',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('API Key', style: TextStyle(fontSize: 18)),
              SizedBox(height: 5),
              TextFieldWithDropDown(
                hintText: '•••••••••',
                items: items,
                valueNotifier: valueNotifier,
                onChanged: onChanged,
                controller: controller,
              ),
              SizedBox(height: 5),
              Text(
                'Your API key is used to authenticate API requests.',
                style: TextStyle(color: Colors.grey.withValues(alpha: 0.8)),
              ),
              SizedBox(height: 20),

              Text('Web URL', style: TextStyle(fontSize: 18)),
              SizedBox(height: 5),
              TextFieldWithDropDown(
                hintText: 'https://example.com/webhook',
                items: items,
                valueNotifier: valueNotifier,
                onChanged: onChanged,
                controller: controller,
              ),
              SizedBox(height: 5),
              Text(
                'YThe URL where we will send webhook notifications.',
                style: TextStyle(color: Colors.grey.withValues(alpha: 0.8)),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
