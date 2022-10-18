import 'package:flutter/material.dart';
import 'package:news_aggregator/constans/import_constants.dart';

/// Shortcut for decoration with border radius
BoxDecoration customBoxDecoration({
  required BuildContext context,
  required double borderRadius,
  Border? border,
}) {
  return BoxDecoration(
    color: Theme.of(context).cardColor,
    borderRadius: BorderRadius.circular(borderRadius),
    border: border,
    boxShadow: [
      BoxShadow(
        color: Theme.of(context).disabledColor,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        offset: shadowOffset,
      ),
    ],
  );
}
