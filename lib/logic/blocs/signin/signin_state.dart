// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'signin_bloc.dart';

abstract class SigninState extends Equatable {
  final CustomError error;
  const SigninState(
    this.error,
  );

  @override
  List<Object> get props => [error];
}

class SigninInitial extends SigninState {
  const SigninInitial() : super(const CustomError());
}

class SigninSubmitted extends SigninState {
  const SigninSubmitted() : super(const CustomError());
}

class SigninSuccess extends SigninState {
  const SigninSuccess() : super(const CustomError());
}

class SigninFailed extends SigninState {
  const SigninFailed(CustomError error) : super(error);
}
