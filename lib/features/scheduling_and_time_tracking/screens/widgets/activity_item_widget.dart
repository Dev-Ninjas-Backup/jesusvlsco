import 'package:flutter/material.dart';

class ActivityFeed extends StatelessWidget {
  const ActivityFeed({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ActivityItem> activities = [
      ActivityItem(
        date: '19/06',
        time: '12:37 am',
        description: 'Jane Cooper has completed a task',
      ),
      ActivityItem(
        date: '19/06',
        time: '12:32 am',
        description: 'Robert Fox has viewed the task',
      ),
      ActivityItem(
        date: '19/06',
        time: '11:38 am',
        description: 'Admin edited a task',
      ),
      ActivityItem(
        date: '19/06',
        time: '12:30 am',
        description: 'Admin created a task',
      ),
      ActivityItem(
        date: '19/06',
        time: '12:00 am',
        description: 'Admin completed a task',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Activity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activity = activities[index];
            return ActivityItemWidget(activity: activity);
          },
        ),
      ],
    );
  }
}

class ActivityItem {
  final String date;
  final String time;
  final String description;

  ActivityItem({
    required this.date,
    required this.time,
    required this.description,
  });
}

class ActivityItemWidget extends StatelessWidget {
  final ActivityItem activity;

  const ActivityItemWidget({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date column
          Column(
            children: [
              SizedBox(
                width: 50,
                child: Text(
                  activity.date,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Timeline indicator
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(Icons.person),
              ),
            ],
          ),

          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  activity.description,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
