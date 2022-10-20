import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/logic/utils/import_utils.dart';

part 'password_event.dart';
part 'password_state.dart';

/// Helper for password and confirm password fields
class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  /// Constructor
  PasswordBloc() : super(PasswordInitial()) {
    on<PasswordVisibilityChangedEvent>(_passwordVisibilityChanged);
    on<PasswordValidationEvent>(_passwordValidation);
    on<ConfirmPasswordValidationEvent>(_confirmPasswordValidation);
  }

  FutureOr<void> _passwordVisibilityChanged(
    PasswordVisibilityChangedEvent event,
    Emitter<PasswordState> emit,
  ) {
    _log.i('$PasswordVisibilityChangedEvent called');
    emit(
      PasswordFieldChanged(
        isHidden: !state.isHidden,
        isPasswordValid: state.isPasswordValid,
        isConfirmPasswordValid: state.isConfirmPasswordValid,
      ),
    );
    _log.i('$PasswordFieldChanged emitted');
  }

  FutureOr<void> _passwordValidation(
    PasswordValidationEvent event,
    Emitter<PasswordState> emit,
  ) {
    _log.i('$PasswordValidationEvent called');
    emit(
      PasswordFieldChanged(
        isHidden: state.isHidden,
        isPasswordValid: _validatePassword(password: event.password),
        isConfirmPasswordValid: state.isConfirmPasswordValid,
      ),
    );
    _log.i('$PasswordFieldChanged emitted');
  }

  FutureOr<void> _confirmPasswordValidation(
    ConfirmPasswordValidationEvent event,
    Emitter<PasswordState> emit,
  ) {
    _log.i('$ConfirmPasswordValidationEvent called');
    emit(
      PasswordFieldChanged(
        isHidden: !state.isHidden,
        isPasswordValid: _validatePassword(password: event.password),
        isConfirmPasswordValid: _validateConfirmPassword(
          password: event.password,
          confirmPassword: event.confirmPassword,
        ),
      ),
    );
    _log.i('$PasswordFieldChanged emitted');
  }

  /// Log style customizer
  final Logger _log = logger(PasswordBloc);

  bool _validatePassword({required String password}) {
    final bool hasRightLength = password.length >= 8 && password.length <= 20;
    final bool hasNumeric = password.contains(RegExp('[0-9]'));
    final bool hasLowerCase = password.contains(RegExp('(?:[^a-z]*[a-z]){1}'));
    final bool hasUpperCase = password.contains(RegExp('(?:[^A-Z]*[A-Z]){1}'));

    return hasRightLength && hasNumeric && hasLowerCase && hasUpperCase;
  }

  bool _validateConfirmPassword({
    required String password,
    required String confirmPassword,
  }) {
    bool result = true;
    if (confirmPassword.isEmpty || password != confirmPassword) result = false;

    return result;
  }
}
