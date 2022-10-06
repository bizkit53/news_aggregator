import 'package:flutter/material.dart';
import 'package:news_aggregator/constans/sizes.dart';
import 'package:news_aggregator/constans/spacing.dart';
import 'package:news_aggregator/logic/utils/app_localizations_context.dart';
import 'package:news_aggregator/logic/utils/password_field_helper.dart';
import 'package:provider/provider.dart';

/// Text form field for confirm password
class ConfirmPasswordField extends StatelessWidget {
  /// Constructor
  const ConfirmPasswordField({
    super.key,
    required this.controller,
  });

  /// Text controller of confirm password field
  final TextEditingController controller;

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
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        obscureText: context.watch<PasswordFieldHelper>().isHidden,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return context.loc.passwordCannotBeEmpty;
          }
          return null;
        },
      ),
    );
  }
}
