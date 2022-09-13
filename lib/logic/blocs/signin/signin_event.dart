// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  final String email;
  final String password;
  const SigninEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SubmitSigninEvent extends SigninEvent {
  const SubmitSigninEvent({required String email, required String password})
      : super(email: email, password: password);
}
