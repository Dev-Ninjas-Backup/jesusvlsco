import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_add_shift/widget/custom_outlined_button.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_add_shift/widget/show_project_pop_up.dart';
import '../controller/admin_time_clock_add_shift_controller.dart';

class AdminTimeClockAddShiftScreen extends StatelessWidget {
  const AdminTimeClockAddShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminTimeClockAddShiftController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Shift",
          style: TextStyle(fontSize: 18, color: AppColors.primary),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            // project row--
            Row(
              children: [
                Text(
                  "Project",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Obx(
                    () => OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => showProjectPopup(context, controller),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              controller.selectedProject.value,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0XFFEDEEF7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total hours",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        "08:00",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text("Starts"),
                SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: Obx(
                    () => CustomOutlinedButton(
                      onPressedAction: () =>
                          controller.pickDate(context, isStart: true),
                      buttonText: controller.formatDate(
                        controller.startDate.value,
                      ),
                      isIcon: true,
                      iconData: Icons.keyboard_arrow_down_outlined,
                    ),
                  ),
                ),
                SizedBox(width: 18),
                Text("At"),
                SizedBox(width: 5),
                Expanded(
                  flex: 1,
                  child: Obx(
                    () => CustomOutlinedButton(
                      onPressedAction: () =>
                          controller.pickTime(context, isStart: true),
                      isIcon: false,
                      buttonText: controller.formatTime(
                        controller.startTime.value,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Ends"),
                SizedBox(width: 18),
                Expanded(
                  flex: 2,
                  child: Obx(
                    () => CustomOutlinedButton(
                      onPressedAction: () =>
                          controller.pickDate(context, isStart: false),
                      buttonText: controller.formatDate(
                        controller.endDate.value,
                      ),
                      isIcon: true,
                      iconData: Icons.keyboard_arrow_down_outlined,
                    ),
                  ),
                ),
                SizedBox(width: 18),
                Text("At"),
                SizedBox(width: 5),
                Expanded(
                  flex: 1,
                  child: Obx(
                    () => CustomOutlinedButton(
                      onPressedAction: () =>
                          controller.pickTime(context, isStart: false),
                      isIcon: false,
                      buttonText: controller.formatTime(
                        controller.endTime.value,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              "Shift attachments",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(hintText: "Add manager note"),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 90,
              child: CustomOutlinedButton(
                onPressedAction: () {},
                isIcon: false,
                bgColor: AppColors.primary,
                fgColor: Colors.white,
                buttonText: "Save",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
