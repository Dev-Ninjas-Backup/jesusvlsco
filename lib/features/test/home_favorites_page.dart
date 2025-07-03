import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeFavoritesPage extends StatefulWidget {
  const HomeFavoritesPage({super.key});

  @override
  State<HomeFavoritesPage> createState() => _HomeFavoritesPageState();
}

class _HomeFavoritesPageState extends State<HomeFavoritesPage> {
  final List<String> favorites = [
    'Flutter Development',
    'Dart Programming',
    'Mobile App Design',
    'UI/UX Principles',
    'State Management',
    'API Integration',
    'Database Management',
    'Testing Strategies',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No favorites yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.favorite, color: Colors.red),
                    title: Text(favorites[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          favorites.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Removed from favorites'),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            favorites.add('New Favorite ${favorites.length + 1}');
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
