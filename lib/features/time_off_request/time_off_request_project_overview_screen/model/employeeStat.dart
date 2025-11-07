// ignore_for_file: file_names

class EmployeeStat {
  final String name;
  final String role;
  final String imageUrl;
  final int timeOff;
  final int sickLeave;
  final int casualLeave;
  final int unpaidLeave;
  final String status;

  const EmployeeStat({
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.timeOff,
    required this.sickLeave,
    required this.casualLeave,
    required this.unpaidLeave,
    required this.status,
  });
}
