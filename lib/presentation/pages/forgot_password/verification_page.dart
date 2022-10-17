import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/constans/import_constants.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/logic/utils/import_utils.dart';
import 'package:news_aggregator/presentation/widgets/import_widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/// Firebase reset password code verification page
class VerificationPage extends StatelessWidget {
  /// Constructor
  const VerificationPage({
    super.key,
    this.authRepository,
  });

  /// Firebase authentification handler
  final AuthRepository? authRepository;

  @override
  Widget build(BuildContext context) {
    /// Log style customizer
    final Logger log = logger(VerificationPage);
    // TODO(piotr-ciuba): use authRepository to verify and resend code
    // ignore: unused_local_variable
    final AuthRepository authRepository = this.authRepository ??
        locator.get<AuthRepository>(
          param1: locator.get<FirebaseFirestore>(),
          param2: locator.get<FirebaseAuth>(),
        );

    return CustomScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          // back button
          const Align(
            alignment: Alignment.topLeft,
            child: CustomBackButton(),
          ),
          // OTP verification headline text
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Padding(
                padding: paddingBottom15,
                child: Text(
                  context.loc.verification,
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                context.loc.verificationDescription,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          // verify button
          Wrap(
            children: [
              PinCodeTextField(
                appContext: context,
                length: pinCodeLength,
                onChanged: (String pinCode) {},
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(borderRadius),
                  fieldHeight: pinCodeSquareSize,
                  fieldWidth: pinCodeSquareSize,
                  inactiveColor: Theme.of(context).primaryColor,
                ),
              ),
              CustomWideButton(
                child: Text(context.loc.verify),
                onPressed: () {
                  log.d('Verify button pressed');
                  // TODO(piotr-ciuba): implement verification
                },
              ),
            ],
          ),
          const SizedBox(),
          // resend code
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.loc.noCode),
              TextButton(
                onPressed: () {
                  log.d('resend code button pressed');
                  // TODO(piotr-ciuba): implement resend code
                },
                child: Text(context.loc.resend),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
