import 'package:flutter/material.dart';
import 'package:news_aggregator/constans/import_constants.dart';

/// Shortcut for scaffold with padding
class CustomScaffold extends StatelessWidget {
  /// Constructor
  const CustomScaffold({
    super.key,
    required this.child,
  });

  /// Body of scaffold with padding
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: paddingHorizontal24,
          child: child,
        ),
      ),
    );
  }
}
