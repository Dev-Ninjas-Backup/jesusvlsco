import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListController extends GetxController {
  final RxDouble sliderValue = 0.0.obs;
  final RxDouble maxScrollExtent = 1.0.obs; // Use a default value
  final ScrollController scrollController = ScrollController();

  // Your existing data
  final RxList<Map<String, dynamic>> shoppingCenters = <Map<String, dynamic>>[
    {
      'name': 'Shopping Center A',
      'isSelected': false,
      'infoIcon': 'assets/icons/info-icon.svg',
      'startTime': '09:00 AM',
      'dueDate': '05:00 PM',
      'assignTo': 'John Doe',
    },
    {
      'name': 'Shopping Center B',
      'isSelected': false,
      'infoIcon': 'assets/icons/info-icon.svg',
      'startTime': '10:00 AM',
      'dueDate': '06:00 PM',
      'assignTo': 'Jane Smith',
    },
    // Add more dummy data as needed to make the list scrollable
    {
      'name': 'Shopping Center C',
      'isSelected': false,
      'infoIcon': 'assets/icons/info-icon.svg',
      'startTime': '11:00 AM',
      'dueDate': '07:00 PM',
      'assignTo': 'Peter Jones',
    },
     {
      'name': 'Shopping Center D',
      'isSelected': false,
      'infoIcon': 'assets/icons/info-icon.svg',
      'startTime': '12:00 PM',
      'dueDate': '08:00 PM',
      'assignTo': 'Mary Green',
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Add a listener to the scroll controller
    scrollController.addListener(_updateSliderFromScroll);
    // Use WidgetsBinding to get maxScrollExtent after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        maxScrollExtent.value = scrollController.position.maxScrollExtent;
      }
    });
  }

  void _updateSliderFromScroll() {
    if (scrollController.hasClients) {
      sliderValue.value = scrollController.position.pixels;
      // Also update maxScrollExtent in case the content size changes
      maxScrollExtent.value = scrollController.position.maxScrollExtent;
    }
  }

  void updateScrollFromSlider(double value) {
    if (scrollController.hasClients) {
      scrollController.jumpTo(value);
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}