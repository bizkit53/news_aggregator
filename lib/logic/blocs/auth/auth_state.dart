// ignore_for_file: public_member_api_docs

part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.user,
    this.error,
  });

  final User? user;
  final CustomError? error;

  @override
  List<Object?> get props => [user, error];
}

class AuthInitialState extends AuthState {
  const AuthInitialState() : super(user: null, error: null);
}

class AuthenticatedState extends AuthState {
  const AuthenticatedState({super.user}) : super(error: null);
}

class UnauthenticatedState extends AuthState {
  const UnauthenticatedState({super.user, super.error});
}

class SignInSubmitted extends UnauthenticatedState {
  const SignInSubmitted() : super(error: const CustomError());
}
