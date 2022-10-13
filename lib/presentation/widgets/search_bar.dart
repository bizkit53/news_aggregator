import 'package:flutter/material.dart';
import 'package:news_aggregator/constans/import_constants.dart';
import 'package:news_aggregator/logic/utils/import_utils.dart';
import 'package:news_aggregator/presentation/widgets/import_widgets.dart';

/// Widget used for filtering news by title
class SearchBar extends StatelessWidget {
  /// Constructor
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingHor24Ver10,
      child: DecoratedBox(
        decoration: customBoxDecoration(
          context: context,
          borderRadius: circularBorderRadius,
          border: Border.all(
            color: Theme.of(context).disabledColor.withOpacity(borderOpacity),
          ),
        ),
        child: Row(
          children: [
            boxWidth10,
            Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.secondary,
            ),
            boxWidth10,
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: context.loc.search,
                  hintStyle: TextStyle(
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
