class EmployeeOverview {
  final String name;
  final String role;
  final String imageUrl;
  final String timeOff;
  final int sickLeave;
  final int casualLeave;
  final int unpaidLeave;
  final String status;

  const EmployeeOverview({
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
