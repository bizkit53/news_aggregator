import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/logic/utils/logger.dart';

/// Button popping current navigator page
class CustomBackButton extends StatelessWidget {
  /// Constructor
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    /// Log style customizer
    final Logger log = logger(CustomBackButton);

    return IconButton(
      onPressed: () {
        log.d('Back button pressed');
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back_ios_new),
    );
  }
}
