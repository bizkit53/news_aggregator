import 'package:flutter/material.dart';
import 'package:news_aggregator/constans/import_constants.dart';
import 'package:news_aggregator/logic/utils/import_utils.dart';
import 'package:news_aggregator/presentation/widgets/import_widgets.dart';

/// Page for choosing categories of news to show
class CategoriesPage extends StatelessWidget {
  /// Constructor
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categoryNames = _getCategories();
    final List<bool> isSelected =
        List.filled(NewsCategories.values.length, false);
    // TODO(piotr-ciuba): add logic for selecting categories

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: paddingHorizontal12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomBackButton(),
                  // TODO(piotr-ciuba): implement skip button
                  Chip(
                    label: Text(context.loc.skip),
                  ),
                ],
              ),
              Padding(
                padding: paddingBottom15,
                child: Text(
                  context.loc.chooseTopic,
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: categoryGridCrossAxisCount,
                  children: [
                    for (int i = 0; i < categoryNames.length; i++)
                      _categoryTile(
                        name: categoryNames[i],
                        isSelected: isSelected[i],
                        context: context,
                      ),
                  ],
                ),
              ),
              CustomWideButton(
                child: Text(context.loc.continueAction),
                onPressed: () {},
                // TODO(piotr-ciuba): Add logic for saving categories
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _categoryTile({
    required String name,
    required bool isSelected,
    required BuildContext context,
  }) {
    return Padding(
      padding: paddingAll8,
      child: DecoratedBox(
        decoration: _tileBoxDecoration(isSelected, context),
        child: Transform.scale(
          scale: smallImageScale,
          child: Column(
            children: [
              Flexible(
                child: Image.asset(
                  '$categoryBasePath$name.png',
                ),
              ),
              Text(
                name,
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _tileBoxDecoration(bool isSelected, BuildContext context) {
    return BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: isSelected
            ? Theme.of(context).primaryColor
            : Theme.of(context).disabledColor,
        width: categoryBorderWith,
      ),
      color: isSelected
          ? Theme.of(context)
              .primaryColor
              .withOpacity(categoryBackgroundOpacity)
          : null,
    );
  }

  List<String> _getCategories() {
    final List<String> categories = [];
    for (int i = 0; i < NewsCategories.values.length; i++) {
      categories.add(NewsCategories.values[i].toString().split('.').last);
    }
    return categories;
  }
}
