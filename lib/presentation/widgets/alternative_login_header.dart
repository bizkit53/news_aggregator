import 'package:flutter/material.dart';
import 'package:news_aggregator/constans/spacing.dart';
import 'package:news_aggregator/logic/utils/app_localizations_context.dart';

/// Header for alternative login options
class AlternativeLoginHeader extends StatelessWidget {
  /// Constructor
  const AlternativeLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingBottom15,
      child: Center(
        child: Text(context.loc.orLoginWith),
      ),
    );
  }
}
