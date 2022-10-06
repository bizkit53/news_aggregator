import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/constans/paths.dart';
import 'package:news_aggregator/constans/sizes.dart';
import 'package:news_aggregator/constans/spacing.dart';
import 'package:news_aggregator/logic/utils/app_localizations_context.dart';
import 'package:news_aggregator/logic/utils/logger.dart';
import 'package:news_aggregator/presentation/widgets/custom_back_button.dart';
import 'package:news_aggregator/presentation/widgets/custom_scaffold.dart';
import 'package:news_aggregator/presentation/widgets/custom_wide_button.dart';
import 'package:news_aggregator/presentation/widgets/email_field.dart';

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
  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
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
                // email field
                EmailField(context: context, controller: emailController),
                // password field
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                    labelText: context.loc.password,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  ),
                  obscureText: hidePassword,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return context.loc.passwordCannotBeEmpty;
                    }
                    return null;
                  },
                ),
                // forgot password button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    // TODO(bizkit53): implement forgot password button
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
                    // TODO(bizkit53): implement login
                  }
                },
              ),
              Padding(
                padding: paddingBottom15,
                child: Center(
                  child: Text(context.loc.orLoginWith),
                ),
              ),
              // TODO(bizkit53): implement google login
              CustomWideButton(
                child: Transform.scale(
                  scale: 0.75.r,
                  child: Image.asset(
                    googleLogoTransparentPath,
                  ),
                ),
              ),
            ],
          ),
          // register button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.loc.noAccountYet),
              TextButton(
                // TODO(bizkit53): implement register button
                onPressed: () {},
                child: Text(context.loc.registerNow),
              ),
            ],
          )
        ],
      ),
    );
  }
}
