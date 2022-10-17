import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_aggregator/constans/import_constants.dart';
import 'package:news_aggregator/logic/blocs/password/password_bloc.dart';
import 'package:news_aggregator/logic/utils/import_utils.dart';

/// Text form field for confirm password
class ConfirmPasswordField extends StatelessWidget {
  /// Constructor
  const ConfirmPasswordField({
    super.key,
    required this.controller,
    required this.passwordController,
  });

  /// Text controller of confirm password field
  final TextEditingController controller;

  /// Text controller of password field for validating purposes
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingBottom15,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          labelText: context.loc.confirmPassword,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(circularBorderRadius),
          ),
        ),
        obscureText: context.watch<PasswordBloc>().state.isHidden,
        validator: (String? value) {
          context.read<PasswordBloc>().add(
                ConfirmPasswordValidationEvent(
                  password: value ?? '',
                  confirmPassword: passwordController.text,
                ),
              );
          if (!context.read<PasswordBloc>().state.isConfirmPasswordValid) {
            return context.loc.passwordDoNotMatch;
          }
          return null;
        },
      ),
    );
  }
}
