import 'package:flutter/material.dart';

/// Screen shown before app fully loads
class SplashPage extends StatelessWidget {
  /// Constructor
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
