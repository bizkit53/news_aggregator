import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_aggregator/constans/import_constants.dart';
import 'package:news_aggregator/logic/blocs/navigation_bar/navigation_bar_bloc.dart';

/// Bottom navigation bar with custom style
class CustomNavigationBar extends StatelessWidget {
  /// Constructor
  const CustomNavigationBar({
    super.key,
  });

  List<IconData> get _iconlist {
    return const [
      Icons.home_outlined,
      Icons.category_outlined,
      Icons.bookmark_border_outlined,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
      icons: _iconlist,
      activeIndex: context.watch<NavigationBarBloc>().state.selectedIndex,
      activeColor: Theme.of(context).primaryColor,
      gapLocation: GapLocation.none,
      leftCornerRadius: navBarCornerRadius,
      rightCornerRadius: navBarCornerRadius,
      onTap: (int index) {
        context.read<NavigationBarBloc>().add(
              IndexChangedEvent(index: index),
            );
      },
    );
  }
}
