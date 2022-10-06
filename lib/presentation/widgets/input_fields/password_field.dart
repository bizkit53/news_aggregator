import 'package:flutter/material.dart';
import 'package:news_aggregator/constans/import_constants.dart';
import 'package:news_aggregator/logic/utils/import_utils.dart';
import 'package:provider/provider.dart';

/// Text form field for password
class PasswordField extends StatelessWidget {
  /// Constructor
  const PasswordField({
    super.key,
    required this.controller,
  });

  /// Text controller of password field
  final TextEditingController controller;

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
              context.read<PasswordFieldHelper>().toggleVisibility();
            },
            icon: Icon(
              context.watch<PasswordFieldHelper>().isHidden
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
          ),
          labelText: context.loc.password,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        obscureText: context.watch<PasswordFieldHelper>().isHidden,
        validator: (String? value) {
          // TODO(bizkit53): extend password validation
          if (value == null || value.isEmpty) {
            return context.loc.passwordCannotBeEmpty;
          }
          return null;
        },
      ),
    );
  }
}
