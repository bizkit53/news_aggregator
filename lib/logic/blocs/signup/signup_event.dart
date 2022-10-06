// ignore_for_file: public_member_api_docs

part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;

  @override
  List<Object> get props => [name, email, password];
}

class SubmitSignupEvent extends SignupEvent {
  const SubmitSignupEvent({
    required super.name,
    required super.email,
    required super.password,
  });
}
