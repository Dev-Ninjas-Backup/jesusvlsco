// ignore_for_file: avoid_print

import 'dart:convert';

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

  //for clock in
  void clockInNow() {
    clockInUser(currentLocation.value);
    action.value = 'CLOCK_IN';
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
        print('Clock-in successful: ${response.body}');
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final String errorMessage =
            responseBody['data']?['message'] ?? 'Unknown error';
        Get.snackbar("error", errorMessage);
        print('Clock-in failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error during clock-in: $e');
    }
  }

  //for clock out
  void clockOutNow() {
    clockOutUser(currentLocation.value);
    action.value = 'CLOCK_OUT';
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
        print('Clock-in successful: ${response.body}');
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final String errorMessage =
            responseBody['data']?['message'] ?? 'Unknown error';
        Get.snackbar("error", errorMessage);
        print('Clock-in failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error during clock-in: $e');
    }
  }
}
