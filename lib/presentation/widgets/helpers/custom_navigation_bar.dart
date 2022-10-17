import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_aggregator/constans/import_constants.dart';
import 'package:news_aggregator/logic/blocs/navigation_bar/navigation_bar_bloc.dart';
import 'package:news_aggregator/logic/utils/import_utils.dart';

/// Bottom navigation bar with custom style
class CustomNavigationBar extends StatelessWidget {
  /// Constructor
  const CustomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: context.watch<NavigationBarBloc>().state.selectedIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Theme.of(context).colorScheme.onPrimary,
      unselectedItemColor: Theme.of(context)
          .colorScheme
          .onPrimary
          .withOpacity(navBarIconOpacity),
      onTap: (int index) {
        context.read<NavigationBarBloc>().add(
              IndexChangedEvent(index: index),
            );
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
    );
  }
}
