import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'password_event.dart';
part 'password_state.dart';

/// Helper for password and confirm password fields
class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  /// Constructor
  PasswordBloc() : super(PasswordInitial()) {
    on<PasswordVisibilityChangedEvent>((event, emit) {
      emit(
        PasswordFieldChanged(
          isHidden: !state.isHidden,
          isPasswordValid: state.isPasswordValid,
          isConfirmPasswordValid: state.isConfirmPasswordValid,
        ),
      );
    });

    on<PasswordValidationEvent>((event, emit) {
      emit(
        PasswordFieldChanged(
          isHidden: state.isHidden,
          isPasswordValid: _validatePassword(password: event.password),
          isConfirmPasswordValid: state.isConfirmPasswordValid,
        ),
      );
    });

    on<ConfirmPasswordValidationEvent>((event, emit) {
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
    });
  }

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
    if (password != confirmPassword) result = false;

    return result;
  }
}
