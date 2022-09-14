// ignore_for_file: public_member_api_docs

part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState(
    this.error,
  );

  final CustomError error;

  @override
  List<Object> get props => [error];
}

class SignupInitial extends SignupState {
  const SignupInitial() : super(const CustomError());
}

class SignupSubmitted extends SignupState {
  const SignupSubmitted() : super(const CustomError());
}

class SignupSuccess extends SignupState {
  const SignupSuccess() : super(const CustomError());
}

class SignupFailed extends SignupState {
  const SignupFailed(CustomError error) : super(error);
}
