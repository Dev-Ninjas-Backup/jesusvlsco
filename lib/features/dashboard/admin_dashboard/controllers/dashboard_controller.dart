// ignore_for_file: deprecated_member_use

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DashboardController extends GetxController {
  var totalResponses = 50.obs;
  var currentResponses = 32.obs;
  var daysLeft = 3.obs;

  double get progress => currentResponses.value / totalResponses.value;
  String get percentage => "${(progress * 100).toStringAsFixed(0)}% Completed";
  String get responseText =>
      "${currentResponses.value}/${totalResponses.value} Responses";
  final List<Map<String, String>> recentChats = [
    {
      'profileImage': 'assets/images/userprofile.png',
      'name': 'John Doe',
      'lastMessage': 'Hey, how are you doing today?',
      'time': '3m ago',
    },
    {
      'profileImage': 'assets/images/userprofile.png',
      'name': 'Sarah Wilson',
      'lastMessage': 'Thanks for the update, looks great!',
      'time': '15m ago',
    },
  ];
  final List<Map<String, String>> assignedEmployees = [
    {
      'profileImage': 'assets/images/userprofile.png',
      'name': 'Alice Johnson',
      'project': 'UI/UX Project',
      'shift': 'Morning Shift',
    },
    {
      'profileImage': 'assets/images/userprofile.png',
      'name': 'Mike Chen',
      'project': 'Backend Dev',
      'shift': 'Evening Shift',
    },
  ];
  final List<Map<String, dynamic>> requestList = [
    {
      'name': 'John Smith',
      'status': 'Pending',
      'requestType': 'Vacation',
      'days': '3 days',
      'startDate': 'Jun 13',
      'endDate': 'Jun 17, 2025',
    },
    {
      'name': 'Sarah Wilson',
      'status': 'Approved',
      'requestType': 'Sick Leave',
      'days': '2 days',
      'startDate': 'Jun 15',
      'endDate': 'Jun 16, 2025',
    },
    {
      'name': 'Mike Johnson',
      'status': 'Pending',
      'requestType': 'Personal Leave',
      'days': '1 day',
      'startDate': 'Jun 20',
      'endDate': 'Jun 20, 2025',
    },
  ];
  bool isPending(String status) => status == 'Pending';
  // Add this to your existing controller
  final List<Map<String, String>> recognitionList = [
    {
      'profileImage': 'assets/images/userprofile.png',
      'name': 'Alice Johnson',
      'recognitionIcon': 'assets/icons/team-player.png',
      'recognition': 'Team player',
    },
    {
      'profileImage': 'assets/images/userprofile.png',
      'name': 'Mike Chen',
      'recognitionIcon': 'assets/icons/creative.png',
      'recognition': 'Creative',
    },
    {
      'profileImage': 'assets/images/userprofile.png',
      'name': 'Sarah Wilson',
      'recognitionIcon': 'assets/icons/creative.png',
      'recognition': 'Creative',
    },
  ];

  final List<Map<String, String>> shiftNotifications = [
    {
      'icon': 'assets/icons/schedule_inactive.png',
      'title': 'Schedule Update',
      'subtitle': 'New schedule for next week has been published.',
      'time': '4 hours ago',
    },
    {
      'icon': 'assets/icons/notification.png',
      'title': 'Break Reminder',
      'subtitle': 'Don\'t forget to take your lunch break at 12:30 PM.',
      'time': '1 day ago',
    },
  ];
  late GoogleMapController mapController;
  final RxSet<Marker> markers = <Marker>{}.obs;

  final LatLng location1 = const LatLng(44.9800, -93.2636); // Green
  final LatLng location2 = const LatLng(44.9730, -93.2660); // Red
  final LatLng location3 = const LatLng(44.9778, -93.2650); // Yellow

  final LatLng initialCameraPosition = const LatLng(44.9764, -93.2650);

  @override
  void onInit() {
    super.onInit();
    _loadCustomMarkers();
  }

  Future<void> _loadCustomMarkers() async {
    final BitmapDescriptor greenIcon = await _bitmapFromAsset(
      'assets/markers/green_pin.png',
    );
    final BitmapDescriptor redIcon = await _bitmapFromAsset(
      'assets/markers/red_pin.png',
    );
    final BitmapDescriptor yellowIcon = await _bitmapFromAsset(
      'assets/markers/yellow_pin.png',
    );

    markers.addAll({
      Marker(
        markerId: const MarkerId('location1'),
        position: location1,
        icon: greenIcon,
        infoWindow: const InfoWindow(title: 'Location 1'),
      ),
      Marker(
        markerId: const MarkerId('location2'),
        position: location2,
        icon: redIcon,
        infoWindow: const InfoWindow(title: 'Location 2'),
      ),
      Marker(
        markerId: const MarkerId('location3'),
        position: location3,
        icon: yellowIcon,
        infoWindow: const InfoWindow(title: 'Location 3'),
      ),
    });
  }

  Future<BitmapDescriptor> _bitmapFromAsset(String path) async {
    final byteData = await rootBundle.load(path);
    return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
