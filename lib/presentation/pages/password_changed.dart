import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/constans/import_constants.dart';
import 'package:news_aggregator/logic/utils/import_utils.dart';
import 'package:news_aggregator/presentation/widgets/import_widgets.dart';

/// Page shown after password change
class PasswordChangedPage extends StatelessWidget {
  /// Constructor
  const PasswordChangedPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// Log style customizer
    final Logger log = logger(PasswordChangedPage);

    return CustomScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          // back button
          const Align(
            alignment: Alignment.topLeft,
            child: CustomBackButton(),
          ),
          Transform.scale(
            scale: 0.75.r,
            child: Image.asset(successMarkPath),
          ),
          // password changed headline text
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Padding(
                padding: paddingBottom15,
                child: Text(
                  context.loc.passwordChanged,
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                context.loc.passwordChangedDescription,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          CustomWideButton(
            child: Text(context.loc.backToLogin),
            onPressed: () {
              log.d('Back to login button pressed');
              Navigator.pushReplacementNamed(context, loginRoute);
            },
          ),
          const SizedBox(),
          const SizedBox(),
          const SizedBox(),
        ],
      ),
    );
  }
}
