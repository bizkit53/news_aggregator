// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs

part of 'password_bloc.dart';

abstract class PasswordEvent extends Equatable {
  const PasswordEvent();

  @override
  List<Object> get props => [];
}

class PasswordVisibilityChangedEvent extends PasswordEvent {}

class PasswordValidationEvent extends PasswordEvent {
  const PasswordValidationEvent({
    required this.password,
  });

  final String password;

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordValidationEvent extends PasswordEvent {
  const ConfirmPasswordValidationEvent({
    required this.password,
    required this.confirmPassword,
  });

  final String password;
  final String confirmPassword;

  @override
  List<Object> get props => [password, confirmPassword];
}
