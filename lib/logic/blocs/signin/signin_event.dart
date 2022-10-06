// ignore_for_file: public_member_api_docs

part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class SubmitSigninEvent extends SigninEvent {
  const SubmitSigninEvent({required super.email, required super.password});
}
