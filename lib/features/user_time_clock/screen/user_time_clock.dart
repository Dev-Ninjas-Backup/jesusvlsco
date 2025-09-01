import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jesusvlsco/features/user_time_clock/controller/user_time_clock_controller.dart';

class UserTimeClock extends StatelessWidget {
  final UserTimeClockController userTimeClockController = Get.put(UserTimeClockController());

  UserTimeClock({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      zoom: 17,
                      target: userTimeClockController.currentLocation.value,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId("Current Location"),
                        position: userTimeClockController.currentLocation.value,
                        infoWindow: const InfoWindow(title: "Current Location"),
                      ),
                    },
                    onMapCreated: (GoogleMapController controller) {
                      userTimeClockController.setMapController(controller);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Display current coordinates
              Text(
                "Current Location: ${userTimeClockController.currentLocation.value.latitude.toStringAsFixed(6)}, "
                "${userTimeClockController.currentLocation.value.longitude.toStringAsFixed(6)}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Nothing Scheduled today",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                child: const Column(
                  children: [
                    Icon(Icons.schedule, size: 40, color: Colors.white),
                    Text(
                      "Clock in",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.check_circle, color: Colors.amber),
                        Text("My requests"),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.calendar_month_outlined, color: Colors.blue),
                        Text("Time sheet"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),
            ],
          )),
    );
  }
}