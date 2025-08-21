import 'package:flutter/material.dart';

class RequestUserContainer extends StatelessWidget {
  final Color buttonBGColor;
  final String buttonName;
  final Icon buttonIcon;
  const RequestUserContainer({
    super.key,
    required this.buttonBGColor,
    required this.buttonName,
    required this.buttonIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        //color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                // backgroundImage: NetworkImage(
                //   'https://example.com/user_image.jpg',
                // ),
                radius: 20,
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jenny Wilson",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF4E53B1),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Requested on: 2023-10-01",
                    style: TextStyle(fontSize: 14, color: Color(0xFF4E53B1)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          //this is for time off type row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Color(0xFFEDEEF7),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Time Off Type: ",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Sick Leave",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4E53B1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 16),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        backgroundColor: Color(0xFF4E53B1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        //Handle paid button
                      },
                      child: Text("Paid"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //this is for date column
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Color(0xFFEDEEF7),
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Dates: ",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "03/30/2025",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4E53B1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text("(1 day- 8:00 hours)"),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Color(0xFFEDEEF7),
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Note ",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "I need 1 day leave",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4E53B1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Color(0xFFEDEEF7),
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Note ",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "I need 1 day leave",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4E53B1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonBGColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonIcon,//Icon(Icons.check_circle_outline_outlined),
                  Text(
                    buttonName, //"Approve", 
                    style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
