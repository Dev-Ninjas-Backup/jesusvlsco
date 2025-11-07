import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/recognition/screens/create_recognition.dart';
import 'package:jesusvlsco/features/recognition/screens/send_recognitation_pages.dart';
import 'package:jesusvlsco/features/recognition/screens/summery_recognition.dart';

class RecognitionController extends GetxController {
  var currentStep = 0.obs;

  // Define the steps (each step will have one widget here)
  List<Widget> steps = [
    // CreateRecognition(),
    // SendRecognitationPages(),
    SendRecognitationPages(),
    SizedBox(
      height: Sizer.hp(600),
      width: double.infinity,

      child: CreateRecognition(),
    ),

    RecognitionCard(),
  ];

  // Method to handle moving to the next step
  void nextStep() {
    if (currentStep < steps.length - 1) {
      currentStep++;
      update();
    }
  }

  // Method to handle canceling (e.g., reset to the first step)
  void cancel() {
    if (currentStep <= 0) {
      currentStep == 0.obs;
      Get.snackbar("Error", "No steps available.");
    }
    currentStep--;

    update();
  }

  // Sample list of data (for demonstration, you can replace this with real data)
  final List<Map<String, dynamic>> users = [
    {
      "name": "John Smith",
      "imageUrl":
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
      "badge": "teamplayer",
      "likes": 10,
      "messages": 1,
    },
    {
      "name": "John Smith",
      "imageUrl":
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
      "badge": "teamplayer",
      "likes": 10,
      "messages": 1,
    },
    {
      "name": "John Smith",
      "imageUrl":
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
      "badge": "teamplayer",
      "likes": 10,
      "messages": 1,
    },
    {
      "name": "John Smith",
      "imageUrl":
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
      "badge": "teamplayer",
      "likes": 10,
      "messages": 1,
    },
    {
      "name": "John Smith",
      "imageUrl":
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
      "badge": "teamplayer",
      "likes": 10,
      "messages": 1,
    },
    {
      "name": "John Smith",
      "imageUrl":
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
      "badge": "teamplayer",
      "likes": 10,
      "messages": 1,
    },
    {
      "name": "John Smith",
      "imageUrl":
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
      "badge": "teamplayer",
      "likes": 10,
      "messages": 1,
    },
    {
      "name": "John Smith",
      "imageUrl":
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
      "badge": "teamplayer",
      "likes": 10,
      "messages": 1,
    },

    // Add more user data here
  ];

  Future<void> selectDate(BuildContext context) async {
    // Set the initial date to today's date
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2000); // The earliest date user can select
    DateTime lastDate = DateTime(2101); // The latest date user can select

    // Show the date picker dialog
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate != null && selectedDate != initialDate) {
      // If a date was selected, display it
      String formattedDate = "${selectedDate.toLocal()}".split(
        ' ',
      )[0]; // Format the date
      // You can update the UI or use the selected date as needed
      if (kDebugMode) {
        print("Selected date: $formattedDate");
      }
    } else {
      if (kDebugMode) {
        print("No date selected");
      }
    }
  }

  final List<Map<String, dynamic>> dummyData = [
    {
      "id": 145454,
      "name": "John Smith",
      "imageUrl":
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    },
    {
      "id": 223263,
      "name": "Alice Johnson",
      "imageUrl":
          "https://images.unsplash.com/photo-1501594907356-e992e3c5408f?crop=entropy&cs=tinysrgb&fit=max&ixid=MnwzNjc5OXwwfDF8c2VhcmNofDJ8fGF2YXRhfGVufDB8fDB8fA%3D%3D&w=500&h=500&ixlib=rb-1.2.1",
    },
    {
      "id": 145454,
      "name": "John Smith",
      "imageUrl":
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    },
    {
      "id": 223263,
      "name": "Alice Johnson",
      "imageUrl":
          "https://images.unsplash.com/photo-1501594907356-e992e3c5408f?crop=entropy&cs=tinysrgb&fit=max&ixid=MnwzNjc5OXwwfDF8c2VhcmNofDJ8fGF2YXRhfGVufDB8fDB8fA%3D%3D&w=500&h=500&ixlib=rb-1.2.1",
    },
    {
      "id": 145454,
      "name": "John Smith",
      "imageUrl":
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    },
    {
      "id": 223263,
      "name": "Alice Johnson",
      "imageUrl":
          "https://images.unsplash.com/photo-1501594907356-e992e3c5408f?crop=entropy&cs=tinysrgb&fit=max&ixid=MnwzNjc5OXwwfDF8c2VhcmNofDJ8fGF2YXRhfGVufDB8fDB8fA%3D%3D&w=500&h=500&ixlib=rb-1.2.1",
    },
    {
      "id": 145454,
      "name": "John Smith",
      "imageUrl":
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    },
    {
      "id": 223263,
      "name": "Alice Johnson",
      "imageUrl":
          "https://images.unsplash.com/photo-1501594907356-e992e3c5408f?crop=entropy&cs=tinysrgb&fit=max&ixid=MnwzNjc5OXwwfDF8c2VhcmNofDJ8fGF2YXRhfGVufDB8fDB8fA%3D%3D&w=500&h=500&ixlib=rb-1.2.1",
    },
    {
      "id": 145454,
      "name": "John Smith",
      "imageUrl":
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    },
    {
      "id": 145454,
      "name": "John Smith",
      "imageUrl":
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    },
    {
      "id": 223263,
      "name": "Alice Johnson",
      "imageUrl":
          "https://images.unsplash.com/photo-1501594907356-e992e3c5408f?crop=entropy&cs=tinysrgb&fit=max&ixid=MnwzNjc5OXwwfDF8c2VhcmNofDJ8fGF2YXRhfGVufDB8fDB8fA%3D%3D&w=500&h=500&ixlib=rb-1.2.1",
    },
    {
      "id": 145454,
      "name": "John Smith",
      "imageUrl":
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    },
    {
      "id": 223263,
      "name": "Alice Johnson",
      "imageUrl":
          "https://images.unsplash.com/photo-1501594907356-e992e3c5408f?crop=entropy&cs=tinysrgb&fit=max&ixid=MnwzNjc5OXwwfDF8c2VhcmNofDJ8fGF2YXRhfGVufDB8fDB8fA%3D%3D&w=500&h=500&ixlib=rb-1.2.1",
    },
    {
      "id": 145454,
      "name": "John Smith",
      "imageUrl":
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    },
  ];
}
