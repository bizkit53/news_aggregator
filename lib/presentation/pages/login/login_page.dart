import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/logic/blocs/password/password_bloc.dart';
import 'package:news_aggregator/logic/utils/import_utils.dart';
import 'package:news_aggregator/presentation/widgets/import_widgets.dart';

/// Page shown before login or register page
class LoginPage extends StatefulWidget {
  /// Constructor
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// Log style customizer
  final Logger log = logger(LoginPage);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordBloc(),
      child: CustomScaffold(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // back button
            const Align(
              alignment: Alignment.topLeft,
              child: CustomBackButton(),
            ),
            // welcome text
            Text(
              context.loc.welcome,
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            // login form
            Form(
              key: formKey,
              child: Wrap(
                children: [
                  EmailField(controller: emailController),
                  PasswordField(controller: passwordController),
                  // forgot password button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      // TODO(piotr-ciuba): implement forgot password button
                      onPressed: () {},
                      child: Text(context.loc.forgotPassword),
                    ),
                  ),
                ],
              ),
            ),
            // login buttons
            Wrap(
              children: [
                CustomWideButton(
                  child: Text(context.loc.login),
                  onPressed: () {
                    log.d('Login button pressed');
                    if (formKey.currentState!.validate()) {
                      log.d('Form is valid');
                      // TODO(piotr-ciuba): implement login
                    }
                  },
                ),
                const AlternativeLoginHeader(),
                const GoogleLoginButton(),
              ],
            ),
            // register button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(context.loc.noAccountYet),
                TextButton(
                  // TODO(piotr-ciuba): implement register button
                  onPressed: () {},
                  child: Text(context.loc.registerNow),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
