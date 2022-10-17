import 'package:flutter/material.dart';
import 'package:news_aggregator/constans/sizes.dart';
import 'package:news_aggregator/logic/utils/import_utils.dart';
import 'package:news_aggregator/presentation/pages/main/categories_page.dart';
import 'package:news_aggregator/presentation/pages/main/feed_page.dart';
import 'package:news_aggregator/presentation/pages/main/saved_articles_page.dart';

/// Screen selector of main pages of the app
class MainPage extends StatefulWidget {
  /// Constructor
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const FeedPage(),
    const CategoriesPage(),
    const SavedArticlesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(context)
            .colorScheme
            .onPrimary
            .withOpacity(navBarIconOpacity),
        onTap: (int index) {
          setState(() => _selectedIndex = index);
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: context.loc.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.category),
            label: context.loc.categories,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bookmark),
            label: context.loc.saved,
          ),
        ],
      ),
    );
  }
}
