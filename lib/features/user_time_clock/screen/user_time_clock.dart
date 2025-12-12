import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jesusvlsco/features/user_time_clock/controller/user_time_clock_controller.dart';
import 'package:jesusvlsco/features/user_time_clock/screen/user_request.dart';

class UserTimeClock extends StatelessWidget {
  final UserTimeClockController userTimeClockController = Get.put(
    UserTimeClockController(),
  );
  UserTimeClock({super.key});
  @override
  Widget build(BuildContext context) {
    RxBool isClockInLoading = false.obs;
    RxBool isClockOutLoading = false.obs;

    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(() {
          final isClockedIn = userTimeClockController.isClockedIn.value;
          return Column(
            children: [
              SizedBox(
                height: 650,
                child: Stack(
                  children: [
                    SizedBox.expand(
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          zoom: 17,
                          target: userTimeClockController.currentLocation.value,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId("Current Location"),
                            position:
                                userTimeClockController.currentLocation.value,
                            infoWindow: const InfoWindow(
                              title: "Current Location",
                            ),
                          ),
                        },
                        onMapCreated: (GoogleMapController controller) {
                          userTimeClockController.setMapController(controller);
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.only(top: 50, left: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Current Location: ${userTimeClockController.currentLocation.value.latitude.toStringAsFixed(6)}, "
                "${userTimeClockController.currentLocation.value.longitude.toStringAsFixed(6)}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: isClockedIn
                    ? (isClockOutLoading.value
                          ? null
                          : () async {
                              isClockOutLoading.value = true;
                              try {
                                userTimeClockController.clockOutNow();
                                Get.back();
                              } catch (e) {
                                Get.snackbar('Error', 'Clock Out failed: $e');
                              } finally {
                                isClockOutLoading.value = false;
                              }
                            })
                    : (isClockInLoading.value
                          ? null
                          : () async {
                              isClockInLoading.value = true;
                              try {
                                userTimeClockController.clockInNow();
                                Get.back();
                              } catch (e) {
                                Get.snackbar('Error', 'Clock In failed: $e');
                              } finally {
                                isClockInLoading.value = false;
                              }
                            }),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: isClockedIn ? Colors.red : Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.schedule, size: 40, color: Colors.white),
                      Text(
                        isClockedIn ? "Clock Out" : "Clock In",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Get.to(UserRequest());
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    spacing: 8,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Colors.amber),
                      Text("My requests"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 36),
            ],
          );
        }),
      ),
    );
  }
}
