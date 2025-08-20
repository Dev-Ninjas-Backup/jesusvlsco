import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/features/poll/create_new_poll_four/screen/create_new_poll_four_screen.dart';
import '../../create_new_poll_two/widgets/progress_indicator.dart';
import '../controller/create_new_poll_three_controller.dart';

class CreateNewPollThreeScreen extends StatelessWidget {
  const CreateNewPollThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateNewPollThreeController());

    final steps = ["Assign by", "Recipients", "Publish settings", "Summary"];

    return Scaffold(
      appBar: Custom_appbar(title: "Create New Poll"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Progress Indicator
            Center(
              child: ProgressIndicatorWithLabels(
                currentStep: 2, // fixed: Recipients step
                steps: steps,
              ),
            ),
            const SizedBox(height: 24),

            /// 🔹 Title
            const Text(
              "Select user from the list",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4E53B1),
              ),
            ),
            const SizedBox(height: 16),

            /// 🔹 Search & Filter Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search articles",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list, color: Color(0xFF4E53B1)),
                  label: const Text("Filter"),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF4E53B1)),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            /// 🔹 User List Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                color: Colors.grey.shade100,
              ),
              child: Row(
                children: const [
                  SizedBox(width: 30, child: Checkbox(value: false, onChanged: null)),
                  Expanded(child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(width: 80, child: Text("ID", style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),

            /// 🔹 User List
            Expanded(
              child: ListView.builder(
                itemCount: controller.users.length,
                itemBuilder: (context, index) {
                  final user = controller.users[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.grey.shade300),
                        right: BorderSide(color: Colors.grey.shade300),
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      children: [
                        Obx(() => Checkbox(
                          value: controller.selectedUsers.contains(user["id"]),
                          onChanged: (val) {
                            controller.toggleUser(user["id"] as int);
                          },
                        )),
                        CircleAvatar(
                          backgroundImage: NetworkImage(user["avatar"] as String),
                          radius: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(child: Text(user["name"] as String)),
                        SizedBox(width: 80, child: Text(user["id"].toString())),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            /// 🔹 Pagination
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                8,
                    (index) => GestureDetector(
                  onTap: () => controller.setPage(index + 1),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: controller.currentPage.value == index + 1
                          ? const Color(0xFF4E53B1)
                          : Colors.white,
                      border: Border.all(color: const Color(0xFF4E53B1)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(
                        color: controller.currentPage.value == index + 1
                            ? Colors.white
                            : const Color(0xFF4E53B1),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// 🔹 Bottom Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF4E53B1)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Cancel", style: TextStyle(color: Color(0xFF4E53B1))),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.goToNextStep();
                      Get.to(CreateNewPollFourScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E53B1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Next step"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
