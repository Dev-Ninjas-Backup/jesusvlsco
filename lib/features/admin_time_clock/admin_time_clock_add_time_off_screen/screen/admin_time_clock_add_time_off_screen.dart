import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_add_shift/widget/custom_outlined_button.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_add_time_off_screen/controller/admin_time_clock_add_time_off_screen_controller.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_add_time_off_screen/widget/show_select_user_pop_up.dart';
import 'package:jesusvlsco/features/admin_time_clock/admin_time_clock_add_time_off_screen/widget/show_time_of_type_pop_up.dart';

class AdminTimeClockAddTimeOffScreen extends StatelessWidget {
  const AdminTimeClockAddTimeOffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminTimeClockAddTimeOffScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add time off",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            //this is for user select row--
            Row(
              children: [
                Text(
                  "Select User",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(flex: 1),
                Expanded(
                  flex: 2,
                  child: Obx(
                    () => CustomOutlinedButton(
                      onPressedAction: () =>
                          showSelectedUserPopUp(context, controller),
                      prefixIcon: true,
                      buttonText:
                          controller.selectedProject.value, //"Jenny Wilson",
                      iconData: Icons.keyboard_arrow_down,
                      isIcon: true,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            //this is for time off type row--
            Row(
              children: [
                Text(
                  "Time off type",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(flex: 1),
                Expanded(
                  flex: 2,
                  child: Obx(
                    () => CustomOutlinedButton(
                      onPressedAction: () =>
                          showTimeOffTimePopUp(context, controller),
                      prefixIcon: false,
                      buttonText: controller.selectedTimeOfType.value,
                      iconData: Icons.keyboard_arrow_down,
                      isIcon: true,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // this is for switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All day time off",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Obx(
                  () => Switch(
                    value: controller.isSwitchOn.value,
                    onChanged: (value) {
                      controller.isSwitchOn.value = value;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date and time of time off",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: AppColors.primary),
                  ),
                  child: Row(
                    spacing: 5,
                    children: [
                      Icon(Icons.calendar_month, color: AppColors.primary),
                      Container(width: 2, height: 20, color: AppColors.primary),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            //for switch button action work
            Obx(
              () => controller.isSwitchOn.value
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                decoration: InputDecoration(hintText: "12:00"),
                              ),
                            ),
                            SizedBox(width: 16),
                            Text("to"),
                            SizedBox(width: 16),
                            Flexible(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "12:00",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total time off days"),
                            Text("1.00 work days"),
                          ],
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ),
            //
            SizedBox(height: 16),
            Text(
              "Notes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(hintText: "Add manager note"),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 80,
              child: CustomOutlinedButton(
                onPressedAction: () {},
                buttonText: "Save",
                fgColor: Colors.white,
                bgColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
