import 'package:flutter/cupertino.dart';
import 'package:jesusvlsco/features/recognition/widgets/dashboard_card.dart';

class gridview_card extends StatelessWidget {
  const gridview_card({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DashboardItem> items = [
      DashboardItem(
        icon: '📊',
        title: 'Promotion',
        color: const Color(0xFF8B7CF6),
      ),
      DashboardItem(
        icon: '💬',
        title: 'Well-Social',
        color: const Color(0xFFE0E7FF),
      ),
      DashboardItem(
        icon: '🎨',
        title: 'Creative',
        color: const Color(0xFFFEF3C7),
      ),
      DashboardItem(
        icon: '🏆',
        title: 'Employee of\nthe month',
        color: const Color(0xFFDDD6FE),
      ),
      DashboardItem(
        icon: '🤝',
        title: 'Outstanding\nservices',
        color: const Color(0xFFFED7AA),
      ),
      DashboardItem(
        icon: '⭐',
        title: 'Top performer',
        color: const Color(0xFFFEF3C7),
      ),
      DashboardItem(
        icon: '💡',
        title: 'Creative',
        color: const Color(0xFFFED7AA),
      ),
      DashboardItem(
        icon: '🎉',
        title: 'Happy Holiday',
        color: const Color(0xFFFFE4E6),
      ),
    ];

    return SizedBox(
      // Ensure the GridView takes up the necessary space
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.95,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return DashboardCard(item: item); // Your DashboardCard widget
        },
      ),
    );
  }
}
