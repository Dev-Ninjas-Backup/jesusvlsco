// ignore_for_file: file_names

import 'package:get/get.dart';

class AnnouncementModel {
  final String id;
  final String title;
  final String description;
  final String dateTime;
  final bool isRead;
  final bool hasResponse;
  final String category; // Added category field
   RxBool isChecked = false.obs;

  AnnouncementModel({
    required this.isChecked ,
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    this.isRead = false,
    this.hasResponse = false,
    required this.category, // Make sure to add category to constructor
  });
}
