import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/constans/sizes.dart';
import 'package:news_aggregator/constans/spacing.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/logic/utils/app_localizations_context.dart';
import 'package:news_aggregator/logic/utils/injector.dart';
import 'package:news_aggregator/logic/utils/logger.dart';
import 'package:news_aggregator/presentation/widgets/alternative_login_header.dart';
import 'package:news_aggregator/presentation/widgets/custom_back_button.dart';
import 'package:news_aggregator/presentation/widgets/custom_scaffold.dart';
import 'package:news_aggregator/presentation/widgets/custom_wide_button.dart';
import 'package:news_aggregator/presentation/widgets/email_field.dart';
import 'package:news_aggregator/presentation/widgets/google_login_button.dart';

/// Page shown before login or register page
class RegisterPage extends StatefulWidget {
  /// Constructor
  const RegisterPage({
    super.key,
    this.authRepository,
  });

  /// Firebase authentification handler
  final AuthRepository? authRepository;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  /// Log style customizer
  final Logger log = logger(RegisterPage);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late final AuthRepository authRepository;
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    authRepository = widget.authRepository ??
        locator.get<AuthRepository>(
          param1: locator.get<FirebaseFirestore>(),
          param2: locator.get<FirebaseAuth>(),
        );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
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
                // username field
                Padding(
                  padding: paddingBottom15,
                  child: TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      labelText: context.loc.username,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return context.loc.usernameCannotBeEmpty;
                      }
                      return null;
                    },
                  ),
                ),
                // email field
                EmailField(context: context, controller: emailController),
                // password field
                Padding(
                  padding: paddingBottom15,
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
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
                ),
                // confirm password field
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    labelText: context.loc.confirmPassword,
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
              ],
            ),
          ),
          // login buttons
          Wrap(
            children: [
              CustomWideButton(
                child: Text(context.loc.register),
                onPressed: () {
                  log.d('Register button pressed');
                  if (formKey.currentState!.validate()) {
                    log.d('Form is valid');
                    authRepository.signUp(
                      name: usernameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    // TODO(bizkit53): implement UI feedback
                  }
                },
              ),
              const AlternativeLoginHeader(),
              const GoogleLoginButton(),
            ],
          ),
        ],
      ),
    );
  }
}
