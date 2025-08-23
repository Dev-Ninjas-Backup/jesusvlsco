import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_add_shift/widget/custom_outlined_button.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_add_time_off_screen/widget/show_time_of_type_pop_up.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_chat_screen/screen/time_clock_admin_chat_screen.dart';
import 'package:jesusvlsco/features/settings/screens/admin_time_clock2/screen/pending_widget.dart';
import 'package:jesusvlsco/features/settings/screens/admin_time_clock2/widget/date_picker.dart';
import 'package:jesusvlsco/features/time&clock/widget/search_bar.dart';

class PendingRequest extends StatelessWidget {
  const PendingRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom_appbar(title: 'Pending Request'),
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomSearchBar(),
              SizedBox(height: 20),
              Row(children: [Text('From:'), SizedBox(width: 100), Text('To:')]),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DatePicker(),
                  SizedBox(width: 20),
                  DatePicker(),
                  SizedBox(width: 20),
                  StatusDropdown(label: 'Pending (1)', onTap: () {}),
                ],
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://www.adobe.com/uk/learn/photoshop/web/vector-objects',
                        ),
                        radius: 50,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Jone Cooper',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.message_outlined, color: AppColors.primary),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Get.to(TimeClockAdminChatScreen());
                          },
                          child: Text(
                            'Chat with user',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
