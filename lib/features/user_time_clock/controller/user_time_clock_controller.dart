import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:jesusvlsco/core/services/location_controller.dart';
import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';

class UserTimeClockController extends GetxController {
  // Observable for live user location
  final Rx<LatLng> currentLocation = LatLng(
    23.780836861126474,
    90.40062738047668,
  ).obs;

  final LocationController locationController = Get.put(
    LocationController(),
  ); // Initialize LocationController

  GoogleMapController? mapController; // To control the Google Map

  final action = ''.obs;
  RxBool isClockedIn = false.obs;

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
        distanceFilter: 10,
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
        if (kDebugMode) {
          print('Location Update Error: $error');
        }
      },
    );
  }

  @override
  void onClose() {
    mapController?.dispose();
    super.onClose();
  }

  void clockInNow() {
    action.value = 'CLOCK_IN';
    clockInUser(currentLocation.value);
  }

  Future<void> clockInUser(LatLng location) async {
    final url = Uri.parse(
      '${ApiConstants.baseurl}/employee/time-clock/process-clock',
    );
    final token = await StorageService.getAuthToken();

    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'date': DateTime.now().toUtc().toIso8601String(),
      'lat': location.latitude,
      'lng': location.longitude,
      'action': action.value,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        isClockedIn.value = true;
        EasyLoading.showSuccess(
          "Clock In Successful!",
          duration: Duration(seconds: 2),
        );
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final String errorMessage =
            responseBody['data']?['message'] ?? 'Unknown error';
        Get.snackbar("Error", errorMessage);
        if (kDebugMode) {
          print('Clock-in failed: ${response.statusCode} - ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during clock-in: $e');
      }
    }
  }

  void clockOutNow() {
    action.value = 'CLOCK_OUT';
    clockOutUser(currentLocation.value);
  }

  Future<void> clockOutUser(LatLng location) async {
    final url = Uri.parse(
      '${ApiConstants.baseurl}/employee/time-clock/process-clock',
    );
    final token = await StorageService.getAuthToken();

    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'date': DateTime.now().toUtc().toIso8601String(),
      'lat': location.latitude,
      'lng': location.longitude,
      'action': action.value,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print('Clock-Out successful: ${response.body}');
        }
        isClockedIn.value = false;
        EasyLoading.showSuccess(
          "Clock Out Successful!",
          duration: Duration(seconds: 2),
        );
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final String errorMessage =
            responseBody['data']?['message'] ?? 'Unknown error';
        Get.snackbar("Error", errorMessage);
        if (kDebugMode) {
          print('Clock-out failed: ${response.statusCode} - ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during clock-out: $e');
      }
    }
  }
}
