import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _tab = 0;
  
  static const _notifications = [
    ('Sarah Johnson', 0xFF2D3748),
    ('Marvin McKinney', 0xFFB7791F),
    ('Kristin Watson', 0xFF2D3748),
    ('Esther Howard', 0xFF047857),
    ('Arlene McCoy', 0xFF2D3748),
    ('Kristin Watson', 0xFF2D3748),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFFAFAFA),
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: _TabBar(
        selected: _tab,
        onTap: (i) => setState(() => _tab = i),
      ),
    ),
    body: ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _notifications.length,
      separatorBuilder: (_, __) => Container(
        height: 1,
        color: const Color(0xFFE5E7EB),
        margin: const EdgeInsets.only(left: 72),
      ),
      itemBuilder: (_, i) => _NotificationTile(_notifications[i]),
    ),
  );
}

class _TabBar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onTap;
  
  const _TabBar({required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) => Container(
    height: 36,
    decoration: BoxDecoration(
      color: const Color(0xFFF8F9FA),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        for (int i = 0; i < 3; i++)
          Expanded(
            child: GestureDetector(
              onTap: () => onTap(i),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: selected == i ? const Color(0xFF4F46E5) : null,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    ['All', 'Unread', 'Team'][i],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: selected == i ? FontWeight.w500 : FontWeight.w400,
                      color: selected == i ? Colors.white : const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

class _NotificationTile extends StatelessWidget {
  final (String, int) data;
  
  const _NotificationTile(this.data);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    color: Colors.white,
    child: Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Color(data.$2),
          child: Text(
            data.$1.split(' ').map((e) => e[0]).join().toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.$1,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
              const Text(
                'Thanks for the project...',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '2 min ago',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF9CA3AF),
              ),
            ),
            SizedBox(height: 4),
            CircleAvatar(
              radius: 4,
              backgroundColor: Color(0xFFEF4444),
            ),
          ],
        ),
      ],
    ),
  );
}