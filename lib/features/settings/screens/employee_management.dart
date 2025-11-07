import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/features/settings/widget/employee_listview.dart';
import 'package:jesusvlsco/features/settings/widget/textfield.dart';
import 'package:jesusvlsco/features/settings/widget/textfield_with_dropdown.dart';
import 'package:flutter/cupertino.dart';

class EmployeeManagement extends StatefulWidget {
  const EmployeeManagement({super.key});

  @override
  State<EmployeeManagement> createState() => _EmployeeManagementState();
}

class _EmployeeManagementState extends State<EmployeeManagement> {
  final List<String> items = ['Name 1', 'Name 2', 'Option 3'];
  final ValueNotifier<String?> valueNotifier = ValueNotifier<String?>(null);
  final TextEditingController controller = TextEditingController();


  List<Contact> contacts = [
    Contact(name: 'John Doe', id: 'EMP001'),
    Contact(name: 'Jane Smith', id: 'EMP002'),
    Contact(name: 'Mike Johnson', id: 'EMP003'),
    Contact(name: 'Sarah Wilson', id: 'EMP004'),
    Contact(name: 'Tom Brown', id: 'EMP005'),
  ];

  void onChanged(String? value) {
    valueNotifier.value = value;
  }

  void _handleDelete(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  void _handleSelectionChanged(int index, bool isSelected) {
    setState(() {
      contacts[index].isSelected = isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom_appbar(title: "API & Integrations"),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFieldWithDropDown(
                hintText: 'Type here',
                items: items,
                valueNotifier: valueNotifier,
                onChanged: onChanged,
                controller: controller,
              ),
              SizedBox(height: 20),
              Text(
                'Employee ID',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              CustomTextField(hintText: 'Type here'),
              SizedBox(height: 20),
              Text(
                'Employee Login Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A55A2),
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Contact Number',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.delete_solid, color: Colors.red),
                  ),
                ],
              ),
              CustomTextField(hintText: '000 xxxx xxxx'),
              SizedBox(height: 10),
              Text(
                'E-mail',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              CustomTextField(hintText: 'Type here'),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  height: 45,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Save Changes'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: EmployeeListview(
                  contacts: contacts,
                  onDelete: _handleDelete,
                  onSelectionChanged: _handleSelectionChanged,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
