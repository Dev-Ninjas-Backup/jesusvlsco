import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({super.key});

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  List<Branch> branches = [
    Branch(location: 'New York City', manager: 'Manager 1'),
    Branch(location: 'New York City', manager: 'Manager 2'),
    Branch(location: 'New York City', manager: 'Manager 3'),
  ];

  final List<String> _managers = [
    'Manager 1',
    'Manager 2',
    'Manager 3',
    'Manager 4',
  ];

  void _addBranch() {
    setState(() {
      branches.add(Branch(location: '', manager: _managers.first));
    });
  }

  void _removeBranch(int index) {
    setState(() {
      branches.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom_appbar(title: "Company Profile"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(label: 'Company Name', hint: 'Type Here'),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Location',
              hint: 'Type Here',
              isLocation: true,
            ),
            const SizedBox(height: 24),
            _buildBranchHeader(),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: branches.length,
              itemBuilder: (context, index) {
                return BranchCard(
                  branchNumber: index + 1,
                  branch: branches[index],
                  managers: _managers,
                  onDelete: () => _removeBranch(index),
                  onManagerChanged: (newValue) {
                    setState(() {
                      branches[index].manager = newValue!;
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A55A2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    bool isLocation = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: isLocation
                ? const Icon(Icons.location_on_outlined)
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF4A55A2)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBranchHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Branch',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF4A55A2),
          ),
        ),
        TextButton.icon(
          onPressed: _addBranch,
          icon: const Icon(Icons.add, color: Color(0xFF4A55A2)),
          label: const Text(
            'Add Branch',
            style: TextStyle(
              color: Color(0xFF4A55A2),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class Branch {
  String location;
  String manager;

  Branch({required this.location, required this.manager});
}

class BranchCard extends StatelessWidget {
  final int branchNumber;
  final Branch branch;
  final List<String> managers;
  final VoidCallback onDelete;
  final ValueChanged<String?> onManagerChanged;

  const BranchCard({
    super.key,
    required this.branchNumber,
    required this.branch,
    required this.managers,
    required this.onDelete,
    required this.onManagerChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Branch $branchNumber',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: branch.location,
            decoration: InputDecoration(
              hintText: 'New York City',
              suffixIcon: const Icon(Icons.location_on_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF4A55A2)),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Manager',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: branch.manager,
            onChanged: onManagerChanged,
            items: managers.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF4A55A2)),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
