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
    return Scaffold(
      body: Obx(
        () => Column(
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
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: AlertDialog(
                        
                        title: Text("Choose one",textAlign: TextAlign.center,),
                        titleTextStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () async{
                                  //here clock in post request work
                                  Get.back();
                                  userTimeClockController.clockInNow();
                                  
                                },
                                child: Text(
                                  "clock in",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  //if needed here to clock out request action 
                                },
                                child: Text(
                                  "clock out",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        iconPadding: EdgeInsets.only(right: 2,bottom: 2),
                        icon: IconButton(
                          onPressed: (){
                            Get.back();
                          }, icon: Icon(Icons.close,color: Colors.red,)),
                      ),
                    );
                  },
                );
              },
              child: Container(
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
        ),
      ),
    );
  }
}
