import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/create_new_poll_screen/screen/create_new_poll_screen.dart';
import 'package:jesusvlsco/features/template/screen/template_screen.dart';

void showCustomAlertBox(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
          child: SizedBox(
            width: double.infinity,
            height: 100,
            child: Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Get.to(CreateNewPollScreen());
                    },
                    child: Container(
                      //height: 90,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Color(0xFF4E53B1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit),
                          Text("Create a new"),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Get.to(TemplateScreen());
                    },
                    child: Container(
                      //height: 90,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 208, 209, 220),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.menu_rounded),
                          Text("Use a template"),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
