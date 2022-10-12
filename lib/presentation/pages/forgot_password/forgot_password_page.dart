import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/constans/import_constants.dart';
import 'package:news_aggregator/logic/utils/import_utils.dart';
import 'package:news_aggregator/presentation/widgets/import_widgets.dart';

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
          Form(
            key: formKey,
            child: Wrap(
              children: [
                EmailField(controller: emailController),
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
          // switch to login page
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.loc.rememberPassword),
              TextButton(
                onPressed: () {
                  log.d('Switch to login page button pressed');
                  Navigator.pushNamed(context, loginRoute);
                },
                child: Text(context.loc.login),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
