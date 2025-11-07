import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/user_time_clock/controller/user_request_controller.dart';

class UserRequest extends StatelessWidget {
  final controller = Get.put(UserRequestTimeOffController());
  UserRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                Spacer(flex: 1),
                Text(
                  "My Request History",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(flex: 2),
              ],
            ),
            SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: Text(
            //     "Time of policy",
            //     style: TextStyle(
            //       fontSize: 14,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 8),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       _timeOfPolicyContainer(
            //         leaveType: 'Time off',
            //         leftDay: ' 0 Days',
            //       ),
            //       _timeOfPolicyContainer(
            //         leaveType: 'Sick Leave',
            //         leftDay: '0 Days',
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 8),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       _timeOfPolicyContainer(
            //         leaveType: 'Casual Leave',
            //         leftDay: '0 Days',
            //       ),
            //       _timeOfPolicyContainer(
            //         leaveType: 'Unpaid Leave',
            //         leftDay: '0 Days',
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 16),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: Text(
            //     "Time of policy",
            //     style: TextStyle(
            //       fontSize: 14,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            //SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.timeOffRequests.isEmpty) {
                  return const Center(child: Text("No requests found."));
                }

                return ListView.builder(
                  itemCount: controller.timeOffRequests.length,
                  itemBuilder: (context, index) {
                    final request = controller.timeOffRequests[index];

                    return Card(
                      color: Colors.white70,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: _infoRow(
                                    "📅 Date",
                                    "${controller.dateFormatter.format(request.startDate)} to ${controller.dateFormatter.format(request.endDate)}",
                                  ),
                                ),
                                _statusChip(request.status),
                              ],
                            ),
                            _infoRow("📋 Reason", request.reason),
                            _infoRow(
                              "🕒 Requested On",
                              request.createdAt.toString(),
                            ),
                            _infoRow(
                              "📆 Total Days",
                              "${request.totalDaysOff} Days",
                            ),
                            if ((request.adminNote ?? '').isNotEmpty)
                              Align(
                                alignment: Alignment.center,
                                child: TextButton(
                                  onPressed: () =>
                                      controller.viewNotes(request),
                                  child: const Text("View Notes"),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Container _timeOfPolicyContainer({
  //   required String leaveType,
  //   required String leftDay,
  // }) {
  //   return Container(
  //     padding: EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: AppColors.primary.withValues(alpha: 0.2),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: Column(
  //       children: [
  //         Text(
  //           leaveType,
  //           //"Casual Leave",
  //           style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.black,
  //           ),
  //         ),
  //         Text(
  //           leftDay,
  //           //"0 days",
  //           style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.black,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

Widget _infoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Expanded(child: Text(value)),
      ],
    ),
  );
}

Widget _statusChip(String status) {
  final color = status == "PENDING" ? Colors.black : Colors.green;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: .2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(status, style: TextStyle(color: color)),
  );
}
