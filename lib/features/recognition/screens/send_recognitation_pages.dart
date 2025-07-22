import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/announcements/admin_announcement/controllers/announcement_controller.dart';
import 'package:jesusvlsco/features/recognition/controllers/recognition_controller.dart';

class SendRecognitationPages extends StatelessWidget {
  const SendRecognitationPages({super.key});

  @override
  Widget build(BuildContext context) {
    final RecognitionController controller = Get.put(RecognitionController());
    return Column(
      children: [
        Center(
          child: Container(
            // height: Sizer.hp(740),
            width: Sizer.wp(360),
            padding: EdgeInsets.only(
              top: Sizer.wp(24),
              left: Sizer.wp(16),
              right: Sizer.wp(16),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(Sizer.wp(12)),
            ),
            child: Column(
              children: [
                // Header section for name and ID, dynamically populated
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryBackground,
                    borderRadius: BorderRadius.circular(Sizer.wp(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            activeColor: AppColors.primary,
                            value: true,
                            onChanged: (value) {},
                          ),
                          Text(
                            "Name", // Dynamic name
                            style: TextStyle(
                              fontSize: Sizer.wp(16),
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ID", // Dynamic ID
                            style: TextStyle(
                              fontSize: Sizer.wp(16),
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Divider between header and the list
                Divider(
                  color: AppColors.border,
                  thickness: 1,
                  height: Sizer.hp(2),
                ),
                // List view with items separated by dividers
                ListView.separated(
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // Disable scrolling to allow parent to scroll
                  itemCount: controller.dummyData.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              activeColor: AppColors.primary,
                              value: true,
                              onChanged: (value) {},
                            ),
                            // Avatar (dummy data)
                            CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage(
                                controller.dummyData[index]['imageUrl'],
                              ),
                            ),
                            SizedBox(width: Sizer.wp(8)),

                            // Name (dummy data)
                            Text(
                              controller.dummyData[index]['name'],
                              style: AppTextStyle.regular().copyWith(
                                fontSize: Sizer.wp(14),
                                color: AppColors.text,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Text(
                              controller.dummyData[index]['id'].toString(),
                              style: AppTextStyle.regular().copyWith(
                                fontSize: Sizer.wp(14),
                                color: AppColors.text,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    // Divider between list items
                    return Divider(
                      color: AppColors.border, // Divider color
                      thickness: 1,
                      height: Sizer.hp(2), // Space between the list items
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: Sizer.hp(16)),
        _pagination(),
      ],
    );
  }

  Widget _pagination() {
    final AnnouncementController announcementController = Get.put(
      AnnouncementController(),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        2, // Assuming there are 2 pages
        (index) {
          return GestureDetector(
            onTap: () {
              announcementController.changePage(
                index + 1,
              ); // Set current page to tapped index (1-based)
            },
            child: Obx(
              () => Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 8,
                ), // Add space between boxes
                width: Sizer.wp(36), // Width of the box
                height: Sizer.hp(36), // Height of the box
                decoration: BoxDecoration(
                  color: announcementController.currentPage.value == index + 1
                      ? AppColors
                            .primary // Highlight selected page with blue
                      : Colors
                            .transparent, // Default color for non-selected pages
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                  border: Border.all(
                    color: announcementController.currentPage.value == index + 1
                        ? AppColors.primary
                        : AppColors.border, // Border color
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}', // Display page number (index + 1 for 1-based indexing)
                    style: AppTextStyle.regular().copyWith(
                      fontSize: 14,
                      color:
                          announcementController.currentPage.value == index + 1
                          ? Colors
                                .white // White text for selected page
                          : Colors.black, // Black text for non-selected pages
                      fontWeight: FontWeight.bold, // Bold text
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
