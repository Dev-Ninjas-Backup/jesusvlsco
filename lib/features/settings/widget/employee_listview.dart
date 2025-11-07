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
    super.key,
    required this.contacts,
    required this.onDelete,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 60, // Fixed width for checkbox column
              alignment: Alignment.centerLeft,
              child: CustomCheckbox(
                value: _selectAllValue(contacts),
                onChanged: (value) =>
                    _toggleSelectAll(value, contacts, onSelectionChanged),
              ),
            ),
            Expanded(
              flex: 2, // Name column takes more space
              child: Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1, // ID column
              child: Text('ID', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Container(
              width: 100, // Fixed width for actions column
              alignment: Alignment.center,
              child: Text(
                'Actions',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Divider(color: Colors.grey, thickness: 1, height: 20),

        // List of employees
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // For nested ListView
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Checkbox
                    Container(
                      width: 60,
                      alignment: Alignment.centerLeft,
                      child: CustomCheckbox(
                        value: contact.isSelected,
                        onChanged: (value) => onSelectionChanged(index, value),
                      ),
                    ),

                    // Name
                    Expanded(
                      flex: 2,
                      child: Text(contact.name, style: TextStyle(fontSize: 16)),
                    ),

                    // ID
                    Expanded(
                      flex: 1,
                      child: Text(
                        contact.id,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ),

                    Container(
                      width: 100,
                      alignment: Alignment.center,
                      child: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => onDelete(index),
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.grey, thickness: 1, height: 20),
              ],
            );
          },
        ),
      ],
    );
  }

  bool _selectAllValue(List<Contact> contacts) {
    if (contacts.isEmpty) return false;
    final selectedCount = contacts
        .where((contact) => contact.isSelected)
        .length;
    if (selectedCount == 0) return false;
    return selectedCount == contacts.length ? true : false;
  }

  void _toggleSelectAll(
    bool? value,
    List<Contact> contacts,
    Function(int, bool) onSelectionChanged,
  ) {
    if (value != null) {
      for (int i = 0; i < contacts.length; i++) {
        onSelectionChanged(i, value);
      }
    }
  }
}
