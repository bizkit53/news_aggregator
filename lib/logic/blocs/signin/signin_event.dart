// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  final String email;
  final String password;
  const SigninEvent(
    this.email,
    this.password,
  );

  @override
  List<Object> get props => [];
}

class SubmitSigninEvent extends SigninEvent {
  const SubmitSigninEvent(String email, String password)
      : super(email, password);
}
