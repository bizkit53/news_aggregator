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
import 'package:news_aggregator/logic/utils/password_field_helper.dart';
import 'package:news_aggregator/presentation/widgets/alternative_login_header.dart';
import 'package:news_aggregator/presentation/widgets/confirm_password_field.dart';
import 'package:news_aggregator/presentation/widgets/custom_back_button.dart';
import 'package:news_aggregator/presentation/widgets/custom_scaffold.dart';
import 'package:news_aggregator/presentation/widgets/custom_wide_button.dart';
import 'package:news_aggregator/presentation/widgets/email_field.dart';
import 'package:news_aggregator/presentation/widgets/google_login_button.dart';
import 'package:news_aggregator/presentation/widgets/password_field.dart';
import 'package:provider/provider.dart';

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
  final TextEditingController confirmPasswordController =
      TextEditingController();
  late final AuthRepository authRepository;

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
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PasswordFieldHelper>(
      create: (_) => PasswordFieldHelper(),
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
                  EmailField(controller: emailController),
                  PasswordField(controller: passwordController),
                  ConfirmPasswordField(controller: confirmPasswordController),
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
      ),
    );
  }
}
