import 'package:flutter/material.dart';
import 'package:news_aggregator/constans/sizes.dart';
import 'package:news_aggregator/constans/spacing.dart';
import 'package:news_aggregator/logic/utils/app_localizations_context.dart';
import 'package:validators/validators.dart';

/// Text form field for email
class EmailField extends StatelessWidget {
  /// Constructor
  const EmailField({
    super.key,
    required this.controller,
  });

  /// Text controller of email field
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingBottom15,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          labelText: context.loc.email,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return context.loc.emailCannotBeEmpty;
          }
          if (!isEmail(value)) {
            return context.loc.emailInvalid;
          }
          return null;
        },
      ),
    );
  }
}
