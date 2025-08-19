import 'package:flutter/material.dart';

class CreateNewPollScreen extends StatelessWidget {
  const CreateNewPollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create New Poll')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Type"),
                    SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Survey',
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.keyboard_arrow_down_outlined),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text("Survey Title"),
                    SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter survey title here',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text("Description"),
                    SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter survey description here',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text("Add a field"),
              Divider(thickness: 1, color: Colors.grey.shade300),
              SizedBox(height: 16),
              Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _createButton(),
                  _createButton(
                    iconData: Icon(Icons.check_box),
                    textTitle: "Dropdown",
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _createButton(
                    iconData: Icon(Icons.menu),
                    textTitle: "Open ended",
                  ),
                  _createButton(
                    iconData: Icon(Icons.star_border_rounded),
                    textTitle: "Rating",
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                "Survey title",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(thickness: 1, color: Colors.grey.shade300),
              SizedBox(height: 16),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.menu),
                              SizedBox(width: 8),
                              Text("Please Write your full name"),
                              Spacer(),
                              Icon(Icons.delete),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  _createButton(textTitle: "Save Template"),
                  SizedBox(width: 8),
                  _createButton(
                    textTitle: "Publish",
                    bgColor: Color(0XFF4E53B1),
                    fgColor: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _createButton({
    final Icon? iconData,
    final String? textTitle,
    final Color? bgColor,
    final Color? fgColor,
  }) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? Colors.white,
          foregroundColor: fgColor?? Color(0XFF484848),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            iconData ?? Icon(Icons.menu),
            Text(textTitle ?? "Description"),
          ],
        ),
      ),
    );
  }
}
