import 'package:get/get.dart';

class TimeOffPolicy {
  final String name;
  final int days;
  TimeOffPolicy(this.name, this.days);
}

class TimeOffRequest {
  final String date;
  final String policy;
  final String requestedOn;
  final String totalRequested;
  final String status;
  final String notes;
  final int statusType; // 0: approved, 1: rejected, 2: pending, 3: added
  TimeOffRequest({
    required this.date,
    required this.policy,
    required this.requestedOn,
    required this.totalRequested,
    required this.status,
    required this.notes,
    required this.statusType,
  });
}

class TimeOffRequestsController extends GetxController {
  final policies = <TimeOffPolicy>[
    TimeOffPolicy('Time off', 22),
    TimeOffPolicy('Sick leave', 10),
    TimeOffPolicy('Casual leave', 12),
    TimeOffPolicy('Unpaid leave', 8),
  ].obs;

  final requests = <TimeOffRequest>[
    TimeOffRequest(
      date: '12/07/25-Full day',
      policy: 'Sick leave',
      requestedOn: '12/07/25',
      totalRequested: '1 Days',
      status: 'Added by admin',
      notes: 'View',
      statusType: 3,
    ),
    TimeOffRequest(
      date: '27/06/25-Full day',
      policy: 'Time off',
      requestedOn: '27/06/25',
      totalRequested: '1 Days',
      status: 'Rejected',
      notes: 'View',
      statusType: 1,
    ),
    TimeOffRequest(
      date: '27/06/25-Full day',
      policy: 'Time off',
      requestedOn: '27/06/25',
      totalRequested: '1 Days',
      status: 'Rejected',
      notes: 'View',
      statusType: 1,
    ),
    TimeOffRequest(
      date: '25/06/25-Full day',
      policy: 'Sick leave',
      requestedOn: '25/06/25',
      totalRequested: '1 Days',
      status: 'Pending',
      notes: 'View',
      statusType: 2,
    ),
    TimeOffRequest(
      date: '25/06/25-Full day',
      policy: 'Sick leave',
      requestedOn: '25/06/25',
      totalRequested: '1 Days',
      status: 'Pending',
      notes: 'View',
      statusType: 2,
    ),
    TimeOffRequest(
      date: '16/06/25-Full day',
      policy: 'Sick leave',
      requestedOn: '16/06/25',
      totalRequested: '1 Days',
      status: 'Approved',
      notes: 'View',
      statusType: 0,
    ),
    TimeOffRequest(
      date: '16/06/25-Full day',
      policy: 'Sick leave',
      requestedOn: '16/06/25',
      totalRequested: '1 Days',
      status: 'Approved',
      notes: 'View',
      statusType: 0,
    ),
  ].obs;
}
