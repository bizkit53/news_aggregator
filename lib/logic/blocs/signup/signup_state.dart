part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  final CustomError error;
  const SignupState(
    this.error,
  );

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
