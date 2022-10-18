import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/constans/import_constants.dart';
import 'package:news_aggregator/logic/blocs/password/password_bloc.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/logic/utils/import_utils.dart';
import 'package:news_aggregator/presentation/widgets/import_widgets.dart';

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
            // register form
            Form(
              key: formKey,
              child: Wrap(
                children: [
                  _usernameField(context),
                  EmailField(controller: emailController),
                  PasswordField(controller: passwordController),
                  ConfirmPasswordField(
                    controller: confirmPasswordController,
                    passwordController: passwordController,
                  ),
                ],
              ),
            ),
            // register buttons
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
                      // TODO(piotr-ciuba): implement UI feedback
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

  Padding _usernameField(BuildContext context) {
    return Padding(
      padding: paddingBottom15,
      child: TextFormField(
        controller: usernameController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          labelText: context.loc.username,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(circularBorderRadius),
          ),
        ),
        validator: (String? value) {
          // TODO(piotr-ciuba): implement username validation
          if (value == null || value.isEmpty) {
            return context.loc.usernameCannotBeEmpty;
          }
          return null;
        },
      ),
    );
  }
}
