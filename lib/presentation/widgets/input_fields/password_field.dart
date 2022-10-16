import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_aggregator/constans/import_constants.dart';
import 'package:news_aggregator/logic/blocs/password/password_bloc.dart';
import 'package:news_aggregator/logic/utils/import_utils.dart';

/// Text form field for password
class PasswordField extends StatelessWidget {
  /// Constructor
  const PasswordField({
    super.key,
    required this.controller,
    this.settingNewPassword = false,
  });

  /// Text controller of password field
  final TextEditingController controller;

  /// Whether the password field is used to set a new password
  final bool settingNewPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingBottom15,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            onPressed: () {
              context.read<PasswordBloc>().add(
                    PasswordVisibilityChangedEvent(),
                  );
            },
            icon: Icon(
              context.watch<PasswordBloc>().state.isHidden
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
          ),
          labelText: settingNewPassword
              ? context.loc.newPassword
              : context.loc.password,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        obscureText: context.watch<PasswordBloc>().state.isHidden,
        validator: (String? value) {
          context.read<PasswordBloc>().add(
                PasswordValidationEvent(password: value ?? ''),
              );
          if (!context.read<PasswordBloc>().state.isPasswordValid) {
            return context.loc.passwordNotValid;
          }
          return null;
        },
      ),
    );
  }
}
