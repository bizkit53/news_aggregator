import 'package:flutter/material.dart';
import 'package:news_aggregator/constans/import_constants.dart';

/// Reusable button taking full width of the screen
class CustomWideButton extends StatelessWidget {
  /// Constructor
  const CustomWideButton({
    super.key,
    required this.child,
    this.onPressed,
  });

  /// Child widget of the button
  final Widget child;

  /// On pressed callback
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingBottom15,
      child: SizedBox(
        height: wideButtonHeight,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(circularBorderRadius),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
