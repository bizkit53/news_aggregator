// ignore_for_file: public_member_api_docs

part of 'password_bloc.dart';

abstract class PasswordState extends Equatable {
  const PasswordState({
    this.isHidden = true,
    this.isPasswordValid = false,
    this.isConfirmPasswordValid = false,
  });

  final bool isHidden;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;

  @override
  List<Object> get props => [
        isHidden,
        isPasswordValid,
        isConfirmPasswordValid,
      ];
}

class PasswordInitial extends PasswordState {}

class PasswordFieldChanged extends PasswordState {
  const PasswordFieldChanged({
    required super.isHidden,
    required super.isPasswordValid,
    required super.isConfirmPasswordValid,
  });
}
