import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/constans/import_constants.dart';
import 'package:news_aggregator/logic/blocs/password/password_bloc.dart';
import 'package:news_aggregator/logic/utils/import_utils.dart';
import 'package:news_aggregator/presentation/widgets/import_widgets.dart';

/// Page for setting new password for user's account
class NewPasswordPage extends StatefulWidget {
  /// Constructor
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  /// Log style customizer
  final Logger log = logger(NewPasswordPage);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            // back button
            const Align(
              alignment: Alignment.topLeft,
              child: CustomBackButton(),
            ),
            // create password headline text
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Padding(
                  padding: paddingBottom15,
                  child: Text(
                    context.loc.createNewPassword,
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  context.loc.createNewPasswordDescription,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Form(
              key: formKey,
              child: Wrap(
                children: [
                  PasswordField(
                    controller: passwordController,
                    settingNewPassword: true,
                  ),
                  ConfirmPasswordField(
                    controller: confirmPasswordController,
                    passwordController: passwordController,
                  ),
                  // reset password button
                  CustomWideButton(
                    child: Text(context.loc.resetPassword),
                    onPressed: () {
                      log.d('Reset password button pressed');
                      if (formKey.currentState!.validate()) {
                        log.d('Form is valid');
                        // TODO(piotr-ciuba): implement new password setting
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
