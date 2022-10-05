import 'package:flutter/material.dart';
import 'package:news_aggregator/constans/paths.dart';
import 'package:news_aggregator/logic/utils/app_localizations_context.dart';
import 'package:news_aggregator/presentation/widgets/custom_scaffold.dart';
import 'package:news_aggregator/presentation/widgets/custom_wide_button.dart';

/// Page shown before login or register page
class WelcomePage extends StatelessWidget {
  /// Constructor
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(logoTransparentPath),
          Wrap(
            children: [
              // TODO(bizkit53): implement onPressed
              CustomWideButton(
                child: Text(context.loc.login),
              ),
              // TODO(bizkit53): implement onPressed
              CustomWideButton(
                child: Text(context.loc.register),
              ),
            ],
          ),
          TextButton(
            // TODO(bizkit53): implement onPressed
            onPressed: () {},
            child: Text(context.loc.continueAsGuest),
          )
        ],
      ),
    );
  }
}
