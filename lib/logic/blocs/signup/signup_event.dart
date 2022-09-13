// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  final String name;
  final String email;
  final String password;

  const SignupEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}

class SubmitSignupEvent extends SignupEvent {
  const SubmitSignupEvent(
      {required String name, required String email, required String password})
      : super(name: name, email: email, password: password);
}
