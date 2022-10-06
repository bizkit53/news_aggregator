import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/constans/routes.dart';
import 'package:news_aggregator/constans/spacing.dart';
import 'package:news_aggregator/logic/utils/app_localizations_context.dart';
import 'package:news_aggregator/logic/utils/logger.dart';
import 'package:news_aggregator/presentation/widgets/custom_back_button.dart';
import 'package:news_aggregator/presentation/widgets/custom_scaffold.dart';
import 'package:news_aggregator/presentation/widgets/custom_wide_button.dart';
import 'package:news_aggregator/presentation/widgets/email_field.dart';

/// Page shown before login or register page
class ForgotPasswordPage extends StatefulWidget {
  /// Constructor
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  /// Log style customizer
  final Logger log = logger(ForgotPasswordPage);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          // forgot password headline text
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Padding(
                padding: paddingBottom15,
                child: Text(
                  context.loc.forgotPassword,
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                context.loc.forgotPasswordDescription,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          // login form
          Form(
            key: formKey,
            child: Wrap(
              children: [
                // email field
                EmailField(context: context, controller: emailController),
                // send code buttons
                CustomWideButton(
                  child: Text(context.loc.sendCode),
                  onPressed: () {
                    log.d('Send code button pressed');
                    if (formKey.currentState!.validate()) {
                      log.d('Form is valid');
                      // TODO(bizkit53): implement password reset
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(),
          // switch to login
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.loc.rememberPassword),
              TextButton(
                onPressed: () {
                  log.d('Switch to login button pressed');
                  Navigator.pushNamed(context, loginRoute);
                },
                child: Text(context.loc.login),
              ),
            ],
          )
        ],
      ),
    );
  }
}
