import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jesusvlsco/core/services/location_controller.dart';

class UserTimeClockController extends GetxController {
  // Observable for live user location
  final Rx<LatLng> currentLocation = LatLng(23.780836861126474, 90.40062738047668).obs;
  final LocationController locationController = Get.put(LocationController()); // Initialize LocationController
  GoogleMapController? mapController; // To control the Google Map

  @override
  void onInit() {
    super.onInit();
    // Initialize the location service
    locationController.initializeService();
    // Listen to live location updates
    _listenToLocationUpdates();
  }

  void setMapController(GoogleMapController controller) {
    mapController = controller;
  }

  void _listenToLocationUpdates() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Update every 10 meters
      ),
    ).listen(
      (Position position) {
        // Update the observable currentLocation
        currentLocation.value = LatLng(position.latitude, position.longitude);
        // Animate the map camera to the new location
        mapController?.animateCamera(
          CameraUpdate.newLatLng(currentLocation.value),
        );
      },
      onError: (dynamic error) {
        print('Location Update Error: $error');
      },
    );
  }

  @override
  void onClose() {
    mapController?.dispose();
    super.onClose();
  }
}