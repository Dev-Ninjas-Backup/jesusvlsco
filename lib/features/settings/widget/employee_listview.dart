import 'package:flutter/material.dart';
import 'package:jesusvlsco/features/settings/widget/checkbox.dart';

class Contact {
  final String name;
  final String id;
  bool isSelected;

  Contact({required this.name, required this.id, this.isSelected = false});
}

class EmployeeListview extends StatelessWidget {
  final List<Contact> contacts;
  final Function(int index) onDelete;
  final Function(int index, bool isSelected) onSelectionChanged;

  const EmployeeListview({
    Key? key,
    required this.contacts,
    required this.onDelete,
    required this.onSelectionChanged,
  }) : super(key: key); // Removed the unnecessary 'employees' parameter

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: contact.isSelected ? Colors.blue[50] : Colors.white,
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            child: ListTile(
              leading: CustomCheckbox(
                value: contact.isSelected,
                onChanged: (value) => onSelectionChanged(index, value),
              ),
              title: Text(contact.name),
              subtitle: Text(contact.id),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => onDelete(index),
              ),
            ),
          ),
        );
      },
    );
  }
}
