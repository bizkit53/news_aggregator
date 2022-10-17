import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_aggregator/logic/blocs/navigation_bar/navigation_bar_bloc.dart';
import 'package:news_aggregator/presentation/pages/main/categories_page.dart';
import 'package:news_aggregator/presentation/pages/main/feed_page.dart';
import 'package:news_aggregator/presentation/pages/main/saved_articles_page.dart';
import 'package:news_aggregator/presentation/widgets/helpers/custom_navigation_bar.dart';

/// Screen selector of main pages of the app
class MainPage extends StatelessWidget {
  /// Constructor
  const MainPage({super.key});

  List<Widget> get _pages => const [
        FeedPage(),
        CategoriesPage(),
        SavedArticlesPage(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: context.watch<NavigationBarBloc>().state.selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
