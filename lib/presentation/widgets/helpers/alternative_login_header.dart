import 'package:flutter/material.dart';
import 'package:news_aggregator/constans/import_constants.dart';
import 'package:news_aggregator/logic/utils/import_utils.dart';

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
